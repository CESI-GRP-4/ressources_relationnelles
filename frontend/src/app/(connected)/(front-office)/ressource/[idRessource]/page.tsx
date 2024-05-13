"use client"
import { useEffect, useState } from "react";
import RessourceType from "@/types/ressource";
import axios, { AxiosError, AxiosResponse } from "axios";
import { Avatar, message, Result, Spin, Tabs, TabsProps, Typography } from "antd";
const { Title } = Typography
import PageSummary from "@/components/pageSummary";
import { UserOutlined } from "@ant-design/icons";
import { Icon } from '@iconify/react';
import { CommentProvider } from "@/contexts/CommentContext";
import Comments from "@/components/front-office/ressource-management/comments";

export default function Ressource({ params }: { params: { idRessource: number } }) {
       const [ressource, setRessource] = useState<RessourceType>();
       const [loading, setLoading] = useState<boolean>(true);

       useEffect(() => {
              fetchRessource();
       }, []);

       const fetchRessource = async () => {
              try {
                     setLoading(true);
                     const response: AxiosResponse<{ ressource: RessourceType }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/${params.idRessource}`, {
                            method: "GET",
                            withCredentials: true
                     });

                     if (response.status === 200) {
                            setRessource(response.data.ressource);
                     } else {
                            throw new Error('Error fetching ressource');
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable");

                                   default:
                                          message.error("Erreur lors de la récupération de la ressource");
                            }
                     } else {
                            message.error("Erreur lors de la mise à jour de la ressource");
                     }
              } finally {
                     setLoading(false);
              }
       };

       const items: TabsProps["items"] = [
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "2rem" }} icon={"fluent:content-view-16-regular"} /> <span>{`Contenu de la ressource`}</span></div>,
                     key: 'content',
                     children: <div><pre>{ressource?.description}</pre></div>
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "1.8rem" }} icon={"oui:documents"} /> <span>{`Documents`}</span></div>,
                     key: 'documents',
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "2rem" }} icon={"typcn:messages"} /> <span>{`Discussion`}</span></div>,
                     key: 'discussion',
                     children: <CommentProvider><Comments disableComment={ressource?.status !== "accepted"} comments={ressource?.comments || []} idRessource={ressource?.id || 0} /> </CommentProvider>
              },
       ];

       return (
              <div className='flex flex-col gap-8'>
                     <PageSummary
                            title={ressource?.label || "Ressource"}
                            description={undefined}
                     />
                     {loading ? (
                            <div className="flex flex-col justify-center w-full"><Spin /></div>
                     ) : ressource ? (
                            <div className="flex flex-col gap-5">
                                   <div className='space-x-3 flex flex-row'><Avatar src={ressource?.user?.imgURL} style={{ height: 35, width: 35 }} icon={<UserOutlined />} /><Title level={3}>{ressource?.user?.firstName}</Title></div>
                                   <Tabs className='w-full' defaultActiveKey="content" items={items} />
                            </div>
                     ) : (
                            <Result
                                   status="404"
                                   title="Erreur"
                                   subTitle="Désolé, il semblerait qu'un problème soit survenu, peut-être que cette ressource n'existe plus."
                            />
                     )}

              </div>
       )

}