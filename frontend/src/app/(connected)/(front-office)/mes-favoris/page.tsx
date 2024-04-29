"use client"
import Ressource from "@/types/ressource";
import { message, Spin, Skeleton  } from "antd";
import { AxiosResponse } from "axios";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import ListOfRessourcesAccordion from "@/components/front-office/ressource-management/listOfRessourcesAccordion";
import PageSummary from "@/components/pageSummary";

export default function MesFavoris() {
       const [loading, setLoading] = useState(false);
       const [favoriteRessources, setFavoriteRessources] = useState<Ressource[]>([]);
       useEffect(() => {
              fetchMyFavoriteRessources();
       }, []);

       const fetchMyFavoriteRessources = async () => {
              try {
                     setLoading(true);
                     const response: AxiosResponse<{ ressources: Ressource[] }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/favorite/get`, {
                            method: "GET",
                            withCredentials: true
                     });
                     setFavoriteRessources(response.data.ressources);

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
                     <PageSummary title="Mes favoris" description="Retrouvez ici toutes les ressources que vous avez ajoutées à vos favoris." />
                     {loading ?
                            <div className="w-full flex flex-row justify-center"><Skeleton active /></div>
                            :
                            <ListOfRessourcesAccordion ressources={favoriteRessources} refreshRessources={fetchMyFavoriteRessources} />
                     }
              </div>
       )
}