// /categories/page.tsx
"use client"
import React, { useEffect, useState } from 'react';
import { List, Card, Button } from 'antd';
import axios from 'axios';
import { Category } from '@/types/category';
import CategoryCard from '@/components/back-office/categories-management/categoryCard';

const DefaultCategories: Category[] = [
       {
              id: 1,
              title: "Communication",
              description: "Exploring effective communication strategies and skills.",
              icon: "mdi:chat-outline",
              color: "#007bff",
              isActive: true,
              createdBy: {
                     id: "1",
                     firstName: "Admin",
                     lastName: "User",
                     email: "admin@example.com",
                     role: "Administrateur",
                     createdAt: "2021-10-12T08:00:00.000Z",
                     updatedAt: "2021-10-12T08:00:00.000Z",
              },
              createdAt: "2021-10-12T08:00:00.000Z",
              updatedAt: "2021-10-12T08:00:00.000Z",
       },
       {
              id: 2,
              title: "Cultures",
              description: "Discovering and appreciating global cultures.",
              icon: "mdi:earth",
              color: "#28a745",
              isActive: false,
              createdBy: {
                     id: "1",
                     firstName: "Admin",
                     lastName: "User",
                     email: "admin@example.com",
                     role: "Administrateur",
                     createdAt: "2021-10-12T08:00:00.000Z",
                     updatedAt: "2021-10-12T08:00:00.000Z",
              },
              createdAt: "2021-10-12T08:00:00.000Z",
              updatedAt: "2021-10-12T08:00:00.000Z",
       },
       // Add additional categories here following the same pattern
       {
              id: 3,
              title: "Développement personnel",
              description: "Fostering personal growth and self-improvement.ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
              icon: "mdi:account-heart-outline",
              color: "#ffc107",
              isActive: true,
              createdBy: {
                     id: "1",
                     firstName: "Admin",
                     lastName: "User",
                     email: "admin@example.com",
                     role: "Administrateur",
                     createdAt: "2021-10-12T08:00:00.000Z",
                     updatedAt: "2021-10-12T08:00:00.000Z",
              },
              createdAt: "2021-10-12T08:00:00.000Z",
              updatedAt: "2021-10-12T08:00:00.000Z",
       },
];

export default function CategoriesPage() {
       const [categories, setCategories] = useState<Category[]>([]);

       useEffect(() => {
              const fetchCategories = async () => {
                     try {
                            const responseCategories = await axios({
                                   method: 'get', // Changé de 'post' à 'get' car nous récupérons des données
                                   baseURL: 'http://localhost/api',
                                   url: "/getAllCategories", // URL mise à jour pour récupérer toutes les catégories
                                   withCredentials: true,
                                   responseType: 'json',
                                   timeout: 10000,
                            });
                            setCategories(responseCategories.data);
                     } catch (error) {
                            console.error("Erreur lors de la récupération des ressources:", error);
                            // En cas d'erreur, utilisez les ressources par défaut
                            setCategories(DefaultCategories);
                     }
              };

              fetchCategories();
       }, []);

       if (!categories || categories.length === 0) {
              return <p>Loading...</p>;
       }

       return (
              <div>
                     <h1>Liste des Catégories</h1>
                     <div className="grid grid-cols-3 gap-4">
                            {categories.map((category) => (
                                   <CategoryCard key={category.id} category={category} />
                            ))}
                     </div>
              </div>
       );
}