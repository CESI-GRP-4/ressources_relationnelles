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
import logo from "/public/logo.png"
import React, { useState, useEffect, useRef } from 'react';
import { usePathname } from 'next/navigation';
const { Sider } = Layout;
import { useUser } from "@/providers/userProvider";
import { Icon } from '@iconify/react';

export default function AdminSidebar({ collapsed, setCollapsed }: { collapsed: boolean, setCollapsed: (collapsed: boolean) => void }) {
       const { user } = useUser();
       const pathname = usePathname();
       const selectedKey = pathname.split('/').filter(Boolean).join('/');

       interface SidebarItem {
              key: string;
              icon: React.ReactNode;
              style?: React.CSSProperties;
              label: React.ReactNode;
              title: string;
              children?: SidebarItem[];
       }
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
       const moderatorSidebarItems: SidebarItem[] = [
              {
                     key: "ressources",
                     icon: <Icon icon={"line-md:document-code-twotone"}
                            style={{ fontSize: '20px' }}

                     />,
                     style: { marginTop: '30px' },
                     label: (
                            <ConditionalTooltip title="Ressources">
                                   Ressources
                            </ConditionalTooltip>
                     ),
                     title: 'Ressources',
                     children: [
                            // Ressources accepted:
                            {
                                   icon: <Icon icon={"line-md:circle-to-confirm-circle-transition"}
                                          style={{ fontSize: '20px' }}

                                   />,
                                   label: (
                                          <ConditionalTooltip title="Ressources acceptées">
                                                 <Link href={'/gestion-ressources/ressources-acceptees'}>Acceptées</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'ressources-acceptees',
                                   title: 'ressources-acceptees',
                            },
                            // Ressources waiting for validation:
                            {
                                   icon: <Icon icon={"line-md:loading-twotone-loop"}
                                          style={{ fontSize: '20px' }}
                                   />,
                                   label: (
                                          <ConditionalTooltip title="Ressources en attente">
                                                 <Link href={'/gestion-ressources/ressources-en-attente'}>En attente</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'ressources-en-attente',
                                   title: 'ressources-en-attente',
                            },
                            // Ressources refused (waiting for modifications from the user, it will be then re-submitted for validation):
                            {
                                   icon: <Icon icon={"line-md:close-circle"}
                                          style={{ fontSize: '20px' }}
                                   />,
                                   label: (
                                          <ConditionalTooltip title={`Ressources refusées (en attente de modifications)`}>
                                                 <Link href={'/gestion-ressources/ressources-refusees'}>{`Refusées`}</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'ressources-refusees',
                                   title: 'ressources-refusees',
                            },
                            // Ressources blocked (by an admin, it can be then re-activated by an admin):
                            {
                                   icon: <Icon icon={"line-md:minus-circle"}
                                          style={{ fontSize: '20px' }}
                                   />,
                                   label: (
                                          <ConditionalTooltip title={`Ressources Bloquées (par un administrateur)`}>
                                                 <Link href={'/gestion-ressources/ressources-bloquees'}>{`Bloquées`}</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'ressources-bloquees',
                                   title: 'ressources-bloquees',
                            },
                     ]
              },
              {
                     key: "comments",
                     icon: <Icon icon={"typcn:messages"}
                            style={{ fontSize: '20px' }}

                     />,
                     label: (
                            <ConditionalTooltip title="Commentaires">
                                   {`Commentaires`}
                            </ConditionalTooltip>
                     ),
                     title: 'Commentaires',
                     children: [
                            // Ressources accepted:
                            {
                                   icon: <Icon icon={"line-md:circle-to-confirm-circle-transition"}
                                          style={{ fontSize: '20px' }}

                                   />,
                                   label: (
                                          <ConditionalTooltip title="Commentaires acceptés">
                                                 <Link href={'/gestion-commentaires/commentaires-acceptes'}>Acceptés</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'commentaires-acceptes',
                                   title: 'commentaires-acceptes',
                            },
                            // Ressources waiting for validation:
                            {
                                   icon: <Icon icon={"line-md:loading-twotone-loop"}
                                          style={{ fontSize: '20px' }}
                                   />,
                                   label: (
                                          <ConditionalTooltip title="Commentaires en attente">
                                                 <Link href={'/gestion-commentaires/commentaires-en-attente'}>En attente</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'commentaires-en-attente',
                                   title: 'commentaires-en-attente',
                            },
                            // Ressources refused (waiting for modifications from the user, it will be then re-submitted for validation):
                            {
                                   icon: <Icon icon={"line-md:close-circle"}
                                          style={{ fontSize: '20px' }}
                                   />,
                                   label: (
                                          <ConditionalTooltip title={`Commenaires refusés`}>
                                                 <Link href={'/gestion-commentaires/commentaires-refuses'}>{`Refusés`}</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'commentaires-refuses',
                                   title: 'commentaires-refuses',
                            },
                            // Ressources blocked (by an admin, it can be then re-activated by an admin):
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
                            {
                                   icon: <Icon icon="fluent-mdl2:entry-view"></Icon>,
                                   label: (
                                          <ConditionalTooltip title="Ressources">
                                                 <Link href={'/statistiques/ressources'}>Ressources</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'statistiques/ressources',
                                   title: 'ressources',
                            },
                            {
                                   icon: <Icon icon="solar:pie-chart-2-broken"></Icon>,
                                   label: (
                                          <ConditionalTooltip title="Catégories">
                                                 <Link href={'/statistiques/categories'}>Catégories</Link>
                                          </ConditionalTooltip>
                                   ),
                                   key: 'statistiques/categories',
                                   title: 'categories',
                            },
                     ]
              },
       ]

       // Additional items for the "Administrateur" role
       const adminAdditionalItems: SidebarItem[] = [
              {
                     key: "utilisateurs",
                     icon: <UserOutlined />,
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
                     key: "gestion-categories",
                     icon: <FileDoneOutlined />,
                     label: (
                            <ConditionalTooltip title="Gestion des catégories">
                                   <Link href={'/gestion-categories'}>Catégories</Link>
                            </ConditionalTooltip>
                     ),
                     title: 'gestion-categories',
              }
       ];

       // Additional items for the "SuperAdministrateur" role
       const superAdminAdditionalItems: SidebarItem[] = [];

       let sidebarItems = undefined;

       switch (user?.role) {
              case "Moderateur":
                     sidebarItems = [...moderatorSidebarItems];
                     break;
              case "Administrateur":
                     // Combine moderator items with admin-specific items
                     sidebarItems = [...moderatorSidebarItems, ...adminAdditionalItems];
                     break;
              case "SuperAdministrateur":
                     // Combine admin items (which already includes moderator items) with super-admin-specific items
                     sidebarItems = [...moderatorSidebarItems, ...adminAdditionalItems, ...superAdminAdditionalItems];
                     break;
       }

       return (
              user?.role === "Moderateur" ||
                     user?.role === "Administrateur" ||
                     user?.role === "SuperAdministrateur" ? (
                     <Sider
                            trigger={collapsed ? <RightOutlined /> : <LeftOutlined />}
                            collapsible
                            breakpoint="lg"
                            collapsedWidth="0"
                            width="200"
                            onBreakpoint={(broken) => { }}
                            theme="light"
                            onCollapse={(collapsed, type) => {
                                   setCollapsed(collapsed);
                            }}
                            style={{ height: '100vh', position: 'fixed', left: 0, top: 0 }}
                     >
                            <Link href={'/'} className="flex flex-row items-center justify-center" >
                                   <Tooltip title="(Re)Sources Relationnelles - Ministère des solidarités et de la santé ">
                                          <Image
                                                 draggable={false}
                                                 className='m-2 rounded-none'
                                                 src={logo}
                                                 alt="Logo du ministère des solidarités et de la santé"
                                                 width={130}
                                                 height={150}
                                          />
                                   </Tooltip>
                            </Link>
                            <div className="custom-scrollbar">
                                   <Menu
                                          mode="inline"
                                          style={{
                                                 height: 'calc(100vh - 150px)', overflowY: 'auto' // Allow vertical scroll
                                          }}
                                          className="custom-scrollbar"
                                          theme="light"
                                          items={sidebarItems}
                                          selectedKeys={[selectedKey]}
                                   />
                            </div>
                     </Sider>
              ) : null
       );
}