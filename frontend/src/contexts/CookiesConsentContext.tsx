"use client"
import React, { createContext, useContext, useEffect, useState } from 'react';
import Cookies from 'js-cookie';

interface ConsentContextType {
       consentStatus: 'accepted' | 'declined' | 'not_set';
       setConsent: (status: 'accepted' | 'declined') => void;
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

       return <ConsentContext.Provider value={{ consentStatus, setConsent }}>{children}</ConsentContext.Provider>;
};