import React, { useState } from 'react';
import { Collapse, Tag, Typography, Button, Badge, Card, Empty, Popconfirm, Tooltip, message, Popover, Avatar } from 'antd';
import Ressource from '@/types/ressource';
import { Icon } from '@iconify/react';
const { Text, Paragraph } = Typography;
import Link from 'next/link';
import { useUser } from '@/providers/userProvider';
import axios, { AxiosError } from 'axios';
import RessourceData from './ressourceData';

export default function ListOfRessourcesAccordion({ ressources, refreshRessources }: { ressources: Ressource[], refreshRessources: Function }) {
       const [loading, setLoading] = useState(false); // Used for loading state of buttons, but the global loading of the list is handle throught the parent component from the refreshRessources function
       const { user } = useUser();

       console.log(ressources)
       if (ressources.length === 0) {
              return (
                     <Card className='w-full h-fit' style={{ backgroundColor: "#f5f5f5" }}>
                            <Empty></Empty>
                     </Card>
              )
       }

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
                            refreshRessources();
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
                            refreshRessources();
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
                            refreshRessources();
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
                            refreshRessources();
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

       // Prepare items for the Collapse component
       const collapseItems = ressources.map((ressource) => ({
              key: ressource.id?.toString() ?? 'unknown',
              label: <div className='flex flex-row justify-between gap-5'>
                     <div className="flex flex-row gap-5 items-start w-3/4">
                            <Paragraph strong className='text-nowrap'>{ressource.label}</Paragraph>
                            {/* <Paragraph ellipsis={{ rows: 2, expandable: true }} type='secondary'>{ressource.description}</Paragraph> */}
                     </div>
                     <div className='flex flex-row justify-start items-center'>
                            <Avatar
                                   src={ressource.user?.imgURL}
                                   alt={`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                            />
                            <div style={{ marginLeft: 8 }}>
                                   {`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                            </div>
                     </div>
                     <div className='flex flex-row items-center gap-5'>
                            <div className="flex flex-row items-center gap-2">
                                   <Tag color={ressource.category?.color || "blue"}>
                                          <div className="flex flex-row items-center gap-2">
                                                 <Icon icon={ressource.category?.icon} fontSize={"20px"} /> <span className='text-lg'>{ressource.category?.title}</span>
                                          </div>
                                   </Tag>
                                   <Icon icon={ressource.isPublic ? 'fontisto:unlocked' : 'fontisto:locked'} style={{ color: ressource.isPublic ? 'green' : 'red' }} />
                            </div>
                     </div>
              </div>
              ,
              children: (
                     <>
                            <div className="flex flex-col gap-10">
                                   <div className="flex md:flex-row flex-col-reverse w-full md:justify-between md:items-start gap-5">
                                          <RessourceData ressource={ressource}></RessourceData>
                                          <div className='flex flex-row justify-end space-x-2'>
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
                                   {(ressource.status === 'rejected' || ressource.status === 'blocked') && (
                                          <Badge.Ribbon text={"commentaire modérateur"} color="red">
                                                 <div className="flex flex-row items-center border p-3 rounded-md">
                                                        <Text className='w-4/5'>{ressource.staffComment}</Text>
                                                 </div>
                                          </Badge.Ribbon>
                                   )}
                                   {(ressource.user?.id === user?.id) && (
                                          <div className="flex flex-row justify-end gap-5">
                                                 <Link href={`/editer-ressource/${ressource.id}`}>
                                                        <Button className='w-fit' type='primary'>Apporter des modifications</Button>
                                                 </Link>
                                                 <Popconfirm
                                                        title="Êtes-vous sûr de vouloir supprimer cette ressource?"
                                                        onConfirm={async () => {
                                                               try {
                                                                      const response = await axios({
                                                                             method: 'DELETE',
                                                                             baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                                                                             url: '/ressource/delete/' + ressource.id,
                                                                             responseType: 'json',
                                                                             timeout: 10000,
                                                                             withCredentials: true,
                                                                      });
                                                                      if (response.status === 200) {
                                                                             message.success("Ressource supprimée avec succès")
                                                                             console.log(response.data)
                                                                             refreshRessources();
                                                                      }
                                                               } catch (error) {
                                                                      console.error(error);
                                                                      const axiosError = error as AxiosError

                                                                      if (axiosError.response) {
                                                                             switch (axiosError.response.status) {
                                                                                    case 403 || 401:
                                                                                           message.error("Vous n'êtes pas autorisé à supprimer cette ressource")
                                                                                           break;
                                                                                    case 404:
                                                                                           message.error("Ressource introuvable")
                                                                                           break;
                                                                                    default:
                                                                                           message.error("Erreur lors de la suppression de la ressource")
                                                                             }
                                                                      } else {
                                                                             message.error("Erreur lors de la suppression de la ressource")
                                                                      }
                                                               }
                                                        }}
                                                        okText="Oui"
                                                        cancelText="Non"
                                                 >
                                                        <Tooltip title="Supprimer">
                                                               <Button className='w-fit' type='primary' danger>Supprimer</Button>
                                                        </Tooltip>
                                                 </Popconfirm>
                                          </div>)
                                   }
                            </div>
                     </>
              ),
       }));

       return (
              <Collapse accordion size='large' items={collapseItems} className='w-full h-fit' />
       );
};