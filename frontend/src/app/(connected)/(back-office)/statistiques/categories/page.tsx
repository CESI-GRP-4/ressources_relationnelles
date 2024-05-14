"use client";
import React from 'react';
import RessourcesChart from '@/components/back-office/statistics/ressources/ressourcesChart';
import CategoryDoughnutChart from '@/components/back-office/statistics/categories/categoriesChart';
import PageSummary from '@/components/pageSummary';

export default function ConnectionStats() {
    return (
        <>
            <div className="flex flex-col gap-5">
                <PageSummary
                    title="Statistiques de categories"
                    description={`Bienvenue sur la page "Statistiques des Catégories" du tableau de bord d'administration de notre plateforme. Cette section vous permet de visualiser et d'analyser les données relatives aux catégories de ressources. Ici, vous pouvez accéder à des informations détaillées sur le nombre de ressources disponibles dans chaque catégorie. Utilisez cette page pour mieux comprendre la répartition des ressources sur la plateforme et pour identifier les catégories les plus populaires. Ces statistiques sont essentielles pour optimiser la structuration des ressources et pour guider les décisions stratégiques concernant l'enrichissement du contenu de la plateforme.`}/>
                <div className="w-full flex flex-row justify-center">
                    <div className='w-full space-y-5'>
                        <CategoryDoughnutChart />
                    </div>
                </div>
            </div>
        </>
    );
}
