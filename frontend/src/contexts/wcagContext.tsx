"use client";
import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { useConsent } from './CookiesConsentContext';

// Define the shape of the WCAG context state
interface WCAGContextState {
       wcagEnabled: boolean;
       setWCAGEnabled: (enabled: boolean) => void;
}

// Create the context
const WCAGContext = createContext<WCAGContextState | undefined>(undefined);

// Create the provider component
export const WCAGProvider = ({ children }: { children: ReactNode }) => {
       const { consentStatus, storeData, retrieveData } = useConsent();

       const [wcagEnabled, setWcagEnabled] = useState<boolean>(false);

       useEffect(() => {
              const storedWCAGValue = retrieveData('wcag');
              if (storedWCAGValue !== null) {
                     setWcagEnabled(storedWCAGValue === 'true');
              }
       }, [retrieveData]);

       const setWCAGEnabled = (enabled: boolean) => {
              setWcagEnabled(enabled);
              storeData("wcag", String(enabled));
       };

       return (
              <WCAGContext.Provider value={{ wcagEnabled, setWCAGEnabled }}>
                     {children}
              </WCAGContext.Provider>
       );
};

// Create a custom hook for easy access to the WCAG context
export const useWCAG = (): WCAGContextState => {
       const context = useContext(WCAGContext);
       if (!context) {
              throw new Error('useWCAG must be used within a WCAGProvider');
       }
       return context;
};
