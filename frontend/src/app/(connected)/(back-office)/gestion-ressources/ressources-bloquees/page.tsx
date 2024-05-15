"use client"
import axios, { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { message, Skeleton } from "antd"
import Ressource from "@/types/ressource"
import PageSummary from "@/components/pageSummary"
import RessourcesAccordionAdmin from "@/components/back-office/ressource-management/ressourcesAccordionAdmin"
import FilterRessources from "@/components/filterRessources"

export default function BlockedResources() {
       const [ressources, setRessources] = useState<Ressource[]>([])
       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [loading, setLoading] = useState(true)

       useEffect(() => {
              fetchRessources()
       }, [])

       const fetchRessources = async () => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressources/blocked`, {
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
                                   <PageSummary title={"Ressources bloquées"} description={`Bienvenue sur la page "Ressources Bloquées" du tableau de bord d'administration de notre plateforme. Cette section vous offre un aperçu des ressources qui ont été temporairement ou définitivement bloquées en raison de problèmes tels que le non-respect des directives de la plateforme, des plaintes d'utilisateurs, ou des préoccupations légales. Ici, vous pouvez examiner ces cas, décider de maintenir le blocage, de les réactiver après corrections, ou de les supprimer définitivement. Utilisez cette page pour gérer activement et efficacement les situations qui nécessitent une attention particulière pour assurer un environnement sûr et respectueux pour tous les utilisateurs.`}></PageSummary>
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources blockedRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>
                     <div className="flex flex-row justify-center gap-3">
                            {loading ?
                                   <Skeleton active />
                                   :
                                   <RessourcesAccordionAdmin ressources={filteredRessources[3]} refreshRessources={fetchRessources} showAccept={true} showRefuse={true} showDelete={true} showBlock={false} />
                            }
                     </div>
              </div >
       )
}