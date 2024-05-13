"use client"
import Ressource from "@/types/ressource";
import { message, Skeleton  } from "antd";
import axios, { AxiosError, AxiosResponse } from "axios";
import { useEffect, useState } from "react";
import ListOfRessourcesAccordion from "@/components/front-office/ressource-management/listOfRessourcesAccordion";
import PageSummary from "@/components/pageSummary";

export default function MyBookMarks() {
       const [loading, setLoading] = useState(false);
       const [bookmarksRessources, setBookmarksRessources] = useState<Ressource[]>([]);

       useEffect(() => {
              fetchMyBookmarksRessources();
       }, []);

       const fetchMyBookmarksRessources = async () => {
              try {
                     setLoading(true);
                     const response: AxiosResponse<{ ressources: Ressource[] }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/bookmark/get`, {
                            method: "GET",
                            withCredentials: true
                     });
                     setBookmarksRessources(response.data.ressources);

              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401 | 403:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des ressources");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des ressources");
                     }
              } finally {
                     setLoading(false);
              }
       };

       return (
              <div className="space-y-10">
                     <PageSummary title={`Mes "à regarder plus tard"`} description={`Cette section est conçue pour vous aider à garder une trace des ressources que vous souhaitez explorer ultérieurement. Ici, vous pouvez voir toutes les ressources que vous avez choisies de mettre de côté pour consultation future, vous permettant de les retrouver facilement lorsque vous aurez plus de temps à y consacrer. Utilisez cette fonctionnalité pour organiser votre apprentissage et vous assurer de ne jamais manquer des contenus précieux.`} />
                     {loading ?
                            <div className="w-full flex flex-row justify-center"><Skeleton active /></div>
                            :
                            <ListOfRessourcesAccordion ressources={bookmarksRessources} refreshRessources={fetchMyBookmarksRessources} />
                     }
              </div>
       )
}