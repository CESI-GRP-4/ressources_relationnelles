import React, { useState } from 'react';
import { Empty, Input, Button, List, message, Card, Badge, Avatar, Popconfirm, Tooltip, Typography } from 'antd';
import { Comment as CommentType } from "@/types/comment";
import axios, { AxiosError, AxiosResponse } from 'axios';
import { useCommentContext } from '@/contexts/CommentContext';
import { UserOutlined, DeleteOutlined, CloseCircleOutlined } from '@ant-design/icons';
import dayjs from 'dayjs';
import 'dayjs/locale/fr';
import { useUser } from '@/providers/userProvider';
dayjs.locale('fr');
import relativeTime from 'dayjs/plugin/relativeTime';
dayjs.extend(relativeTime)
const { Text, Link } = Typography;
interface Props {
       comments: CommentType[];
       idRessource: number;
       isFirstComponent?: boolean;
       disableComment?: boolean
}

export default function Comments({ comments, idRessource, isFirstComponent = true, disableComment = false }: Props) {
       const [newComment, setNewComment] = useState('');
       const [visibleComments, setVisibleComments] = useState(5); // Initial number of comments to display
       const { idParent, replyingTo, handleSetReply, resetReply } = useCommentContext(); // Use context
       const { user } = useUser()
       const [isLoading, setIsLoading] = useState<boolean>();

       const handleAddComment = async () => {
              if (newComment.trim()) {
                     setIsLoading(true);
                     try {
                            const response: AxiosResponse = await axios({
                                   method: 'post',
                                   baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                                   url: '/comment/create',
                                   data: {
                                          comment: newComment,
                                          idParent: idParent,
                                          idRessource: idRessource,
                                   },
                                   responseType: 'json',
                                   timeout: 10000,
                                   withCredentials: true,
                            });
                            if (response.status === 201) {
                                   message.success("Commentaire envoyé. Avant d'être visible par la communauté, il doit être accepté par un modérateur.");
                                   setNewComment(''); // Clear the input after submitting
                                   resetReply();  // Reset context state
                            }
                     } catch (error) {
                            console.error(error);
                            const axiosError = error as AxiosError

                            if (axiosError.response) {
                                   switch (axiosError.response.status) {
                                          case 403:
                                                 message.error("Vous n'êtes pas autorisé à créer un commentaire. Est-ce que votre mail est vérifié ?")
                                                 break;
                                          case 422:
                                                 message.error("Erreur de validation des données")
                                                 break;
                                          default:
                                                 message.error("Erreur lors de l'ajout du commentaire")
                                   }
                            } else {
                                   message.error("Erreur lors de l'ajout du commentaire")
                            }
                     } finally {
                            setIsLoading(false);
                     }
                     setNewComment(''); // Clear the input after submitting
              }
       };

       const handleLoadMore = () => {
              setVisibleComments(prev => prev + 5); // Load 5 more comments on each trigger
       };

       const handleDeleteComment = async (id: number) => {
              setIsLoading(true);
              try {
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

       return (
              <div>
                     {(comments.length) > 0 ? (
                            <List
                                   dataSource={comments.slice(0, visibleComments)}
                                   renderItem={(comment) => (
                                          <List.Item key={comment.id}>
                                                 <Card
                                                        bordered={false}
                                                        title={<div className='space-x-3'><Avatar src={comment.user.imgURL} style={{ height: 35, width: 35 }} icon={<UserOutlined />} /><Text>{comment.user.firstName}</Text><Text type='secondary'>{dayjs().to(dayjs(comment.createAt, "YYYY-MM-DD hh:mm:ss"))}</Text></div>}
                                                        extra={<div className="flex flex-row items-center gap-3">
                                                               <Link onClick={() => { handleSetReply(comment.id, comment.user.firstName || "un monsieur") }} >
                                                                      Répondre
                                                               </Link>
                                                               {(comment.user.id == user?.id || user?.role !== "Utilisateur") && (
                                                                      <Popconfirm
                                                                             title="Êtes-vous sûr de vouloir supprimer ce commentaire ?"
                                                                             onConfirm={() => { handleDeleteComment(comment.id) }}
                                                                             okText="Oui"
                                                                             disabled={isLoading}
                                                                             cancelText="Non"
                                                                      >
                                                                             <Tooltip title="Supprimer">
                                                                                    <Button loading={isLoading} icon={<DeleteOutlined />} type="primary" danger></Button>
                                                                             </Tooltip>
                                                                      </Popconfirm>
                                                               )}

                                                        </div>}
                                                        style={{ width: '100%' }}
                                                 >
                                                        <pre>{comment.comment}</pre>
                                                        <Comments comments={comment.children} isFirstComponent={false} idRessource={idRessource} disableComment = {disableComment} />
                                                 </Card>
                                          </List.Item>
                                   )}
                                   loadMore={visibleComments < comments.length ? (
                                          <div style={{ textAlign: 'center', margin: 70 }}>
                                                 <Button type='primary' onClick={handleLoadMore}>Charger plus de commentaires</Button>
                                          </div>
                                   ) : null}
                            />
                     ) : (
                            <div>
                                   {isFirstComponent && <Empty description="Aucun commentaire" />}
                            </div>
                     )}

                     {isFirstComponent && <div className='mt-10'>
                            {(idParent && replyingTo) ?
                                   <Badge.Ribbon text={<div className='flex flex-row items-center gap-3'>{`Réponse à ${replyingTo}`} <div><CloseCircleOutlined onClick={resetReply} /></div></div>}>
                                          <Input.TextArea
                                                 disabled={isLoading}
                                                 rows={4}
                                                 size='large'
                                                 autoSize={{ minRows: 4 }}
                                                 value={newComment}
                                                 onChange={e => setNewComment(e.target.value)}
                                                 placeholder="Rédigez un commentaire..."
                                          />
                                   </Badge.Ribbon>
                                   :
                                   <Input.TextArea
                                          disabled={isLoading}
                                          rows={4}
                                          size='large'
                                          autoSize={{ minRows: 4 }}
                                          value={newComment}
                                          onChange={e => setNewComment(e.target.value)}
                                          placeholder="Rédigez un commentaire..."
                                   />
                            }
                            <Button onClick={handleAddComment} type="primary" style={{ marginTop: '10px' }} loading={isLoading} disabled={disableComment}
>
                                   Commenter
                            </Button>
                     </div>}
              </div>
       );
}
