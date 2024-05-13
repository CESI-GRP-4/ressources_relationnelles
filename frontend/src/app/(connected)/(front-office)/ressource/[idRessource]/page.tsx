"use client"
import { useEffect, useState } from "react";
import RessourceType from "@/types/ressource";
import axios, { AxiosError, AxiosResponse } from "axios";
import { Avatar, message, Result, Spin, Tabs, TabsProps, Typography, Tooltip, Button, Statistic } from "antd";
const { Title } = Typography
import PageSummary from "@/components/pageSummary";
import { UserOutlined, EyeOutlined } from "@ant-design/icons";
import { Icon } from '@iconify/react';
import { CommentProvider } from "@/contexts/CommentContext";
import Comments from "@/components/front-office/ressource-management/comments";

export default function Ressource({ params }: { params: { idRessource: number } }) {
       const [ressource, setRessource] = useState<RessourceType>();
       const [loading, setLoading] = useState<boolean>(true);

       const [isFavorite, setIsFavorite] = useState<boolean>(ressource?.isFavorite || false);
       const [isBookmark, setIsBookmark] = useState<boolean>(ressource?.isBookmark || false);

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
                            setIsBookmark(response.data.ressource.isBookmark || false);
                            setIsFavorite(response.data.ressource.isFavorite || false);
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
                     children: <div><pre className='whitespace-pre-wrap' style={{ wordWrap: 'break-word' }}>{ressource?.description}</pre></div>
              },
              {
                     label: <Tooltip title="Fonctionnalité bientôt disponible"><div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "1.8rem" }} icon={"oui:documents"} /> <span>{`Documents`}</span></div></Tooltip>,
                     key: 'documents',
                     disabled:true,
              },
              {
                     label: <div className="flex flex-row items-center space-x-2"><Icon style={{ fontSize: "2rem" }} icon={"typcn:messages"} /> <span>{`Discussion`}</span></div>,
                     key: 'discussion',
                     children: <CommentProvider><Comments disableComment={ressource?.status !== "accepted"} comments={ressource?.comments || []} idRessource={ressource?.id || 0} /> </CommentProvider>
              },
       ];

       const addToFavorites = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios({
                            method: 'POST',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/favorite/add',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                            data: {
                                   ressourceId: id
                            }
                     });
                     if (response.status === 200) {
                            message.success("Ressource ajoutée aux favoris !");
                            setIsFavorite(true)
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à ajouter cette ressource aux favoris")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   default:
                                          message.error("Erreur lors de l'ajout de la ressource aux favoris")
                            }
                     } else {
                            message.error("Erreur lors de l'ajout de la ressource aux favoris")
                     }
              }
              finally {
                     setLoading(false);
              }
       }
       const removeFromFavorites = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios({
                            method: 'POST',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/favorite/remove',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                            data: {
                                   ressourceId: id
                            }
                     });
                     if (response.status === 200) {
                            message.success("Ressource retirée des favoris !");
                            setIsFavorite(false)
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à retirer cette ressource des favoris")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   default:
                                          message.error("Erreur lors du retrait de la ressource des favoris")
                            }
                     } else {
                            message.error("Erreur lors du retrait de la ressource des favoris")
                     }
              }
              finally {
                     setLoading(false);
              }
       }
       const addToBookmarks = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios({
                            method: 'POST',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/bookmark/add',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                            data: {
                                   ressourceId: id
                            }
                     });
                     if (response.status === 200) {
                            message.success("Ressource ajoutée à votre liste !");
                            setIsBookmark(true);
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à ajouter cette ressource")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   default:
                                          message.error("Erreur lors de l'ajout de la ressource")
                            }
                     } else {
                            message.error("Erreur lors de l'ajout de la ressource")
                     }
              }
              finally {
                     setLoading(false);
              }
       }
       const removeFromBookmarks = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios({
                            method: 'POST',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/bookmark/remove',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                            data: {
                                   ressourceId: id
                            }
                     });
                     if (response.status === 200) {
                            message.success("Ressource retirée de votre liste !");
                            setIsBookmark(false);
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à retirer cette ressource")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   default:
                                          message.error("Erreur lors du retrait de la ressource")
                            }
                     } else {
                            message.error("Erreur lors du retrait de la ressource")
                     }
              }
              finally {
                     setLoading(false);
              }
       }

       return (
              <div className='flex flex-col gap-8'>
                     <PageSummary
                            title={ressource?.label || "Ressource"}
                            description={undefined}
                     />
                     {loading ? (
                            <div className="flex flex-col justify-center w-full"><Spin /></div>
                     ) : ressource ? (
                            <>
                                   <div className="flex flex-col gap-5 mb-10">
                                          <div className='space-x-3 flex flex-row'><Avatar src={ressource?.user?.imgURL} style={{ height: 35, width: 35 }} icon={<UserOutlined />} /><Title level={3}>{ressource?.user?.firstName}</Title></div>
                                          <Tabs className='w-full' defaultActiveKey="content" items={items} />
                                   </div>

                                   <div className='flex w-full flex-row justify-between items-center space-x-2'>
                                          <Statistic title="Nombre de vues" value={ressource.viewCount} prefix={<EyeOutlined />} />
                                          <div className='flex gap-3'>
                                                 <Tooltip title={ressource.isFavorite ? "Enlever des favoris" : "Ajouter aux favoris"}>
                                                        {ressource.isFavorite ? (
                                                               <Button size='large' loading={loading} onClick={() => {
                                                                      removeFromFavorites(ressource.id);
                                                               }}
                                                                      shape="circle" icon={<Icon style={{ fontSize: "1.7rem", color: "gold" }} icon={"emojione-monotone:star"}></Icon>} />
                                                        ) : (
                                                               <Button loading={loading} onClick={() => {
                                                                      addToFavorites(ressource.id);
                                                               }}
                                                                      size='large' shape="circle" icon={<Icon style={{ fontSize: "1.7rem" }} icon={"emojione-monotone:star"}></Icon>} />
                                                        )}
                                                 </Tooltip>

                                                 <Tooltip title={ressource.isBookmark ? `Enlever des "A regarder plus tard"` : `Ajouter à "A regarder plus tard"`}>
                                                        {ressource.isBookmark ? (
                                                               <Button
                                                                      loading={loading}
                                                                      onClick={() => {
                                                                             removeFromBookmarks(ressource.id);
                                                                      }}
                                                                      size='large' shape="circle" icon={<Icon style={{ fontSize: "1.7rem", color: "red" }} icon={"fluent:bookmark-off-24-regular"}></Icon>} />
                                                        ) : (
                                                               <Button
                                                                      loading={loading}
                                                                      onClick={() => {
                                                                             addToBookmarks(ressource.id);
                                                                      }}
                                                                      size='large' shape="circle" icon={<Icon style={{ fontSize: "1.7rem", color: "blue" }} icon={"fluent:bookmark-add-24-regular"}></Icon>} />
                                                        )}
                                                 </Tooltip>
                                          </div>
                                   </div>
                            </>
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