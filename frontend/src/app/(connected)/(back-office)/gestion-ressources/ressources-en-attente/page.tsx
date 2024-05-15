"use client"
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { message, Skeleton } from "antd";
import Ressource from "@/types/ressource";
import RessourcesAccordionAdmin from "@/components/back-office/ressource-management/ressourcesAccordionAdmin"
import PageSummary from "@/components/pageSummary";
import FilterRessources from "@/components/filterRessources"

export default function PendingRessources() {
       const [ressources, setRessources] = useState<Ressource[]>([]);
       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [loading, setLoading] = useState(true);

       useEffect(() => {
              fetchPendingRessources();
       }, []);

       const fetchPendingRessources = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/pending`, {
                            method: "GET",
                            withCredentials: true
                     });
                     setRessources(response.data.ressources);
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
              <div className="flex flex-col gap-10">
                     <div className="flex md:flex-row flex-col justify-between md:space-x-5 space-x-0 md:space-y-0 space-y-5">
                            <div className="md:w-3/5">
                                   <PageSummary title={"Ressources en attente"} description={`Bienvenue sur la page "Ressources en Attente" du tableau de bord d'administration de notre plateforme. Cette section est dédiée à la gestion des ressources soumises par les utilisateurs qui sont actuellement en cours de révision. Vous pouvez examiner ces contributions, les approuver, les demander à être retravaillées, ou les refuser selon leur adéquation avec les critères de la plateforme. Utilisez cette page pour assurer un traitement rapide et efficace des nouvelles ressources, aidant ainsi à maintenir un flux constant de contenu pertinent et de qualité pour la communauté.`}></PageSummary>
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources pendingRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>
                     {loading ?
                            <Skeleton active />
                            :
                            <RessourcesAccordionAdmin ressources={filteredRessources[1]} refreshRessources={fetchPendingRessources} showAccept={true} showRefuse={true} showDelete={true} showBlock={true} />
                     }
              </div>
       );
}