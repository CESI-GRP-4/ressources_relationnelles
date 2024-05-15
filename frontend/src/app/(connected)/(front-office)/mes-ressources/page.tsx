"use client"
import { Tabs, message, Skeleton } from 'antd';
import type { TabsProps } from 'antd';
import { useState, useEffect } from 'react';
import Ressource from '@/types/ressource';
import PageSummary from '@/components/pageSummary';
import axios, { AxiosError, AxiosResponse } from 'axios';
import ListOfRessourcesAccordion from '@/components/front-office/ressource-management/listOfRessourcesAccordion';
import FilterRessources from '@/components/filterRessources';

export default function MyRessources() {
       const [acceptedRessources, setAcceptedRessources] = useState<Ressource[]>([]);
       const [pendingRessources, setPendingRessources] = useState<Ressource[]>([]);
       const [rejectedRessources, setRejectedRessources] = useState<Ressource[]>([]);
       const [blockedRessources, setBlockedRessources] = useState<Ressource[]>([]);

       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [loading, setLoading] = useState(false);

       useEffect(() => {
              fetchMyRessources();
       }, []);

       const fetchMyRessources = async () => {
              try {
                     setLoading(true);
                     const response: AxiosResponse<{ ressources: Ressource[] }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/myRessources`, {
                            method: "GET",
                            withCredentials: true
                     });
                     const fetchedRessources = response.data.ressources;

                     // Initialize temporary arrays to store sorted resources
                     const tempAccepted: Ressource[] = [];
                     const tempPending: Ressource[] = [];
                     const tempRejected: Ressource[] = [];
                     const tempBlocked: Ressource[] = [];

                     fetchedRessources.forEach((ressource) => {
                            switch (ressource.status) {
                                   case 'accepted':
                                          tempAccepted.push(ressource);
                                          break;
                                   case 'pending':
                                          tempPending.push(ressource);
                                          break;
                                   case 'rejected':
                                          tempRejected.push(ressource);
                                          break;
                                   case 'blocked':
                                          tempBlocked.push(ressource);
                                          break;
                                   // No case for 'disabled' as it's not clear where they should go, or if they should be ignored
                            }
                     });

                     // Update state for each category
                     setAcceptedRessources(tempAccepted);
                     setPendingRessources(tempPending);
                     setRejectedRessources(tempRejected);
                     setBlockedRessources(tempBlocked);
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

       const items: TabsProps['items'] = [
              {
                     key: 'acceptedRessources',
                     label: 'Ressources acceptées',
                     children: <ListOfRessourcesAccordion ressources={filteredRessources[0]} refreshRessources={fetchMyRessources} />,
              },
              {
                     key: 'pendingRessources',
                     label: 'Ressources en attente',
                     children: <ListOfRessourcesAccordion ressources={filteredRessources[1]} refreshRessources={fetchMyRessources} />,
              },
              {
                     key: 'rejectedRessources',
                     label: 'Ressources refusées',
                     children: <ListOfRessourcesAccordion ressources={filteredRessources[2]} refreshRessources={fetchMyRessources} />,
              },
              {
                     key: 'blockedRessources',
                     label: 'Ressources bloquées',
                     children: <ListOfRessourcesAccordion ressources={filteredRessources[3]} refreshRessources={fetchMyRessources} />,
              },
       ];

       return (
              <div className="flex flex-col gap-10">
                     <div className="flex md:flex-row flex-col justify-between md:space-x-5 space-x-0 md:space-y-0 space-y-5">
                            <div className="md:w-3/5">
                                   <PageSummary title={'Mes ressources'} description={`Cette section vous permet de visualiser et de gérer toutes les ressources que vous avez soumises. Ici, vous pouvez facilement suivre le statut de chaque contribution, classées en différentes catégories : acceptées, en attente, refusées, et bloquées. Utilisez cette page pour mettre à jour ou modifier vos ressources, ou pour comprendre les raisons d'un éventuel refus afin d'adapter vos futures soumissions. Gérez efficacement vos contributions et restez engagé dans l'enrichissement de notre communauté.`}></PageSummary>
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources acceptedRessources={acceptedRessources} pendingRessources={pendingRessources} rejectedRessources={rejectedRessources} blockedRessources={blockedRessources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>
                     <div className="flex flex-row justify-center gap-3">
                            {loading ?
                                   <Skeleton active />
                                   :
                                   <Tabs className='w-full' defaultActiveKey="1" items={items} />
                            }
                     </div>
              </div>
       );
}