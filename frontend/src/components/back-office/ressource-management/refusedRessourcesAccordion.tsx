import React, { useState } from 'react';
import { Avatar, Collapse, Popover, Tag, Typography, Button, message, Skeleton, Popconfirm, Form, Input, Badge } from 'antd';
import Ressource from '@/types/ressource';
import { Icon } from '@iconify/react';
const { Title, Text, Paragraph } = Typography;
import axios, { AxiosError } from 'axios';

export default function RefusedRessourcesAccordion({ ressources, refreshRessources }: { ressources: Ressource[], refreshRessources: Function }) {
       const [loading, setLoading] = useState(false); // Used for loading state of buttons, but the global loading of the list is handle throught the parent component from the refreshRessources function
       const [visiblePopoverId, setVisiblePopoverId] = useState<string | null>(null);

       const acceptRessource = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/accept/${id}`, {
                            withCredentials: true,
                            method: 'PATCH'
                     })

                     if (response.status === 200) {
                            console.log(response.data);
                            message.success("Ressource acceptée avec succès");
                            refreshRessources();
                     }
                     else {
                            throw new Error('Error');
                     }
              }
              catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 400:
                                          message.error("Requête invalide");
                                          break;
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   case 422:
                                          message.error("Erreur avec les données saisies")
                                          break;
                                   default:
                                          message.error("Erreur lors de l'acceptation de la ressource")
                            }
                     } else {
                            message.error("Erreur lors de l'acceptation de la ressource")
                     }
              }
              finally {
                     setLoading(false);
              }
       };

       const blockRessource = async (id: number, staffComment: string = "") => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/block/${id}`, {
                            withCredentials: true,
                            method: 'POST', // Assuming your backend expects a POST request for blocking with a comment.
                            data: { staffComment }, // Pass the staffComment in the request body.
                     });

                     if (response.status === 200) {
                            console.log(response.data);
                            message.success("Ressource bloquée avec succès");
                            refreshRessources();
                     } else {
                            throw new Error('Error');
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 400:
                                          message.error("Requête invalide");
                                          break;
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   case 422:
                                          message.error("Erreur avec les données saisies")
                                          break;
                                   default:
                                          message.error("Erreur lors du blocage de la ressource")
                            }
                     } else {
                            message.error("Erreur lors du blocage de la ressource")
                     }
              } finally {
                     setLoading(false);
                     setVisiblePopoverId(null); // Close the popover upon submission
              }
       };

       const deleteRessource = async (id: number) => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/delete/${id}`, {
                            withCredentials: true,
                            method: 'DELETE',
                     });

                     if (response.status === 200) {
                            message.success("Ressource supprimée avec succès");
                            refreshRessources();
                     } else {
                            throw new Error('Error');
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 400:
                                          message.error("Requête invalide");
                                          break;
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à éffectuer cette action")
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable")
                                          break;
                                   case 422:
                                          message.error("Erreur avec les données saisies")
                                          break;
                                   default:
                                          message.error("Erreur lors de la suppression de la ressource")
                            }
                     } else {
                            message.error("Erreur lors de la suppression de la ressource")
                     }
              } finally {
                     setLoading(false);
              }
       }

       const collapseItems = ressources.map((ressource) => ({
              key: ressource.id?.toString() ?? 'unknown', // Ensure key is a string and unique; use a placeholder if id is not available
              label: <div className='flex flex-row justify-between gap-5'>
                     <div className="flex flex-row gap-5 items-start w-3/4">
                            <Paragraph strong className='text-nowrap'>{ressource.label}</Paragraph>
                            <Paragraph ellipsis={{ rows: 2, expandable: true }} type='secondary'>{ressource.description}</Paragraph>
                     </div>

                     <div className='flex flex-row items-center gap-5'>
                            <Popover content={
                                   <div className="mt-5 space-y-1 pr-7">
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Email</Text>
                                                 <Typography.Link ellipsis copyable>{ressource.user?.email}</Typography.Link>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">ID</Text>
                                                 <Text ellipsis copyable>{ressource.user?.id}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Rôle</Text>
                                                 <Text ellipsis>{ressource.user?.role}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Pays</Text>
                                                 <Text ellipsis>{ressource.user?.country}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Adresse</Text>
                                                 <Text ellipsis>{ressource.user?.city}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Code postal</Text>
                                                 <Text ellipsis>{ressource.user?.postalCode}</Text>
                                          </div>
                                   </div>

                            }
                                   title="Informations de l'utilisateur" trigger="hover">
                                   <div className='flex flex-row justify-start items-center' style={{ cursor: 'pointer' }}>
                                          <Avatar
                                                 src={ressource.user?.imgURL}
                                                 alt={`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                                          />
                                          <div style={{ marginLeft: 8 }}>
                                                 {`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                                          </div>
                                   </div>
                            </Popover>
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
                     <div className='flex flex-col gap-5'>
                            {(ressource.status === 'rejected' || ressource.status === 'blocked') && (
                                   <Badge.Ribbon text={"commentaire modérateur"} color="red">
                                          <div className="flex flex-row items-center border p-3 rounded-md">
                                                 <Text className='w-4/5'>{ressource.staffComment}</Text>
                                          </div>
                                   </Badge.Ribbon>
                            )}
                            <div className='flex flex-col md:flex-row gap-3'>
                                   <Popconfirm
                                          title="Êtes-vous sûr de vouloir accepter cette ressource ?"
                                          onConfirm={() => acceptRessource(ressource.id)}
                                          okText="Oui"
                                          cancelText="Non"
                                   >
                                          <Button loading={loading} style={{ backgroundColor: '#10B981', color: 'white' }}>
                                                 Accepter
                                          </Button>
                                   </Popconfirm>

                                   <Popconfirm
                                   title="Êtes-vous sûr de vouloir supprimer cette ressource ?"
                                   onConfirm={() => deleteRessource(ressource.id)}
                                   okText="Oui"
                                   cancelText="Non"
                            >
                                   <Button loading={loading}  style={{ backgroundColor: '#EF4444', color: 'white' }}>
                                          Supprimer
                                   </Button>
                            </Popconfirm>

                                   <Popover
                                          content={
                                                 <Form onFinish={(values) => blockRessource(ressource.id, values.staffComment)}>
                                                        <Form.Item name="staffComment" rules={[{ required: false, message: 'Veuillez entrer un commentaire!' }]}>
                                                               <Input.TextArea rows={4} placeholder="Ajouter un commentaire..." />
                                                        </Form.Item>
                                                        <Form.Item>
                                                               <div className='flex flex-row justify-center'>
                                                                      <Button type="primary" htmlType="submit" loading={loading}>
                                                                             Confirmer
                                                                      </Button>
                                                               </div>
                                                        </Form.Item>
                                                 </Form>
                                          }
                                          title="Commentaire à déstination de l'utilisateur"
                                          trigger="click"
                                          open={visiblePopoverId === `block-${ressource.id}`} // Ensure unique ID for block popover
                                          onOpenChange={(visible) => setVisiblePopoverId(visible ? `block-${ressource.id}` : null)}
                                   >
                                          <Button loading={loading} style={{ backgroundColor: '#F59E0B', color: 'white' }}>
                                                 Bloquer
                                          </Button>
                                   </Popover>

                            </div>
                     </div>

              ),
       }));

       return (
              <Collapse accordion size='large' items={collapseItems} className='w-full' />
       );
};