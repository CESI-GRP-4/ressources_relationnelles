"use client"
import { Category } from "@/types/category";
import { TabsProps, Tabs, Carousel } from "antd";
import axios from "axios";
import { useState, useEffect } from "react";
import RessourcesCaroussel from "./ressourcesCaroussel";

export default function CategoriesTab() {
       const [categories, setCategories] = useState<Category[]>([]);
       const [tabs, setTabs] = useState<TabsProps['items']>([]);

       const fetchCategories = async () => {
              try {
                     // setIsLoading(true);
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
                     console.log(categoriesResponse.data.categories);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error("Erreur lors de la récupération des catégories et des statuts:", error);
              } finally {
                     // setIsLoading(false);
              }
       };

       useEffect(() => {
              fetchCategories();
       }, []);

       return (
              <Tabs className="w-full" size="large" defaultActiveKey="1" items={tabs} />
       )
}