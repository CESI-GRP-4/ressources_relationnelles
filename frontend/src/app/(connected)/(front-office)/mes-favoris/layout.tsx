import React from 'react';
import type { Metadata } from 'next';

export const metadata: Metadata = {
       title: 'Mes favoris',
};
export default function RootLayout({ children }: { children: React.ReactNode }) {
       return (
              <>{children}</>
       );
}
