"use client"
import React from 'react';
import RessourcesChart from '@/components/back-office/statistics/ressources/ressourcesChart';
import PageSummary from '@/components/pageSummary';

export default function ConnectionStats() {
       
       return (
              <>
                     <div className="flex flex-col gap-5">
                            <PageSummary
                                   title="Statistiques de ressources"
                                   description={`Bienvenue sur la page "Statistiques de Ressources" du tableau de bord d'administration de notre plateforme. Cette section vous permet de visualiser et d'analyser les données relatives aux ressources disponibles sur la plateforme. Ici, vous pouvez accéder à des informations détaillées sur l'utilisation des ressources, telles que les taux de consultation. Utilisez cette page pour mieux comprendre les préférences des utilisateurs en matière de contenu et pour identifier les domaines où des améliorations peuvent être apportées. Ces statistiques sont essentielles pour optimiser la pertinence et la qualité des ressources proposées, ainsi que pour orienter les décisions stratégiques concernant l'évolution de la plateforme.`} />
                                   
                            <div className="w-full flex flex-row justify-center">
                                   <div className='w-full space-y-5'>
                                          <RessourcesChart></RessourcesChart>
                                   </div>
                            </div>
                     </div>
              </>
       );
}
