"use client"
import { useState } from 'react';
import { Card, Avatar, Typography, Button } from "antd";
const { Meta } = Card;
import { useUser } from "@/providers/userProvider";
const { Text } = Typography;
import Link from "next/link";
import ConnectionsChart from "@/components/back-office/statistics/connectionChart";
import { PlusCircleOutlined, UserOutlined } from "@ant-design/icons";

import History from "@/components/back-office/user-management/history";

export default function AdminDashboard() {
       const { user } = useUser();
       console.log("🚀 ~ AdminDashboard ~ user:", user);
       const [avatarError, setAvatarError] = useState(false); // État pour gérer l'erreur de chargement de l'avatar

       return (
              <div className="flex flex-col">
                     <Typography.Title level={2}>Tableau de bord</Typography.Title>
                     <Typography.Paragraph>
                            Bienvenue sur le tableau de bord d'administration. Vous pouvez visualiser un apercu de chaque fonctionnalité disponible. Pour plus de détails, veuillez naviguer vers les pages correspondantes en cliquant sur les boutons <PlusCircleOutlined style={{ color: "blue" }} /> dans chaque carte.
                     </Typography.Paragraph>
                     <div className="flex-wrap flex mt-5 gap-5">
                            <div>
                                   <Card
                                          title="Informations du gestionnaire"
                                          extra={<Link href="/profil"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                                   >
                                          <Meta
                                                 avatar={
                                                        <Avatar
                                                               draggable={false}
                                                               shape='square'
                                                               src={!avatarError ? user?.imgURL : null}
                                                               icon={avatarError ? <UserOutlined /> : null}
                                                               onError={() => {
                                                                      setAvatarError(true); // En cas d'erreur, utilisez l'icône UserOutlined
                                                                      return false; // Retournez false pour indiquer que l'erreur de chargement est gérée
                                                               }}
                                                        />
                                                 }
                                                 title={`${user?.firstName} ${user?.lastName}`}
                                                 description={<Text>{user?.role}</Text>}
                                          />
                                          <div className="mt-5 space-y-3 pr-7">
                                                 <div className="flex flex-row gap-3">
                                                        <Text type="secondary" className="whitespace-nowrap">Email</Text>
                                                        <Typography.Link ellipsis copyable>{user?.email}</Typography.Link>
                                                 </div>
                                                 <div className="flex flex-row gap-3">
                                                        <Text type="secondary" className="whitespace-nowrap">ID</Text>
                                                        <Text ellipsis copyable>{user?.id}</Text>
                                                 </div>
                                          </div>
                                   </Card>
                            </div>
                            <div>
                                   <History></History>
                            </div>
                            <Card
                                   title="Statistiques de connexions (semaine actuelle)"
                                   extra={<Link href="/statistiques/connexions"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                                   className="w-1/2 min-w-96 max-w-[600px] h-auto">

                                   <div style={{ width: '100%', aspectRatio: '16 / 9' }}>
                                          <ConnectionsChart isPreview></ConnectionsChart>
                                   </div>
                            </Card>

                     </div>
              </div>
       );
}
