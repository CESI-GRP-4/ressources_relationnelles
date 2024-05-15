"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { Empty, message, Skeleton } from "antd"
import PageSummary from "@/components/pageSummary"
import { Comment as CommentType } from "@/types/comment"
import Comment from "@/components/back-office/comments-management/comment"

export default function RefusedComments() {
       const [comments, setComments] = useState<CommentType[]>([]);
       const [loading, setLoading] = useState(true);

       useEffect(() => {
              fetchRefusedComments();
       }, []);

       const fetchRefusedComments = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/comment/rejected`, {
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
                            <PageSummary title={"Commentaires refusés"} description={`Bienvenue sur la page "Gestion des Utilisateurs" du tableau de bord d'administration de notre plateforme. Cette section vous permet de superviser et de gérer tous les comptes d'utilisateurs inscrits sur la plateforme. Vous pouvez ici activer, désactiver, ou modifier les profils des utilisateurs, ainsi que gérer les rôles et les permissions pour chaque compte. Utilisez cette page pour assurer que les utilisateurs respectent les règles de la communauté et pour intervenir en cas de comportements inappropriés. Cette gestion centralisée permet de maintenir un environnement sûr et efficace pour tous les participants de la plateforme.`}></PageSummary>
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
                                                        <Comment fetchComments={fetchRefusedComments} displayDelete displayRefuse={false} displayAccept={false} key={comment.id} comment={comment}></Comment>
                                                 ))
                                          )}
                                   </>
                            )}
                     </div>
              </div>
       );
}
