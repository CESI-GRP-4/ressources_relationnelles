"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { Empty, message, Skeleton } from "antd"
import PageSummary from "@/components/pageSummary"
import { Comment as CommentType } from "@/types/comment"
import Comment from "@/components/back-office/comments-management/comment"

export default function PendingComments() {
       const [comments, setComments] = useState<CommentType[]>([]);
       const [loading, setLoading] = useState(true);

       useEffect(() => {
              fetchPendingComments();
       }, []);

       const fetchPendingComments = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/comment/pending`, {
                            method: "GET",
                            withCredentials: true
                     });
                     setComments(response.data.comments);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des commentaires");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des commentaires");
                     }
              } finally {
                     setLoading(false);
              }
       };

       return (
              <div className="flex flex-col gap-10">
                     <div className="flex md:flex-row flex-col justify-between md:space-x-5 space-x-0 md:space-y-0 space-y-5">
                            <PageSummary title={"Commentaires en attente"} description={`Bienvenue sur la page "Commentaires en Attente" du tableau de bord d'administration de notre plateforme. Cette section est réservée à la modération des commentaires soumis par les utilisateurs qui n'ont pas encore été approuvés pour publication. Ici, vous pouvez examiner chaque commentaire pour s'assurer qu'il respecte les directives de la communauté avant de décider de l'approuver, le rejeter ou demander une modification. Utilisez cette page pour garantir que les échanges sur la plateforme restent pertinents, respectueux et enrichissants, contribuant ainsi à une expérience positive pour tous les utilisateurs.`}></PageSummary>
                     </div>

                     <div className="flex flex-wrap mt-5 gap-5 w-full justify-center">
                            {loading ? (
                                   <Skeleton active />
                            ) : (
                                   <>
                                          {!comments.length ? (
                                                 <Empty description="Aucun commentaire" />
                                          ) : (
                                                 comments.map((comment) => (
                                                        <Comment fetchComments={fetchPendingComments} displayDelete displayRefuse displayAccept key={comment.id} comment={comment}></Comment>
                                                 ))
                                          )}
                                   </>
                            )}
                     </div>
              </div>
       );
}
