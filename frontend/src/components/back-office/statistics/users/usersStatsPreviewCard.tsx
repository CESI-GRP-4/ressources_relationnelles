import { Badge, Button, Card, Collapse, List, Spin, Tag, message } from "antd";
import Link from "next/link";
import { PlusCircleOutlined } from "@ant-design/icons";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { UserStats } from "@/types/usersStats";
import { useWCAG } from '@/contexts/wcagContext';

const { Panel } = Collapse;

export default function UsersStatsPreviewCard() {
       const [usersStats, setUsersStats] = useState<UserStats>();
       const [isLoading, setIsLoading] = useState<boolean>(true);
       const { wcagEnabled } = useWCAG();

       useEffect(() => {
              fetchUsersStats()
       }, [])

       const fetchUsersStats = async () => {
              setIsLoading(true);
              try {
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/stats/users',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setUsersStats(response.data);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des statistiques des utilisateurs");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des statistiques des utilisateurs");
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const usersByRoleDataSource = usersStats?.usersByRole.map(role => ({
              title: role.name,
              count: role.userCount
       })) || [];

       const otherDataSource = [
              { title: "Utilisateurs bannis", count: usersStats?.bannedUsersCount, color: !wcagEnabled ? "red" : undefined },
              { title: "Comptes non vérifiés", count: usersStats?.unverifiedEmailsCount, color: !wcagEnabled ?"orange": undefined },
       ];

       return (
              <Badge.Ribbon text={`${usersStats?.totalUsers || 0} Utilisateurs`} color="blue">
                     <Card
                            style={{ minWidth: 300 }}
                            title="Utilisateurs"
                            extra={<Link className="mr-20" href="/gestion-utilisateurs"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     >
                            {isLoading ?
                            <div className="flex flex-row w-full justify-center">
                                   <Spin/>
                                   </div>
                                   :
                                   <>
                                          <Collapse bordered>
                                                 <Panel header="Utilisateurs par rôle" key="1">
                                                        <List
                                                               itemLayout="horizontal"
                                                               dataSource={usersByRoleDataSource}
                                                               renderItem={({ title, count }) => (
                                                                      <List.Item>
                                                                             <div style={{ flex: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                                                                    <span>{title}</span>
                                                                                    <Tag color={!wcagEnabled ? "blue" : undefined}>{count}</Tag>
                                                                             </div>
                                                                      </List.Item>
                                                               )}
                                                        />
                                                 </Panel>
                                          </Collapse>
                                          <List
                                                 itemLayout="horizontal"
                                                 dataSource={otherDataSource}
                                                 renderItem={({ title, count, color }) => (
                                                        <List.Item>
                                                               <div style={{ flex: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                                                      <span>{title}</span>
                                                                      <Tag color={!wcagEnabled ? color || "blue" : undefined}>{count}</Tag>
                                                               </div>
                                                        </List.Item>
                                                 )}
                                          />
                                   </>

                            }

                     </Card>
              </Badge.Ribbon>
       );
}
