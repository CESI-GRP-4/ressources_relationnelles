"use client"
import React, { createContext, useContext, useEffect, useState } from 'react';
import Cookies from 'js-cookie';

interface ConsentContextType {
    consentStatus: 'accepted' | 'declined' | 'not_set';
    setConsent: (status: 'accepted' | 'declined') => void;
    storeData: (key: string, value: string) => void; // Add a function type for storing data
}

const ConsentContext = createContext<ConsentContextType | undefined>(undefined);

export const useConsent = () => {
    const context = useContext(ConsentContext);
    if (context === undefined) {
        throw new Error('useConsent must be used within a ConsentProvider');
    }
    return context;
};

export const ConsentProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [consentStatus, setConsentStatus] = useState<'accepted' | 'declined' | 'not_set'>('not_set');

    useEffect(() => {
        const cookieConsent = Cookies.get('cookieConsent');
        if (cookieConsent) {
            if (cookieConsent === 'true') {
                setConsentStatus('accepted');
            }
        }
        else {
            const sessionConsent = sessionStorage.getItem('cookieConsent');
            if (sessionConsent === 'false') {
                setConsentStatus('declined');
            }
        }
    }, []);

    const setConsent = (status: 'accepted' | 'declined') => {
        if (status === 'accepted') {
            Cookies.set('cookieConsent', 'true', { expires: 365 });
            setConsentStatus('accepted');
        } else {
            sessionStorage.setItem('cookieConsent', 'false');
            setConsentStatus('declined');
        }
    };

    // Add the storeData function here
    const storeData = (key: string, value: string) => {
        if (consentStatus === 'accepted') {
            Cookies.set(key, value, { expires: 365 }); // Store in cookies for long-term storage
        } else {
            sessionStorage.setItem(key, value); // Store in session for current session only
        }
    };

    return <ConsentContext.Provider value={{ consentStatus, setConsent, storeData }}>{children}</ConsentContext.Provider>;
};
