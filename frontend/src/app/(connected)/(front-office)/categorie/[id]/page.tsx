"use client"
import { Card, Empty, Skeleton } from "antd";
import { Category } from "@/types/category";
import { useState, useEffect } from "react";
import axios from 'axios';
import ListOfRessourcesAccordion from "@/components/front-office/ressource-management/listOfRessourcesAccordion";
import PageSummary from "@/components/pageSummary";
import FilterRessources from "@/components/filterRessources";
import Ressource from "@/types/ressource";
import { Icon } from '@iconify/react'; // Assuming you use Iconify React component

export default function CategoryPage({ params }: { params: { id: string } }) {
       const [category, setCategory] = useState<Category>();
       const [ressources, setRessources] = useState<any[]>([]);
       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);
       const [isLoading, setIsLoading] = useState<boolean>(false);

       useEffect(() => {
              fetchResources();
       }, [])

       const fetchResources = async () => {
              setIsLoading(true);
              try {
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/category/${params.id}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setRessources(response.data.category.ressources);
                     setCategory(response.data.category);
              } catch (error) {
                     console.error("Error fetching resources:", error);
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <div className="flex flex-col gap-10">
                     <div className="flex md:flex-row flex-col justify-between md:space-x-5 space-x-0 md:space-y-0 space-y-5">
                            <div className="md:w-3/5">
                                   <PageSummary title={(category?.title) ? <div className="flex flex-row items-center gap-3">{category.icon && <Icon icon={category.icon}></Icon>}<span>{category.title}</span></div> : "Page de la catégorie"} description={category?.description} />
                            </div>
                            <div className="flex flex-row items-end">
                                   <FilterRessources hideIsPublicFilter hideCategoryFilter acceptedRessources={ressources} setFilteredRessources={setFilteredRessources}></FilterRessources>
                            </div>
                     </div>

                     {isLoading ?
                            <Skeleton active />
                            :
                            <div>
                                   {(ressources.length > 0) ? (
                                          <div>
                                                 {isLoading ?
                                                        <Skeleton active />
                                                        :
                                                        <div className="flex flex-row justify-center gap-3">
                                                               <ListOfRessourcesAccordion ressources={filteredRessources[0]} refreshRessources={fetchResources} />
                                                        </div>
                                                 }
                                          </div>
                                   ) :
                                          <Card className="h-fit w-full" style={{ backgroundColor: "#f5f5f5" }}>
                                                 <Empty></Empty>
                                          </Card>
                                   }
                            </div>
                     }
              </div>
       );
}