// /une-ressource/page/[id].tsx
"use client"
import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import type Resource from '@/types/resource';
import axios from 'axios';

const DefaultResource = [
  { id: 0, label: 'Ressource 0', description: 'Description 0', content: 'Contenu 0', id_category: 1, view_count: BigInt(100), id_user:1, creation_date: new Date() },
  { id: 1, label: 'Ressource 1', description: 'Description 1', content: 'Contenu 1', id_category: 1, view_count: BigInt(200), id_user:0, creation_date: new Date() }
];


export default function ARessourcePage ({ params }: { params: { id: string } }){
  const id = params.id;
  console.log("🚀 ~ ARessourcePage ~ id:", id);
  const [resource, setResource] = useState<Resource | null>(null);

  useEffect(() => {
    const fetchARessource = async () => {
      try {
        const response = await axios({
          method: 'GET',
          baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
          url: `/ressource/${id}`,
          responseType: 'json',
          timeout: 10000,
          withCredentials: true,
        });
        setResource(response.data.ressource);
      } catch (error) {
        console.error("Erreur lors de la récupération de la ressource:", error);
        // Afficher un message d'erreur à l'utilisateur
        // Utilisez la ressource par défaut uniquement en cas d'échec de la récupération de la ressource
        setResource(null);
      }
    };
    if (id) {
      fetchARessource();
    } else {
      // Si pas d'identifiant, utilisez la ressource par défaut
      setResource(null);
    }
  }, [id]);

  
  if (!resource) {
    return <p>Loading... !!!!</p>;
  }

  return (
    <div>
    <h1>{resource.label}</h1>
      <p>{resource.description}</p>
      <p>{resource.content}</p>
      <p>{resource.id_category}</p>
  
      {/* Affichez d'autres données de la ressource ici
      
      
      
      */}
    </div>
  );
}