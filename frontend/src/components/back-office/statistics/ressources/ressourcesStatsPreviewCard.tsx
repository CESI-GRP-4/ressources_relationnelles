import { Badge, Card, List, Spin, Tag, message } from "antd";
import Link from "next/link";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { Icon } from '@iconify/react';
import { RessourcesStats } from "@/types/ressourcesStats";
import { useWCAG } from '@/contexts/wcagContext';

export default function RessourceStatsPreviewCard() {
       const [ressourcesStats, setRessourcesStats] = useState<RessourcesStats>();
       const [isLoading, setIsLoading] = useState<boolean>(true);
       const { wcagEnabled } = useWCAG();

       useEffect(() => {
              fetchRessourcesStats()
       }, [])

       const fetchRessourcesStats = async () => {
              setIsLoading(true);
              try {
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/stats/ressources',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setRessourcesStats(response.data.ressources);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des statistiques des ressources");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des statistiques des ressources");
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const otherDataSource = [
              { title: "Ressources acceptées", count: ressourcesStats?.accepted, color: !wcagEnabled ? "green" : undefined, url: "/gestion-ressources/ressources-acceptees" },
              { title: "Ressources en attente", count: ressourcesStats?.pending, color: !wcagEnabled ?"orange": undefined, url: "/gestion-ressources/ressources-en-attente" },
              { title: "Ressources rejetées", count: ressourcesStats?.rejected, color: !wcagEnabled ?"red": undefined, url: "/gestion-ressources/ressources-refusees" },
              { title: "Ressources bloquées", count: ressourcesStats?.blocked, color: !wcagEnabled ?"red": undefined, url: "/gestion-ressources/ressources-bloquees" },
              { title: "Ressources publiques", count: ressourcesStats?.public, color: !wcagEnabled ?"blue": undefined },
              { title: "Ressources privées", count: ressourcesStats?.private, color: !wcagEnabled ?"blue": undefined },
       ];

       return (
              <Badge.Ribbon text={`${ressourcesStats?.total || 0} Ressources`} color="green">
                     <Card
                            style={{ minWidth: 300 }}
                            title="Ressources"
                     // extra={<Link className="mr-20" href="/gestion-utilisateurs"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     >
                            {isLoading ? <div className="flex flex-row w-full justify-center"><Spin></Spin></div> : 
                            
                            <List
                                   itemLayout="horizontal"
                                   dataSource={otherDataSource}
                                   renderItem={({ title, count, color, url }) => (
                                          <List.Item>
                                                 <div style={{ flex: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                                        <div className="flex flex-row items-center gap-2">
                                                               <span>{title}</span>
                                                               {
                                                                      url && <Link href={url}><Icon style={{fontSize: "20px"}} icon={"lucide:link"}></Icon></Link>
                                                               }
                                                        </div>
                                                        <Tag color={!wcagEnabled ? color || "blue" : undefined}>{count}</Tag>
                                                 </div>
                                          </List.Item>
                                   )}
                            />}
                            
                     </Card>
              </Badge.Ribbon>
       );
}
