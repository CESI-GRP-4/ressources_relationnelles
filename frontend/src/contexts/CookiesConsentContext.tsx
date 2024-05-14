"use client";
import React, { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import Cookies from 'js-cookie';

interface ConsentContextType {
       consentStatus: 'accepted' | 'declined' | 'not_set';
       setConsent: (status: 'accepted' | 'declined') => void;
       storeData: (name: string, value: any) => void;
       retrieveData: (name: string) => any;
}

const ConsentContext = createContext<ConsentContextType | undefined>(undefined);

export const useConsent = () => {
       const context = useContext(ConsentContext);
       if (context === undefined) {
              throw new Error('useConsent must be used within a ConsentProvider');
       }
       return context;
};

export const ConsentProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
       const [consentStatus, setConsentStatus] = useState<'accepted' | 'declined' | 'not_set'>('not_set');

       useEffect(() => {
              const cookieConsent = Cookies.get('cookieConsent');
              if (cookieConsent) {
                     setConsentStatus(cookieConsent === 'true' ? 'accepted' : 'declined');
              } else {
                     const sessionConsent = sessionStorage.getItem('cookieConsent');
                     setConsentStatus(sessionConsent === 'false' ? 'declined' : 'not_set');
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

       const storeData = (name: string, value: any) => {
              if (consentStatus === 'accepted') {
                     Cookies.set(name, value, { expires: 365 });
              } else if (consentStatus === 'declined') {
                     sessionStorage.setItem(name, value);
              }
       };

       const retrieveData = (name: string) => {
              if (consentStatus === 'accepted') {
                     return Cookies.get(name);
              } else if (consentStatus === 'declined') {
                     return sessionStorage.getItem(name);
              }
              return null;
       };

       return (
              <ConsentContext.Provider value={{ consentStatus, setConsent, storeData, retrieveData }}>
                     {children}
              </ConsentContext.Provider>
       );
};
