"use client"
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { message, Skeleton } from "antd";
import Ressource from "@/types/ressource";
import RessourcesAccordionAdmin from "@/components/back-office/ressource-management/ressourcesAccordionAdmin"
import PageSummary from "@/components/pageSummary";

export default function PendingRessources() {
       const [ressources, setRessources] = useState<Ressource[]>([]);
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
                     console.log("🚀 ~ fetchPendingRessources ~ response.data.ressources:", response.data.ressources);
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
                     <PageSummary title={"Ressources en attente"} description={"Consulter les ressources soumises par les utilisateurs. Le contenu de la ressource est disponible en cliquant l'un des éléments. En dépliant un élément, vous pourrez accepter, refuser ou bloquer la ressource"}></PageSummary>
                     {loading && <Skeleton active />}
                     <RessourcesAccordionAdmin ressources={ressources} refreshRessources={fetchPendingRessources} showAccept={true} showRefuse={true} showDelete={true} showBlock={true} />
              </div>
       );
}