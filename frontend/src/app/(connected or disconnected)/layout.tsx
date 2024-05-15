// /connexion/layout.tsx
"use client"
import React from 'react';
import { Card, Layout } from 'antd';

import OfflineHeader from '@/components/offlineHeader';
import Header from '@/components/header';
const { Content } = Layout;
import { useUser } from '@/providers/userProvider';

export default function RootLayout({ children }: { children: React.ReactNode }) {
       const { user } = useUser();
       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Layout>
                            {user ? <Header collapsed={true} setCollapsed={function (collapsed: boolean): void {} } /> : <OfflineHeader />}
                            <Content className="py-20 px-10 lg:px-32">
                                   <Card className='w-full h-full flex flex-row justify-center'>
                                          <div className="p-10">
                                                 {children}
                                          </div>
                                   </Card>
                            </Content>
                     </Layout>
              </Layout>
       );
}
