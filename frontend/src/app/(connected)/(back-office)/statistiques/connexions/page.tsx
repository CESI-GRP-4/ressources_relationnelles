"use client"
import React, { useState } from 'react';
import ConnectionsChart from "@/components/back-office/statistics/connections/connectionChart";
import DateRangePicker from '@/components/dateRangePicker';
import dayjs from 'dayjs';
import PageSummary from '@/components/pageSummary';

export default function ConnectionStats() {
       const defaultStartDate = dayjs().subtract(30, 'days').format('DD/MM/YYYY');
       const defaultEndDate = dayjs().format('DD/MM/YYYY');

       const [dateRange, setDateRange] = useState<{ startDate: string, endDate: string }>({
              startDate: defaultStartDate,
              endDate: defaultEndDate,
       });

       const handleDateChange = (dates: [string, string]) => {
              if (dates) {
                     setDateRange({ startDate: dates[0], endDate: dates[1] });
              }
       };

       const defaultDateRange = [dayjs(defaultStartDate, 'DD/MM/YYYY'), dayjs(defaultEndDate, 'DD/MM/YYYY')] as [dayjs.Dayjs, dayjs.Dayjs];

       return (
              <>
                     <div className="flex flex-col gap-5">
                            <PageSummary
                                   title="Statistiques de connexion"
                                   description={`Bienvenue sur la page "Statistiques de Connexions" du tableau de bord d'administration de notre plateforme. Cette section vous permet de visualiser et d'analyser les données de connexion des utilisateurs. Ici, vous pouvez accéder à des informations détaillées sur la fréquence des visites, les horaires de pointe, les durées de session, ainsi que les tendances de connexion sur différentes périodes. Utilisez cette page pour comprendre mieux comment les utilisateurs interagissent avec la plateforme et pour identifier les potentiels besoins d'amélioration ou d'adaptation des services proposés. Ces statistiques sont cruciales pour optimiser l'expérience utilisateur et pour guider les décisions stratégiques concernant la plateforme.`} />
                                   
                            <div className="w-full flex flex-row justify-center">
                                   <div className='xl:w-4/5 w-full space-y-5'>
                                          <DateRangePicker
                                                 onChange={handleDateChange}
                                                 disableAfterToday
                                                 defaultValue={defaultDateRange}
                                          />
                                          <ConnectionsChart dateRange={dateRange}></ConnectionsChart>
                                   </div>
                            </div>
                     </div>
              </>
       );
}
