"use client"
import Ressource from "@/types/ressource";
import { message, Spin, Skeleton  } from "antd";
import { AxiosResponse } from "axios";
import axios, { AxiosError } from "axios";
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
                     <PageSummary title={`Mes "à regarder plus tard"`} description={`Retrouvez ici toutes les ressources que vous avez ajoutées à vos "a regarder plus tard".`} />
                     {loading ?
                            <div className="w-full flex flex-row justify-center"><Skeleton active /></div>
                            :
                            <ListOfRessourcesAccordion ressources={bookmarksRessources} refreshRessources={fetchMyBookmarksRessources} />
                     }
              </div>
       )
}