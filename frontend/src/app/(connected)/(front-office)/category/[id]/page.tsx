"use client"
import { Card, Typography, Empty } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import { useState, useEffect } from "react";
import axios from 'axios';
import { useUser } from "@/providers/userProvider";
import ListOfRessourcesAccordion from "@/components/front-office/ressource-management/listOfRessourcesAccordion";
import PageSummary from "@/components/pageSummary";

export default function CategoryPage({ params }: { params: { id: string } }) {
       const [category, setCategory] = useState<Category>();
       const [resources, setResources] = useState<any[]>([]);
       const [isLoading, setIsLoading] = useState<boolean>(false);

       useEffect(() => {
              fetchResources();
       }, [])

       const fetchResources = async () => {
              try {
                     setIsLoading(true);
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/category/${params.id}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     console.log(response.data.category.ressources);
                     setResources(response.data.category.ressources);
                     setCategory(response.data.category);
              } catch (error) {
                     console.error("Error fetching resources:", error);
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <div className="flex flex-col gap-5">
                     <PageSummary title={category?.title || "Page de la catégorie"} description={category?.description} />
                     {resources.length > 0 ? (
                            <div>
                                   {/* <h3>Ressources liées à {category.title} :</h3> */}
                                   {isLoading ? (
                                          <p>Loading...</p>
                                   ) : (
                                          <ListOfRessourcesAccordion ressources={resources} refreshRessources={fetchResources} />
                                   )}
                            </div>
                     ) :
                            <Card style={{ backgroundColor: "#f5f5f5" }}>
                                   <Empty></Empty>
                            </Card>
                     }
              </div>
       );
}