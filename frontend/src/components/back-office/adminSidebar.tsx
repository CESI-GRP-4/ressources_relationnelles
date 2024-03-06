"use client"
import { Layout, Menu, Tooltip } from "antd";
import {
       UserOutlined,
       LineChartOutlined,
       FileDoneOutlined,
       RightOutlined,
       LeftOutlined,
       LoginOutlined
} from '@ant-design/icons';
import Image from 'next/image';
import Link from "next/link";
import React, { useState, useEffect, useRef } from 'react';
import { usePathname } from 'next/navigation';
const { Sider } = Layout;

export default function AdminSidebar({ collapsed, setCollapsed }: { collapsed: boolean, setCollapsed: (collapsed: boolean) => void }) {
       const pathname = usePathname();
       const selectedKey = pathname.split('/')[1];

       const ConditionalTooltip = ({ title, children }: { title: string, children: React.ReactNode }) => {
              const [isOverflowing, setIsOverflowing] = useState(false);
              const textRef = useRef<HTMLDivElement>(null);

              useEffect(() => {
                     const checkOverflow = () => {
                            const element = textRef.current;
                            if (element) {
                                   const isOverflow = element.offsetWidth < element.scrollWidth;
                                   setIsOverflowing(isOverflow);
                            }
                     };
                     checkOverflow();
                     window.addEventListener('resize', checkOverflow);
                     return () => window.removeEventListener('resize', checkOverflow);
              }, []);

              return (
                     <Tooltip title={isOverflowing ? title : ''}>
                            <div ref={textRef} style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                   {children}
                            </div>
                     </Tooltip>
              );
       }
       const adminSidebarItems = [
              // ! Keys must be unique and must have the same value as the route
              {
                     icon: <UserOutlined />,
                     style: { marginTop: '30px' },
                     label: (
                            <ConditionalTooltip title="Utilisateurs">
                                   <Link href={'/gestion-utilisateurs'}>Utilisateurs</Link>
                            </ConditionalTooltip>
                     ),
                     key: 'gestion-utilisateurs',
                     title: 'gestion-utilisateurs',
              },
              {
                     icon: <LineChartOutlined />,
                     label: (
                            <ConditionalTooltip title="Statistiques">
                                   <Link href={'/statistiques'} style={{ textDecoration: 'none', color: 'inherit' }}>
                                          Statistiques
                                   </Link>
                            </ConditionalTooltip>
                     ),
                     key: 'statistiques',
                     title: 'statistiques',
                     children: [
                            {
                                   icon: <LoginOutlined />,
                                   label: (
                                          <ConditionalTooltip title="Connexions">
                                                 <Link href={'/statistiques/connexions'}>Connexions</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'connexions',
                                   title: 'connexions',
                            },
                            
                     ]
              },
              {
                     icon: <FileDoneOutlined />,
                     label: (
                            <ConditionalTooltip title="Ressources">
                                   <span>Ressources</span>
                            </ConditionalTooltip>
                     ),
                     key: 'resources',
              },
       ];

       return (
              <Sider
                     trigger={collapsed ? <RightOutlined /> : <LeftOutlined />}
                     collapsible
                     breakpoint="lg"
                     collapsedWidth="0"
                     width="200"
                     onBreakpoint={(broken) => {
                     }}
                     theme="light"
                     onCollapse={(collapsed, type) => {
                            setCollapsed(collapsed);
                     }}
                     style={{ height: '100vh', position: 'fixed', left: 0, top: 0 }}
              >
                     <div className="flex justify-center">
                            <Tooltip title="Dashboard">
                                   <Link href={"/dashboard"}>
                                          <Image
                                                 draggable={false}
                                                 className='m-2 rounded-lg'
                                                 src="https://upload.wikimedia.org/wikipedia/fr/5/50/Bloc_Marianne.svg"
                                                 alt="Logo du ministère des solidarités et de la santé"
                                                 width={130}
                                                 height={150}
                                          />
                                   </Link></Tooltip>
                     </div>
                     <div className="">
                            <Menu
                                   mode="inline"
                                   triggerSubMenuAction="click"
                                   style={{ height: '100vh' }}
                                   theme="light"
                                   items={adminSidebarItems}
                                   // selectedKeys={[selectedKey]}
                            />
                     </div>
              </Sider>
       )
}