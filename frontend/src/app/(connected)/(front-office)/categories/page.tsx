// /categories/page.tsx
"use client"
import { useEffect, useState } from "react";
import { Category } from "@/types/category";
import axios from "axios";
import CategoryCard from "@/components/front-office/categorie-management/CategoryCard";
import { Skeleton, message } from "antd";
import { AxiosError } from "axios";
import PageSummary from "@/components/pageSummary";

export default function Categories() {
    const [categories, setCategories] = useState<Category[]>([]);
    const [isLoading, setIsLoading] = useState<boolean>(true);

    useEffect(() => {
        fetchCategories();
    }, []);

    const fetchCategories = async () => {
        setIsLoading(true);
        try {
            const response = await axios({
                method: 'GET',
                baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                url: '/categories',
                responseType: 'json',
                timeout: 10000,
                withCredentials: true,
            });
            setCategories(response.data.categories);
        } catch (error) {
            console.error(error);
            const axiosError = error as AxiosError;

            if (axiosError.response) {
                switch (axiosError.response.status) {
                    case 403:
                        message.error("Vous n'êtes pas autorisé à accéder à cette page");
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

    return (
        <div className="flex flex-col gap-10">
           <PageSummary title={'Categories'} description={"Vous pouvez retrouver ici toutes nos catégories de ressource !"}></PageSummary>
            {isLoading ? (
                <Skeleton active />
            ) : (
                <div className="flex flex-wrap gap-10 justify-center">
                    {categories.map((category) => (
                        <CategoryCard key={category.id} category={category} />
                    ))}
                </div>
            )}
        </div>
    );
}
