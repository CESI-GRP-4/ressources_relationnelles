"use client"
import React, { useState } from 'react';
import { Layout, Divider } from 'antd';
const { Content } = Layout;
import Header from '@/components/header';
import Footer from '@/components/footer';
export default function AdminLayout({ children }: { children: React.ReactNode }) {
       const [collapsed, setCollapsed] = useState(true);

       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Layout
                            style={{ marginLeft: !collapsed ? 200 : 0, }}>
                            <Header collapsed={collapsed} setCollapsed={setCollapsed} />
                            <Content className="py-12 px-3 lg:px-16">
                                   {children} </Content>
                            <div className='!bg-white'>
                                   <Divider className='' style={{ margin: 0 }}></Divider>
                                   <Footer />
                            </div>
                     </Layout>
              </Layout>
       );
}