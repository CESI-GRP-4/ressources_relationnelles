"use client"
import React from 'react';
import { Layout, Divider } from 'antd';
import AdminSidebar from '@/components/back-office/adminSidebar';
import Header from '@/components/header';
import Footer from '@/components/footer';

const { Content } = Layout;

export default function AdminLayout({ children }: { children: React.ReactNode }) {
       const [collapsed, setCollapsed] = React.useState(false);
       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <AdminSidebar collapsed={collapsed} setCollapsed={setCollapsed} />
                     <Layout
                            style={{ marginLeft: !collapsed ? 200 : 0, }}>
                            <Header collapsed={collapsed} setCollapsed={setCollapsed} />
                            <Content className="py-10 px-16">
                                   {children}
                            </Content>
                            <div className='!bg-white'>
                                   <Divider className='' style={{ margin: 0 }}></Divider>
                                   <Footer />
                            </div>
                     </Layout>
              </Layout>
       );
}