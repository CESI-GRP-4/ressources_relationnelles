"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { Empty, message, Skeleton } from "antd"
import PageSummary from "@/components/pageSummary"
import { Comment as CommentType } from "@/types/comment"
import Comment from "@/components/back-office/comments-management/comment"

export default function AcceptedComments() {
       const [comments, setComments] = useState<CommentType[]>([]);
       const [loading, setLoading] = useState(true);

       useEffect(() => {
              fetchAcceptedComments();
       }, []);

       const fetchAcceptedComments = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/comment/accepted`, {
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
                            <PageSummary title={"Commentaires acceptés"} description={`Bienvenue sur la page "Commentaires Acceptés" du tableau de bord d'administration de notre plateforme. Cette section vous permet de consulter tous les commentaires qui ont été approuvés et sont visibles sur la plateforme. Ici, vous pouvez gérer ces commentaires, les modérer si nécessaire, et veiller à ce qu'ils restent respectueux et constructifs. Utilisez cette page pour surveiller les interactions des utilisateurs et maintenir une communauté dynamique et engagée, tout en s'assurant que les discussions restent positives et bénéfiques pour tous les membres.`}></PageSummary>
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
                                                        <Comment
                                                               fetchComments={fetchAcceptedComments}
                                                               displayDelete
                                                               displayRefuse={false}
                                                               displayAccept={false}
                                                               key={comment.id}
                                                               comment={comment}
                                                        />
                                                 ))
                                          )}
                                   </>
                            )}
                     </div>

              </div>
       );
}
