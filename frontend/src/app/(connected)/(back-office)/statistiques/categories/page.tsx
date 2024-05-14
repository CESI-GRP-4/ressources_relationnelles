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
                    description={`Bienvenue sur la page "Statistiques de Connexions" du tableau de bord d'administration de notre plateforme. Cette section vous permet de visualiser et d'analyser les données de connexion des utilisateurs. Ici, vous pouvez accéder à des informations détaillées sur la fréquence des visites, les horaires de pointe, les durées de session, ainsi que les tendances de connexion sur différentes périodes. Utilisez cette page pour comprendre mieux comment les utilisateurs interagissent avec la plateforme et pour identifier les potentiels besoins d'amélioration ou d'adaptation des services proposés. Ces statistiques sont cruciales pour optimiser l'expérience utilisateur et pour guider les décisions stratégiques concernant la plateforme.`} />
                <div className="w-full flex flex-row justify-center">
                    <div className='w-full space-y-5'>
                        <CategoryDoughnutChart />
                    </div>
                </div>
            </div>
        </>
    );
}
