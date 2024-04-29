"use client"
import axios from "axios"
import { AxiosError } from "axios"
import { useEffect, useState } from "react"
import { Button, message, Skeleton } from "antd"
import Ressource from "@/types/ressource"
import { Typography } from "antd"
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
              <div>
                     <PageSummary title={"Ressources bloquées"} description={undefined}></PageSummary>
                     <div className="flex flex-row justify-center gap-3">
                            {loading ?
                                   <Skeleton active />
                                   :
                                   <RessourcesAccordionAdmin ressources={filteredRessources[3]} refreshRessources={fetchRessources} showAccept={true} showRefuse={true} showDelete={true} showBlock={false} />
                            }
                            <FilterRessources blockedRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                     </div>
              </div>
       )
}