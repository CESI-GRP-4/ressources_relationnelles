"use client"
import React, { useState } from 'react';
import { Layout, Card } from 'antd';
const { Content } = Layout;
import Header from '@/components/header';

export default function AdminLayout({ children }: { children: React.ReactNode }) {
       const [collapsed, setCollapsed] = useState(true);

       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Layout
                            style={{ marginLeft: !collapsed ? 200 : 0, }}>
                            <Header collapsed={collapsed} setCollapsed={setCollapsed} />
                            <Content className="py-12 px-3 lg:px-16">
                                   <Card className='w-full h-full'>
                                          {children}
                                   </Card>
                            </Content>
                     </Layout>
              </Layout>
       );
}