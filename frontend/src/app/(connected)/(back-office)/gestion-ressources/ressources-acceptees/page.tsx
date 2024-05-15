"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { message, Skeleton } from "antd"
import Ressource from "@/types/ressource"
import PageSummary from "@/components/pageSummary"
import RessourcesAccordionAdmin from "@/components/back-office/ressource-management/ressourcesAccordionAdmin"
import FilterRessources from "@/components/filterRessources"

export default function AcceptedResources() {
       const [ressources, setRessources] = useState<Ressource[]>([]);
       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [loading, setLoading] = useState(true)

       useEffect(() => {
              fetchRessources()
       }, [])

       const fetchRessources = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/accepted`, {
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
                                   <PageSummary title={"Ressources acceptées"} description={`Cette section vous permet de voir toutes les ressources qui ont été approuvées et sont actuellement disponibles pour les utilisateurs. Ici, vous pouvez gérer ces ressources, y compris les mettre à jour, les archiver ou les supprimer si nécessaire. Utilisez cette page pour surveiller la qualité et la pertinence des contributions afin de garantir que le contenu disponible reste utile et conforme aux standards de la plateforme. C'est un outil essentiel pour maintenir l'intégrité et la valeur de notre communauté de partage de ressources.`}></PageSummary>
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources acceptedRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>

                     <div className="flex flex-row justify-center gap-3">
                            {loading ?
                                   <Skeleton active />
                                   :
                                   <RessourcesAccordionAdmin ressources={filteredRessources[0]} refreshRessources={fetchRessources} showAccept={false} showRefuse={true} showDelete={true} showBlock={true} />
                            }
                     </div>
              </div>
       )
}