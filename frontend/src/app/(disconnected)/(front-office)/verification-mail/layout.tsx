// /verify-mail/layout.tsx

import React from 'react';
import type { Metadata } from 'next';

export const metadata: Metadata = {
       title: 'Vérification du mail',
};
export default function RootLayout({children}: {children: React.ReactNode}) {
       return (
              <>{children}</>
       );
}
