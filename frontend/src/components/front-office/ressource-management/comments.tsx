import React, { useEffect, useState } from 'react';
import { Empty, Input, Button, List, message, Card, Badge, Avatar } from 'antd';
import { Comment as CommentType } from "@/types/comment";
import axios, { AxiosError, AxiosResponse } from 'axios';
import { Space, Typography } from 'antd';
import { useCommentContext } from '@/contexts/CommentContext';
import { UserOutlined } from '@ant-design/icons';
import dayjs from 'dayjs';
import 'dayjs/locale/fr';
dayjs.locale('fr');
import relativeTime from 'dayjs/plugin/relativeTime';
dayjs.extend(relativeTime)
const { Text, Link } = Typography;
interface Props {
       comments: CommentType[];
       idRessource: number;
       isFirstComponent?: boolean;
}

export default function Comments({ comments, idRessource, isFirstComponent = true }: Props) {
       const [newComment, setNewComment] = useState('');
       const [visibleComments, setVisibleComments] = useState(5); // Initial number of comments to display
       const { idParent, replyingTo, handleSetReply, resetReply } = useCommentContext(); // Use context
       useEffect(() => {
              console.log(isFirstComponent)
              console.log('idParent changed:', idParent); // Debugging state changes
       }, [idParent]);

       const handleAddComment = async () => {
              if (newComment.trim()) {
                     // onAddComment(newComment);
                     try {
                            // setIsLoading(true);
                            const response: AxiosResponse = await axios({
                                   method: 'post',
                                   baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                                   url: '/comment/create',
                                   data: {
                                          comment: newComment,
                                          idParent: idParent,
                                          idRessource: idRessource, // TODO: Get the ressource ID from the URL
                                   },
                                   responseType: 'json',
                                   timeout: 10000,
                                   withCredentials: true,
                            });
                            if (response.status === 201) {
                                   message.success("Commentaire envoyé");
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
                            // setIsLoading(false);
                     }
                     setNewComment(''); // Clear the input after submitting
              }
       };

       const handleLoadMore = () => {
              setVisibleComments(prev => prev + 5); // Load 5 more comments on each trigger
       };

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
                                                        extra={<Link onClick={() => { handleSetReply(comment.id, comment.user.firstName || "un monsieur") }} >
                                                               Répondre
                                                        </Link>}
                                                        style={{ width: '100%' }}
                                                 >
                                                        <pre>{comment.comment}</pre>
                                                        <Comments comments={comment.children} isFirstComponent={false} idRessource={idRessource} />
                                                 </Card>
                                          </List.Item>
                                   )}
                                   loadMore={visibleComments < comments.length ? (
                                          <div style={{ textAlign: 'center', margin: 12 }}>
                                                 <Button type='primary' onClick={handleLoadMore}>Charger plus de commentaires</Button>
                                          </div>
                                   ) : null}
                            />
                     ) : (
                            <div>
                                   {isFirstComponent && <Empty description="Aucun commentaire" />}
                            </div>
                     )}

                     {isFirstComponent && <div>
                            {(idParent && replyingTo) ?
                                   <Badge.Ribbon text={`Réponse à ${replyingTo}`}>
                                          <Input.TextArea
                                                 rows={4}
                                                 value={newComment}
                                                 onChange={e => setNewComment(e.target.value)}
                                                 placeholder="Rédigez un commentaire..."
                                          />
                                   </Badge.Ribbon>
                                   :
                                   <Input.TextArea
                                          rows={4}
                                          value={newComment}
                                          onChange={e => setNewComment(e.target.value)}
                                          placeholder="Rédigez un commentaire..."
                                   />
                            }
                            <Button onClick={handleAddComment} type="primary" style={{ marginTop: '10px' }}>
                                   Commenter
                            </Button>
                     </div>}
              </div>
       );
}
