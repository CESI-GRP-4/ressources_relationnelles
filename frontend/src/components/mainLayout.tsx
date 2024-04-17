"use client"
import { Layout, Divider } from 'antd';
import Footer from '@/components/footer';
import React from 'react';
const { Content } = Layout;

export default function MainLayout({ children }: { children: React.ReactNode }) {
       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Content>
                            {children}
                     </Content>
                     <div className='!bg-white'>
                            <Divider className='' style={{ margin: 0 }}></Divider>
                            <Footer />
                     </div>
              </Layout>
       )
}