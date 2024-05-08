"use client"
import { Category } from "@/types/category";
import { TabsProps, Tabs, Carousel, message, Spin } from "antd";
import axios, { AxiosError } from "axios";
import { useState, useEffect } from "react";
import RessourcesCaroussel from "./ressourcesCaroussel";

export default function CategoriesTab() {
       const [categories, setCategories] = useState<Category[]>([]);
       const [tabs, setTabs] = useState<TabsProps['items']>([]);
       const [isLoading, setIsLoading] = useState<boolean>();
       const fetchCategories = async () => {
              try {
                     setIsLoading(true);
                     const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                     const items = categoriesResponse.data.categories.map((category: Category, index: number) => ({
                            key: String(index + 1),
                            label: category.title,
                            children:
                                   <div className="w-full flex flex-row justify-center">
                                          <RessourcesCaroussel categoryId={category.id} />
                                   </div>,
                     }));
                     setTabs(items);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé.")
                                          break
                                   default:
                                          message.error("Erreur lors de la récupération des catégories")
                            }
                     } else {
                            message.error("Erreur lors de la récupération des catégories")
                     }
              } finally {
                     setIsLoading(false);
              }
       };

       useEffect(() => {
              fetchCategories();
       }, []);

       return (
              <>
                     {isLoading ?
                            <div className="flex flex-col justify-center w-full"><Spin /></div>
                            :
                            <Tabs type="card" className="w-full" size="large" defaultActiveKey="1" items={tabs} />
                     }
              </>
       )
}