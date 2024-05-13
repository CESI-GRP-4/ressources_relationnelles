import React from 'react';
import type { Metadata } from 'next';

export const metadata: Metadata = {
       title: 'Historique des utilisateurs',
};
export default function RootLayout({ children }: { children: React.ReactNode }) {
       return (
              <>{children}</>
       );
}
