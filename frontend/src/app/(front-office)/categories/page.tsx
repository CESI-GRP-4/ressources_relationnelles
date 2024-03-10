// /categories/page.tsx
"use client"
import React, { useEffect, useState } from 'react';
import { List, Card, Button } from 'antd';
import axios from 'axios';

// Définition du type pour les catégories
interface Category {
       id_category: number;
       name: string;
     }

const DefaultCategories = [
  { id_category: 0, name: 'Education'},
  { id_category: 1, name: 'Entertainment'}
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
       <List
         grid={{ gutter: 10, column: 6 }}
         style={{paddingTop: "2%", paddingLeft: "1%"}}
         dataSource={categories}
         renderItem={(categorie: any) => (
           <List.Item>
             <Card title={categorie.name}>
               {/* Affichez d'autres données de la catégorie ici si nécessaire */}
               <Button>Voir les ressources</Button>
             </Card>
           </List.Item>
         )}
       />
     </div>
  );
}
