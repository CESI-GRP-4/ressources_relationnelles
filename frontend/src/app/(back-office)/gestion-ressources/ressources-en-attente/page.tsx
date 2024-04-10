"use client"
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { message, Skeleton } from "antd";
import Ressource from "@/types/ressource";
import PendingRessourcesAccordion from "@/components/back-office/ressource-management/pendingRessourcesAccordion";
import PageSummary from "@/components/back-office/pageSummary";

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
                     console.table(response.data.ressources);

                     const transformedRessources = response.data.ressources.map(ressource => ({
                            id: ressource.id_ressource,
                            label: ressource.label,
                            description: ressource.description,
                            isPublic: ressource.is_public === 1,
                            creationDate: new Date(ressource.created_at),
                            lastModificationDate: new Date(ressource.updated_at),
                            category: {
                                   id: 2,
                                   title: "Category",
                                   icon: "ph:airplane",
                                   color: "#1E90FF"
                            },
                            user: {
                                   id: 3,
                                   email: "test.test@test.com",
                                   role: "admin",
                                   country: "France",
                                   city: "Paris",
                                   postalCode: "75000",
                                   imgURL: "https://api.dicebear.com/8.x/bottts-neutral/svg",
                                   firstName: "John",
                                   lastName: "Doe"
                            }
                     }));

                     setRessources(transformedRessources);
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
                     <PendingRessourcesAccordion ressources={ressources} />
              </div>
       );
}