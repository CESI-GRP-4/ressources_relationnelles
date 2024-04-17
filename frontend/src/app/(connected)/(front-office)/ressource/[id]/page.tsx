// /une-ressource/page/[id].tsx
"use client"
import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import type Ressource from '@/types/ressource';
import axios from 'axios';

export default function ARessourcePage({ params }: { params: { id: string } }) {
       const id = params.id;
       const [resource, setResource] = useState<Ressource>();

       useEffect(() => {
              console.log(id)
              fetchARessource();
       }, [id]);

       const fetchARessource = async () => {
              try {
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/ressource/${id}`,
                            withCredentials: true,
                     });
                     console.log("🚀 ~ fetchARessource ~ response:", response);
                     setResource(response.data.ressource);
              } catch (error) {
                     console.error(error);
              }
       };


       if (!resource) {
              return <p>Loading... !!!!</p>;
       }

       return (
              <div>
                     <h1>{resource.label}</h1>
                     <p>{resource.description}</p>
              </div>
       );
}