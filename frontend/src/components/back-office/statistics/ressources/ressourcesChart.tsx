"use client";
import { Bar } from 'react-chartjs-2';
import {
       Chart as ChartJS,
       CategoryScale,
       LinearScale,
       BarElement,
       Title,
       Tooltip,
       Legend,
       ChartData,
       TooltipItem
} from 'chart.js';
import { useEffect, useState } from 'react';
import axios, { AxiosError, AxiosResponse } from 'axios';
import { message, Spin } from 'antd';
import SelectCategory from "@/components/selectCategory";

ChartJS.register(
       CategoryScale,
       LinearScale,
       BarElement,
       Title,
       Tooltip,
       Legend,
);

interface RessourcesResponse {
       ressources: {
              idRessource: number
              viewCount: number
              label: string
              category: {
                     idCategory: number
                     color: string
                     icon: string
              }
       }[];
}

export default function RessourcesChart({ isPreview = false }: { isPreview?: boolean }) {
       const [data, setData] = useState<ChartData<'bar'>>({
              labels: [],
              datasets: [{
                     label: 'Nombre de consultations',
                     data: [],
                     backgroundColor: [],
                     borderColor: [],
              }],
       });

       const [isGraphLoading, setIsGraphLoading] = useState(true);
       const [selectedCategory, setSelectedCategory] = useState<number | null>(null);
       const [fullLabels, setFullLabels] = useState<string[]>([]);
       const defaultColor = 'rgb(75, 192, 192)'; // Default color for bars when no category is selected

       useEffect(() => {
              fetchData(selectedCategory);
       }, [selectedCategory]);

       const fetchData = async (categoryId: number | null) => {
              setIsGraphLoading(true);

              try {
                     const response: AxiosResponse<RessourcesResponse> = await axios({
                            method: 'get',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/stats/ressources/count",
                            params: categoryId ? { categoryId } : {},
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });

                     if (response.status === 200) {
                            const ressources = response.data.ressources;
                            const filteredRessources = categoryId
                                   ? ressources.filter(r => r.category.idCategory === categoryId)
                                   : ressources;
                            const labels = filteredRessources.map(r => r.label);
                            const truncatedLabels = labels.map(label => label.split(' ').slice(0, 3).join(' ') + '...');
                            const viewCounts = filteredRessources.map(r => r.viewCount);
                            const colors = categoryId
                                   ? filteredRessources.map(r => r.category.color)
                                   : new Array(filteredRessources.length).fill(defaultColor);

                            setData({
                                   labels: truncatedLabels,
                                   datasets: [{
                                          label: 'Nombre de consultations',
                                          data: viewCounts,
                                          backgroundColor: colors,
                                          borderColor: colors.map(color => `${color}99`),
                                   }],
                            });

                            // Store full labels for tooltips
                            setFullLabels(labels);
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
              maintainAspectRatio: true,
              aspectRatio: 2,
              plugins: {
                  tooltip: {
                      callbacks: {
                          title: (context: TooltipItem<'bar'>[]) => {
                              return fullLabels[context[0].dataIndex];
                          }
                      }
                  }
              }
          };

       const onCategoryChange = (value: number | null) => {
              setSelectedCategory(value);
       }

       return (
              <>
                     {isGraphLoading ? (
                            <div className='w-full flex flex-row justify-center mt-10'>
                                   <Spin></Spin>
                            </div>
                     ) : (
                            <>
                                   <div className="w-full flex flex-row justify-center">
                                          <div className="w-3/5">
                                                 <SelectCategory onChange={onCategoryChange} value={selectedCategory} />
                                          </div>
                                   </div>
                                   <Bar className='w-full' data={data} options={options} />
                            </>
                     )}
              </>
       );
}
