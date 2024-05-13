import { Comment as CommentType } from "@/types/comment"
import { Button, message, Card, Avatar, Popconfirm, Tooltip, Typography } from 'antd';
const { Text } = Typography;
import { UserOutlined, DeleteOutlined } from '@ant-design/icons';
import dayjs from 'dayjs';
import 'dayjs/locale/fr';
dayjs.locale('fr');
import relativeTime from 'dayjs/plugin/relativeTime';
dayjs.extend(relativeTime)
import { Icon } from '@iconify/react';
import axios, { AxiosError, AxiosResponse } from "axios";
import { useState } from "react";
import Link from "next/link";

export default function Comment({ comment, displayAccept, displayRefuse, displayDelete, fetchComments }: { comment: CommentType, displayAccept: boolean, displayRefuse: boolean, displayDelete: boolean, fetchComments: () => void }) {
       const [isLoading, setIsLoading] = useState<boolean>();

       const handleRefuseComment = async ({ id }: { id: number }) => {
              try {
                     setIsLoading(true);
                     const response: AxiosResponse = await axios({
                            method: 'patch',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/comment/reject/${id}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     if (response.status === 200) {
                            message.success("Commentaire refusé");
                            fetchComments();
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403 | 401:
                                          message.error("Vous n'êtes pas autorisé à refuser ce commentaire.")
                                          break;
                                   case 422:
                                          message.error("Erreur de validation des données")
                                          break;
                                   default:
                                          message.error("Erreur lors du refus du commentaire")
                            }
                     } else {
                            message.error("Erreur lors du refus du commentaire")
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const handleAcceptComment = async ({ id }: { id: number }) => {
              try {
                     setIsLoading(true);
                     const response: AxiosResponse = await axios({
                            method: 'patch',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/comment/accept/${id}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     if (response.status === 200) {
                            message.success("Commentaire accepté");
                            fetchComments();
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403 | 401:
                                          message.error("Vous n'êtes pas autorisé à accepter ce commentaire.")
                                          break;
                                   case 422:
                                          message.error("Erreur de validation des données")
                                          break;
                                   default:
                                          message.error("Erreur lors de l'acceptation du commentaire")
                            }
                     } else {
                            message.error("Erreur lors de l'acceptation du commentaire")
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const handleDeleteComment = async (id: number) => {
              try {
                     setIsLoading(true);
                     const response: AxiosResponse = await axios({
                            method: 'delete',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/comment/delete/${id}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     if (response.status === 200) {
                            message.success("Commentaire supprimé");
                            fetchComments();
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403 | 401:
                                          message.error("Vous n'êtes pas autorisé à supprimer ce commentaire.")
                                          break;
                                   case 422:
                                          message.error("Erreur de validation des données")
                                          break;
                                   default:
                                          message.error("Erreur lors de la suppression du commentaire")
                            }
                     } else {
                            message.error("Erreur lors de la suppression du commentaire")
                     }
              } finally {
                     setIsLoading(false);
              }
       }

       const actions = [];

       if (displayRefuse) {
              actions.push(
                     <div className='flex flex-row justify-center'>
                            <Popconfirm
                                   title="Êtes-vous sûr de vouloir refuser ce commentaire ?"
                                   onConfirm={() => { handleRefuseComment({ id: comment.id }) }}
                                   okText="Oui"
                                   cancelText="Non"
                            >
                                   <Tooltip title="Refuser">
                                          <Button icon={<Icon icon={"line-md:close-circle"} style={{ fontSize: '20px' }} />} type="primary" danger></Button>
                                   </Tooltip>
                            </Popconfirm>
                     </div>
              );
       }

       if (displayAccept) {
              actions.push(
                     <div className='flex flex-row justify-center'>
                            <Popconfirm
                                   title="Êtes-vous sûr de vouloir accepter ce commentaire ?"
                                   onConfirm={() => { handleAcceptComment({ id: comment.id }) }}
                                   okText="Oui"
                                   cancelText="Non"
                            >
                                   <Tooltip title="Accepter">
                                          <Button icon={<Icon icon={"line-md:circle-to-confirm-circle-transition"} style={{ fontSize: '20px' }} />} type="primary"></Button>
                                   </Tooltip>
                            </Popconfirm>
                     </div>
              );
       }

       if (displayDelete) {
              actions.push(
                     <div className='flex flex-row justify-center'>
                            <Popconfirm
                                   title="Êtes-vous sûr de vouloir supprimer ce commentaire ?"
                                   onConfirm={() => { handleDeleteComment(comment.id) }}
                                   okText="Oui"
                                   cancelText="Non"
                            >
                                   <Tooltip title="Supprimer">
                                          <Button icon={<DeleteOutlined />} type="primary" danger></Button>
                                   </Tooltip>
                            </Popconfirm>
                     </div>
              );
       }

       return (
              <Card
                     loading={isLoading}
                     title={<div className='space-x-3'><Avatar src={comment.user.imgURL} style={{ height: 35, width: 35 }} icon={<UserOutlined />} /><Text>{comment.user.firstName}</Text><Text type='secondary'>{dayjs().to(dayjs(comment.createAt, "YYYY-MM-DD hh:mm:ss"))}</Text></div>}
                     className="w-fit max-w-full"
                     extra={<Tooltip title="Ouvrir la ressource" className="cursor-pointer">
                            <Link target="_blank" href={`/ressource/${comment.ressourceId}`}>
                                   <Icon className="ml-3" style={{ fontSize: "1.3rem" }} icon={"ion:open-outline"}></Icon>
                            </Link>
                     </Tooltip>
                     }
                     actions={actions}
              >
                     <pre style={{ whiteSpace: 'pre-wrap', wordWrap: 'break-word' }}>{comment.comment}</pre>
              </Card>
       )
}