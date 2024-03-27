"use client"

import { useEffect, useState } from "react"
import { Category } from "@/types/category"
import axios from "axios"
import CategoryCard from "@/components/back-office/categories-management/categoryCard"
import { Skeleton, message } from "antd"
import { AxiosError } from "axios"
import ModifyCategoryModal from "@/components/back-office/categories-management/modifyCategoryModal"

export default function CategoryManagement() {
       const [categories, setCategories] = useState<Category[]>([])
       const [isLoading, setIsLoading] = useState<boolean>(true)

       useEffect(() => {
              fetchCategories()
       }, [])

       const fetchCategories = async () => {
              setIsLoading(true)
              try {
                     const responseCategories = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/allCategories',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setCategories(responseCategories.data.categories);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if(axiosError.response){
                            switch(axiosError.response.status){
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page")
                                          break
                                   default:
                                          message.error("Erreur lors de la récupération des catégories")
                            }
                     } else{
                            message.error("Erreur lors de la récupération des catégories")
                     }
              }
              finally {
                     setIsLoading(false)
              }
       }

       return (
              <div>
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