// layout.tsx
import React from 'react';
import type { Metadata } from 'next';

export const metadata: Metadata = {
       title: 'Statistiques - Connexions - Ressources relationnelles',
};

export default function Layout({
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
