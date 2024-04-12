"use client"
import { Tabs, message } from 'antd';
import type { TabsProps } from 'antd';
import { useState, useEffect } from 'react';
import Ressource from '@/types/ressource';
import PageSummary from '@/components/pageSummary';
import axios, { AxiosError, AxiosResponse } from 'axios';
import ListOfRessourcesAccordion from '@/components/front-office/ressource-management/listOfRessourcesAccordion';
export default function MyRessources() {
       const [acceptedRessources, setAcceptedRessources] = useState<Ressource[]>([]);
       const [pendingRessources, setPendingRessources] = useState<Ressource[]>([]);
       const [rejectedRessources, setRejectedRessources] = useState<Ressource[]>([]);
       const [blockedRessources, setBlockedRessources] = useState<Ressource[]>([]);
       const [loading, setLoading] = useState(true);

       useEffect(() => {
              fetchPendingRessources();
       }, []);

       const fetchPendingRessources = async () => {
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
                     children: <ListOfRessourcesAccordion ressources={acceptedRessources} refreshRessources={fetchPendingRessources}></ListOfRessourcesAccordion>,
              },
              {
                     key: 'pendingRessources',
                     label: 'Ressources en attente',
                     children: <ListOfRessourcesAccordion ressources={pendingRessources} refreshRessources={fetchPendingRessources}></ListOfRessourcesAccordion>,
              },
              {
                     key: 'rejectedRessources',
                     label: 'Ressources refusées',
                     children: <ListOfRessourcesAccordion ressources={rejectedRessources} refreshRessources={fetchPendingRessources}></ListOfRessourcesAccordion>,
              },
              {
                     key: 'blockedRessources',
                     label: 'Ressources bloquées',
                     children: <ListOfRessourcesAccordion ressources={blockedRessources} refreshRessources={fetchPendingRessources}></ListOfRessourcesAccordion>,
              },
       ];

       return (
              <div>
                     <PageSummary title={'Mes ressources'} description={undefined}></PageSummary>
                     <div className="flex flex-row justify-center">
                            <Tabs className='w-full' defaultActiveKey="1" items={items} />
                     </div>
              </div>
       );
}