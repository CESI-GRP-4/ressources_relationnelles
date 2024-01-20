// UserContext.ts
import React, { createContext } from 'react';
import type User from '@/types/user';

interface UserContextProps {
       user: User | null;
       setUser: React.Dispatch<React.SetStateAction<User | null>>;
}

const UserContext = createContext<UserContextProps | undefined>(undefined);
export default UserContext;