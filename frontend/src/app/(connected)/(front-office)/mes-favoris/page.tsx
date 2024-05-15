"use client"
import Ressource from "@/types/ressource";
import { message, Skeleton  } from "antd";
import axios, { AxiosError, AxiosResponse } from "axios";
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
                     <PageSummary title="Mes favoris" description={`Cette section vous permet de retrouver rapidement toutes les ressources que vous avez marquées comme favorites. Ici, vous pouvez organiser et accéder facilement aux contenus que vous trouvez particulièrement utiles ou intéressants. Utilisez cette page pour revoir ces ressources à tout moment et continuer à approfondir vos connaissances ou compétences relationnelles. C'est l'endroit idéal pour garder une trace des outils et des informations qui vous inspirent le plus.`} />
                     {loading ?
                            <div className="w-full flex flex-row justify-center"><Skeleton active /></div>
                            :
                            <ListOfRessourcesAccordion ressources={favoriteRessources} refreshRessources={fetchMyFavoriteRessources} />
                     }
              </div>
       )
}