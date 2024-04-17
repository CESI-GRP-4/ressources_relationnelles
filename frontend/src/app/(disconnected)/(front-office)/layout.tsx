// /connexion/layout.tsx

import React from 'react';
import type { Metadata } from 'next';
import { Card } from 'antd';
export const metadata: Metadata = {
       title: 'Ressources relationnelles',
};
export default function RootLayout({ children }: { children: React.ReactNode }) {
       return (
              <div className="flex flex-row justify-center items-center h-screen">
                     <Card className='w-fit'>
                            <div className="p-10">
                                   {children}
                            </div>
                     </Card>
              </div>
       );
}
