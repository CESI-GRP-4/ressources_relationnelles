// userProvider.tsx
"use client"
import React, { useState, ReactNode, useContext, useEffect } from 'react';
import UserContext from '@/contexts/userContext';
import User from '@/types/user';

type UserProviderProps = {
       children: ReactNode;
}

export const UserProvider = ({ children }: UserProviderProps) => {
       const [user, setUser] = useState<User | null>(null);

       // Effect to load the user from localStorage
       useEffect(() => {
              const savedUser = localStorage.getItem('user');
              if (savedUser) {
                     setUser(JSON.parse(savedUser));
              }
       }, []);

       // Effect to save the user to localStorage when it changes
       useEffect(() => {
              if (user) {
                     localStorage.setItem('user', JSON.stringify(user));
              } else {
                     localStorage.removeItem('user');
              }
       }, [user]);

       return (
              <UserContext.Provider value={{ user, setUser }}>
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
