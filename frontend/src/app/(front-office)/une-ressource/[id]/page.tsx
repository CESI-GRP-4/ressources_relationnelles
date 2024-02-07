// /une-ressource/page/[id].tsx
"use client"
import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import type Resource from "@/types/ressource";
import axios from 'axios';

const DefaultResource = [
  { id: 0, label: 'Ressource 0', description: 'Description 0', content: 'Contenu 0', id_category: 1 },
  { id: 1, label: 'Ressource 1', description: 'Description 1', content: 'Contenu 1', id_category: 1 }
];


export default function ARessourcePage ({ params }: { params: { id: string } }){
  const id = params.id;
  console.log("🚀 ~ ARessourcePage ~ id:", id);
  const [resource, setResource] = useState<Resource | null>(null);

  useEffect(() => {
    const fetchARessource = async () => {
      try {
        const responseRessource: any = await axios({
          method: 'post',
          baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
          url: "/getAResource",
          data: { idRessource: id },
          withCredentials: true,
          responseType: 'json',
          timeout: 10000, // * Increased value because we had some timeout errors
        });
        setResource(responseRessource.data);
      } catch (error) {
        console.error("Erreur lors de la récupération de la ressource:", error);
        // En cas d'erreur, utilisez la ressource par défaut
        const defaultResource = DefaultResource.find(item => item.id === Number(id));
        if (defaultResource) {
          console.log("resource found")
          setResource(defaultResource);
        }
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
      {/* Affichez d'autres données de la ressource ici
      
      
      
      */}
    </div>
  );
}