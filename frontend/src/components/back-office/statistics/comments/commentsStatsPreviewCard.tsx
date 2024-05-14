import { Badge, Card, List, Spin, Tag, message } from "antd";
import Link from "next/link";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { Icon } from '@iconify/react';
import { CommentsStats } from "@/types/commentsStats";
import { useWCAG } from '@/contexts/wcagContext';

export default function CommentsStatsPreviewCard() {
       const [commentsStats, setCommentsStats] = useState<CommentsStats>();
       const [isLoading, setIsLoading] = useState<boolean>(true);
       const { wcagEnabled } = useWCAG();

       useEffect(() => {
              fetchCommentsStats()
       }, [])

       const fetchCommentsStats = async () => {
              setIsLoading(true);
              try {
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/stats/comments',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setCommentsStats(response.data.comments);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des statistiques des commentaires");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des statistiques des commentaires");
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const otherDataSource = [
              { title: "Commentaires des 7 derniers jours", count: commentsStats?.lastWeek, color: "blue" },
              { title: "Commentaires acceptées", count: commentsStats?.accepted, color: "green", url: "/gestion-commentaires/commentaires-acceptes" },
              { title: "Commentaires en attente", count: commentsStats?.pending, color: "orange", url: "/gestion-commentaires/commentaires-en-attente" },
              { title: "Commentaires rejetées", count: commentsStats?.rejected, color: "red", url: "/gestion-commentaires/commentaires-refuses" },
       ];

       return (
              <Badge.Ribbon text={`${commentsStats?.total || 0} Commentaires`} color="green">
                     <Card
                            style={{ minWidth: 300 }}
                            title="Commentaires"
                     >
                            {isLoading ? <div className="flex flex-row w-full justify-center"><Spin></Spin></div> : 
                            
                            <List
                                   itemLayout="horizontal"
                                   dataSource={otherDataSource}
                                   renderItem={({ title, count, color, url }) => (
                                          <List.Item>
                                                 <div style={{ flex: 1, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }} className="gap-3">
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
