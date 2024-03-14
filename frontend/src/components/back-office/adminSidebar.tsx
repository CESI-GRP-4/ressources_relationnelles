"use client"
import { Layout, Menu, Tooltip } from "antd";
import {
       UserOutlined,
       LineChartOutlined,
       FileDoneOutlined,
       RightOutlined,
       LeftOutlined,
       LoginOutlined,
       EditOutlined,
       HistoryOutlined
} from '@ant-design/icons';
import Image from 'next/image';
import Link from "next/link";
import React, { useState, useEffect, useRef } from 'react';
import { usePathname } from 'next/navigation';
const { Sider } = Layout;
import { useUser } from "@/providers/userProvider";

export default function AdminSidebar({ collapsed, setCollapsed }: { collapsed: boolean, setCollapsed: (collapsed: boolean) => void }) {
       const { user } = useUser();
       const pathname = usePathname();
       const selectedKey = pathname.split('/').filter(Boolean).join('/');

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
       let adminSidebarItems = undefined;

       switch (user?.role) {
              case "Utilisateur":
                     // Sidebar items for "Utilisateur" role
                     // no sidebar items
                     break;
              case "Moderateur":
                     // Sidebar items for "Moderateur" role
                     break;
              case "Administrateur":
                     // Sidebar items for "Administrateur" role
                     adminSidebarItems = [
                            // ! Keys must be unique and must have the same value as the route
                            {
                                   key: "utilisateurs",
                                   icon: <UserOutlined />,
                                   style: { marginTop: '30px' },
                                   label: (
                                          <ConditionalTooltip title="Utilisateurs">
                                                 Utilisateurs
                                          </ConditionalTooltip>
                                   ),
                                   title: 'Utilisateurs',
                                   children: [
                                          {
                                                 icon: <EditOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Gestion des utilisateurs">
                                                               <Link href={'/gestion-utilisateurs'}>Gérer</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'gestion-utilisateurs',
                                                 title: 'gestion-utilisateurs',
                                          },
                                          {
                                                 icon: <HistoryOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Historique">
                                                               <Link href={'/gestion-utilisateurs-historique'}>Historique</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'gestion-utilisateurs-historique',
                                                 title: 'gestion-utilisateurs-historique',
                                          },
                                   ]
                            },
                            {
                                   key: "statistiques",
                                   icon: <LineChartOutlined />,
                                   label: (
                                          <ConditionalTooltip title="Statistiques">
                                                 Statistiques
                                          </ConditionalTooltip>
                                   ),
                                   title: 'statistiques',
                                   children: [
                                          {
                                                 icon: <LoginOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Connexions">
                                                               <Link href={'/statistiques/connexions'}>Connexions</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'statistiques/connexions',
                                                 title: 'connexions',
                                          },
                                   ]
                            },
                     ]
                     break;
              case "SuperAdministrateur":
                     // Sidebar items for "SuperAdministrateur" role
                     adminSidebarItems = [
                            // ! Keys must be unique and must have the same value as the route
                            {
                                   key: "utilisateurs",
                                   icon: <UserOutlined />,
                                   style: { marginTop: '30px' },
                                   label: (
                                          <ConditionalTooltip title="Utilisateurs">
                                                 Utilisateurs
                                          </ConditionalTooltip>
                                   ),
                                   title: 'Utilisateurs',
                                   children: [
                                          {
                                                 icon: <EditOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Gestion des utilisateurs">
                                                               <Link href={'/gestion-utilisateurs'}>Gérer</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'gestion-utilisateurs',
                                                 title: 'gestion-utilisateurs',
                                          },
                                          {
                                                 icon: <HistoryOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Historique">
                                                               <Link href={'/gestion-utilisateurs-historique'}>Historique</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'gestion-utilisateurs-historique',
                                                 title: 'gestion-utilisateurs-historique',
                                          },
                                   ]
                            },
                            {
                                   key: "statistiques",
                                   icon: <LineChartOutlined />,
                                   label: (
                                          <ConditionalTooltip title="Statistiques">
                                                 Statistiques
                                          </ConditionalTooltip>
                                   ),
                                   title: 'statistiques',
                                   children: [
                                          {
                                                 icon: <LoginOutlined />,
                                                 label: (
                                                        <ConditionalTooltip title="Connexions">
                                                               <Link href={'/statistiques/connexions'}>Connexions</Link>
                                                        </ConditionalTooltip>
                                                 ),
                                                 key: 'statistiques/connexions',
                                                 title: 'connexions',
                                          },
                                   ]
                            },
                     ]
                     break;
              default:
                     // Sidebar items for other roles or no user
                     // no sidebar items
                     break;
       }

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
                            <Tooltip title="(Re)Sources Relationnelles - Ministère des solidarités et de la santé ">
                                   <Image
                                          draggable={false}
                                          className='m-2 rounded-none'
                                          src="/logo.png"
                                          alt="Logo du ministère des solidarités et de la santé"
                                          width={130}
                                          height={150}
                                   />
                            </Tooltip>
                     </div>
                     <div className="">
                            <Menu
                                   mode="inline"
                                   style={{ height: '100vh' }}
                                   theme="light"
                                   items={adminSidebarItems}
                                   selectedKeys={[selectedKey]}
                            />
                     </div>
              </Sider>
       )
}