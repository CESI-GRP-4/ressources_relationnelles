// UserContext.ts
import React, { createContext } from 'react';
import type User from '@/types/user';

// Updated to match the signature of your custom setUser function
interface UserContextProps {
    user: User | null;
    setUser: (userData: User | null, rememberMe?: boolean) => void; // Adjusted to match handleSetUser
}

const UserContext = createContext<UserContextProps | undefined>(undefined);
export default UserContext;