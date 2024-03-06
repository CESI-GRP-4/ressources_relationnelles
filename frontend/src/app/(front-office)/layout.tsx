// layout.tsx (root layout)
"use client"
import React, { useState } from 'react';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import Providers from '@/providers/providers';
import '@/styles/globals.css';
import Header from '@/components/header';
import Footer from '@/components/footer';

const inter = Inter({ subsets: ['latin'] });

export default function RootLayout({
       children,
}: {
       children: React.ReactNode;
}) {
       const [collapsed, setCollapsed] = useState(true);

       return (
              <html lang="fr">
                     <body className={inter.className}>
                            <Providers>
                                   <Header collapsed={true} setCollapsed={setCollapsed} />
                                   {children}
                                   <Footer></Footer>
                            </Providers>
                     </body>
              </html>
       );
}