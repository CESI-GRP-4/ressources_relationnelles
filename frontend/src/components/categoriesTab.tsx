"use client"
import { Category } from "@/types/category";
import { TabsProps, Tabs, message, Spin, ConfigProvider } from "antd";
import axios, { AxiosError } from "axios";
import { useState, useEffect, useCallback } from "react";
import RessourcesCaroussel from "./ressourcesCaroussel";
import { useWCAG } from '@/contexts/wcagContext';

interface TabItem {
       key: string;
       label: string;
       children: React.ReactNode;
       color?: string;
}

export default function CategoriesTab() {
       const { wcagEnabled } = useWCAG();

       const [categories, setCategories] = useState<Category[]>([]);
       const [tabs, setTabs] = useState<TabItem[]>([]);
       const [isLoading, setIsLoading] = useState<boolean>(true);
       const [colorPrimary, setColorPrimary] = useState<string>('#00b96b');

       const fetchCategories = async () => {
              try {
                     setIsLoading(true);
                     const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                     const items: TabItem[] = categoriesResponse.data.categories.map((category: Category, index: number) => ({
                            key: String(index + 1),
                            label: category.title,
                            children: (
                                   <div className="w-full flex flex-row justify-center">
                                          <RessourcesCaroussel categoryId={category.id} />
                                   </div>
                            ),
                            color: category.color // Assuming each category has a color property
                     }));
                     setTabs(items);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé.");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des catégories");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des catégories");
                     }
              } finally {
                     setIsLoading(false);
              }
       };

       useEffect(() => {
              fetchCategories();
       }, []);

       const handleTabChange = useCallback(
              (key: string) => {
                     const selectedCategory = tabs.find(tab => tab.key === key);
                     if (selectedCategory && selectedCategory.color) {
                            setColorPrimary(selectedCategory.color);
                     }
              },
              [tabs]
       );

       return (
              <>
                     {isLoading ? (
                            <div className="flex flex-col justify-center w-full">
                                   <Spin />
                            </div>
                     ) : (
                            <ConfigProvider
                                   theme={{
                                          token: {
                                                 // Seed Token
                                                 colorPrimary: wcagEnabled ? "black" : colorPrimary,
                                                 borderRadius: 2,
                                                 // Alias Token
                                          },
                                   }}
                            >
                                   <Tabs
                                          type="card"
                                          className="w-full"
                                          size="large"
                                          defaultActiveKey="1"
                                          items={tabs}
                                          onChange={handleTabChange}
                                   />
                            </ConfigProvider>
                     )}
              </>
       );
}
