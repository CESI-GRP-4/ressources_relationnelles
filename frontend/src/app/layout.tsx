// layout.tsx (root layout)
import React from 'react';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import Providers from '@/providers/providers';
import '@/styles/globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
       title: 'Ressources relationnelles',
       description: 'CESI school project',
};

export default function RootLayout({
       children,
}: {
       children: React.ReactNode;
}) {
       return (
              <html lang="fr">
                     <body className={inter.className}>
                            <div className='border border-l-pink-500 border-pink-500 p-4 m-4 w-fit'>Layout of the app</div>
                            <Providers>{children}</Providers>
                     </body>
              </html>
       );
}
