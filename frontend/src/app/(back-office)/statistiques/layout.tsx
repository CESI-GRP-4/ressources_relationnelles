// layout.tsx (root layout)
import React from 'react';
import type { Metadata } from 'next';

export const metadata: Metadata = {
       title: 'Statistiques',
};

export default function RootLayout({
       children,
}: {
       children: React.ReactNode;
}) {
       return (
              <>
                     {children}
              </>
       );
}
