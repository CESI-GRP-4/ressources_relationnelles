"use client";
import { Doughnut } from 'react-chartjs-2';
import {
       Chart as ChartJS,
       ArcElement,
       Tooltip,
       Legend,
       ChartData,
       TooltipItem
} from 'chart.js';
import { useEffect, useState } from 'react';
import axios, { AxiosError, AxiosResponse } from 'axios';
import { message, Spin } from 'antd';

ChartJS.register(
       ArcElement,
       Tooltip,
       Legend,
);

interface CategoryResponse {
       categories: {
              id: number
              title: string
              color: string
              icon: string
              ressourcesCount: string
              isActive: string
       }[];
}

export default function CategoryDoughnutChart({ isPreview = false }: { isPreview?: boolean }) {
       const [data, setData] = useState<ChartData<'doughnut'>>({
              labels: [],
              datasets: [{
                     label: 'Nombre de ressources',
                     data: [],
                     backgroundColor: [],
                     borderColor: [],
                     borderWidth: 1,
              }],
       });

       const [isGraphLoading, setIsGraphLoading] = useState(true);

       useEffect(() => {
              fetchData();
       }, []);

       const fetchData = async () => {
              setIsGraphLoading(true);

              try {
                     const response: AxiosResponse<CategoryResponse> = await axios({
                            method: 'get',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/stats/categories",
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });

                     if (response.status === 200) {
                            const categories = response.data.categories;
                            const labels = categories.map(c => c.title);
                            const ressourcesCounts = categories.map(c => parseInt(c.ressourcesCount));
                            const colors = categories.map(c => c.color);

                            setData({
                                   labels: labels,
                                   datasets: [{
                                          label: 'Nombre de ressources',
                                          data: ressourcesCounts,
                                          backgroundColor: colors,
                                          borderColor: colors.map(color => `${color}99`),
                                          borderWidth: 1,
                                   }],
                            });
                     } else {
                            throw new Error('Invalid status code');
                     }
              } catch (error) {
                     console.error("🚀 ~ fetchData ~ error", error);
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 403:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 422:
                                          message.error('Champs manquants ou invalides');
                                          break;
                                   default:
                                          message.error(`Erreur inconnue`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              } finally {
                     setIsGraphLoading(false);
              }
       };

       const options = {
              responsive: true,
              maintainAspectRatio: false,  // Allow the chart to resize freely
              plugins: {
                     legend: isPreview ? { display: false } : { display: true },  // Conditionally hide the legend
                     tooltip: {
                            callbacks: {
                                   label: (context: TooltipItem<'doughnut'>) => {
                                          const label = context.label || '';
                                          const value = context.raw || 0;
                                          return `${label}: ${value}`;
                                   }
                            }
                     }
              },
       };

       return (
              <>
                     {isGraphLoading ? (
                            <div className='w-full flex flex-row justify-center mt-10'>
                                   <Spin></Spin>
                            </div>
                     ) : (
                            <div className={`relative w-full ${isPreview ? "h-[350px]" : "h-[550px]"}`}>  {/* Ensure the container has a height */}
                                   <Doughnut data={data} options={options} />
                            </div>
                     )}
              </>
       );
}
