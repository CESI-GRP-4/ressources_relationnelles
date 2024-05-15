"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { message, Skeleton } from "antd"
import Ressource from "@/types/ressource"
import PageSummary from "@/components/pageSummary"
import RessourcesAccordionAdmin from "@/components/back-office/ressource-management/ressourcesAccordionAdmin"
import FilterRessources from "@/components/filterRessources"

export default function RefusedResources() {
       const [ressources, setRessources] = useState<Ressource[]>([])
       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [loading, setLoading] = useState(true)

       useEffect(() => {
              fetchRessources()
       }, [])

       const fetchRessources = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/rejected`, {
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
                                   <PageSummary title={"Ressources refusées"} description={`Bienvenue sur la page "Ressources Refusées" du tableau de bord d'administration de notre plateforme. Ici, vous pouvez consulter toutes les ressources qui n'ont pas été approuvées pour publication. Cette section vous permet de gérer ces contenus, de comprendre les raisons du refus, et de fournir des retours constructifs aux utilisateurs pour améliorer leurs futures soumissions. Utilisez cette page pour aider à maintenir des standards élevés de qualité pour les ressources disponibles sur la plateforme, en veillant à ce que seuls les contenus les plus pertinents et utiles soient accessibles aux utilisateurs.`}></PageSummary>
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources rejectedRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>
                     <div className="flex flex-row justify-center gap-3">
                            {loading ?
                                   <Skeleton active />
                                   :
                                   <RessourcesAccordionAdmin ressources={filteredRessources[2]} refreshRessources={fetchRessources} showAccept={true} showRefuse={false} showDelete={true} showBlock={true} />
                            }
                     </div>
              </div>
       )
}