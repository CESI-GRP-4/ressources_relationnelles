"use client"
import React from 'react';
import { UploadOutlined, UserOutlined, VideoCameraOutlined, LineChartOutlined, FileDoneOutlined, FolderOpenOutlined, StarOutlined, PlusCircleOutlined } from '@ant-design/icons';
import { Layout, Menu } from 'antd';
import Image from 'next/image';

const { Header, Content, Footer, Sider } = Layout;

const adminSidebarItems = [{
       icon: <UserOutlined />,
       label: `Utilisateurs`,
},
{
       icon: <LineChartOutlined />,
       label: `Statistiques`,
},
{
       icon: <FileDoneOutlined />,
       label: `Ressources`,
}];

const headerItems = [{
       icon: <FolderOpenOutlined />,
       label: `Catégories`,
},
{
       icon: <PlusCircleOutlined />,
       label: `Créer une ressource`,
},
{
       icon: <FileDoneOutlined />,
       label: `Mes ressources`,
},
{
       label: `Mes favoris`,
       icon: <StarOutlined />,
}
];

export default function AdminLayout({ children }: { children: React.ReactNode }) {
       const [collapsed, setCollapsed] = React.useState(false);
       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Header className="site-layout-background" style={{
                            padding: 0, marginLeft: !collapsed ? 200 : 0, position: 'sticky',
                            top: 0,
                            zIndex: 1,
                            display: 'flex',
                            alignItems: 'center',
                     }}>
                            <div className="demo-logo" />
                            <div className='flex flex-row justify-between w-full'>
                                   <Menu
                                          mode="horizontal"
                                          defaultSelectedKeys={['2']}
                                          items={headerItems}
                                          theme="light"
                                          className='w-full'
                                   />
                                   <div className="bg-white">dd</div>
                            </div>
                     </Header>
                     <Layout>
                            <Sider
                                   collapsible
                                   breakpoint="lg"
                                   collapsedWidth="0"
                                   onBreakpoint={(broken) => {
                                          console.log(broken);
                                   }}
                                   theme="light"
                                   onCollapse={(collapsed, type) => {
                                          console.log(collapsed, type);
                                          setCollapsed(collapsed);
                                   }}
                                   style={{ height: '100vh', position: 'fixed', left: 0, top: 0 }}
                            >
                                   {/* Ensure the parent container has a defined width */}
                                   <div className="flex justify-center">
                                          <Image
                                                 className='m-2 rounded-lg'
                                                 src="https://upload.wikimedia.org/wikipedia/fr/5/50/Bloc_Marianne.svg"
                                                 alt="Logo du ministère des solidarités et de la santé"
                                                 width={140} // Original width of the image
                                                 height={160} // Original height of the image, adjust these to maintain the aspect ratio
                                          />
                                   </div>
                                   <div className="mt-8 ">
                                          <Menu mode="inline" theme="light" defaultSelectedKeys={['4']} items={adminSidebarItems} />
                                   </div>
                            </Sider>
                     </Layout>

                     <Layout className="site-layout" style={{ marginLeft: !collapsed ? 200 : 0 }}>
                            <Content style={{ margin: '24px 16px 0', overflow: 'initial' }}>
                                   <div className="site-layout-background px-10 py-5">
                                          {children}
                                   </div>
                            </Content>
                            <Footer style={{ textAlign: 'center' }}>Ant Design ©2018 Created by Ant UED</Footer>
                     </Layout>
              </Layout>
       );
}