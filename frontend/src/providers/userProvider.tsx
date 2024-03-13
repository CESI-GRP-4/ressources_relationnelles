// userProvider.tsx
"use client"
import React, { useState, ReactNode, useContext, useEffect, useCallback } from 'react';
import UserContext from '@/contexts/userContext';
import User from '@/types/user';
import { useConsent } from '@/contexts/CookiesConsentContext';
import Cookies from 'js-cookie';

type UserProviderProps = {
       children: ReactNode;
}

export const UserProvider = ({ children }: UserProviderProps) => {
       const [user, setUser] = useState<User | null>(null);
       const { consentStatus } = useConsent();

       useEffect(() => {
              if (consentStatus === 'accepted') {
                     const storedUser = Cookies.get('user');
                     if (storedUser) {
                            setUser(JSON.parse(storedUser));
                     }
              }
              else {
                     const storedUser = sessionStorage.getItem('user');
                     if (storedUser) {
                            setUser(JSON.parse(storedUser));
                     }
              }
       }, [consentStatus]);

       const handleSetUser = useCallback((userData: User | null, rememberMe: boolean = false) => {
              setUser(userData); // Update state

              if (userData) {
                     console.log(consentStatus)
                     if (rememberMe && consentStatus === 'accepted') {
                            Cookies.set('user', JSON.stringify(userData), { expires: 365 });
                            sessionStorage.removeItem('user'); // Ensure user data is not duplicated in sessionStorage
                     } else {
                            sessionStorage.setItem('user', JSON.stringify(userData));
                            Cookies.remove('user'); // Ensure user data is not duplicated in localStorage
                     }
              } else {
                     Cookies.remove('user');
                     sessionStorage.removeItem('user');
              }
       }, []);

       useEffect(() => {
              if (user) {
                     if (consentStatus === 'accepted') {
                            Cookies.set('user', JSON.stringify(user));
                     } else {
                            sessionStorage.setItem('user', JSON.stringify(user));
                     }
              } else {
                     Cookies.remove('user');
                     sessionStorage.removeItem('user');
              }
       }, [user, consentStatus]);

       return (
              <UserContext.Provider value={{ user, setUser: handleSetUser }}>
                     {children}
              </UserContext.Provider>
       );
};

export const useUser = () => {
       const context = useContext(UserContext);
       if (context === undefined) {
              throw new Error('useUser must be used within a UserProvider');
       }
       return context;
};

export default UserProvider;
