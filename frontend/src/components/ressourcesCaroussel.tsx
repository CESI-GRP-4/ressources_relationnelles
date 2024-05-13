import { Carousel, Spin, Empty, Typography } from "antd";
import Ressource from "@/types/ressource";
import { useEffect, useState } from "react";
import axios from "axios";
const {Paragraph} = Typography
export default function RessourcesCaroussel({ categoryId }: { categoryId: number }) {
       const [ressources, setRessources] = useState<Ressource[]>([])
       const [isLoading, setIsLoading] = useState<boolean>(false);

       useEffect(() => {
              fetchResources();
       }, []);

       const fetchResources = async () => {
              try {
                     setIsLoading(true);
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/category/${categoryId}`,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setRessources(response.data.category.ressources);
                     //setCategory(response.data.category);
              } catch (error) {
                     console.error("Error fetching resources:", error);
              } finally {
                     setIsLoading(false);
              }
       };

       return (<>

              {isLoading ?
                     <div className="flex flex-row justify-center w-full"><Spin></Spin></div>
                     :
                     <>
                            {ressources.length > 0 ?
                                   (<Carousel className="sm:w-[600px] w-[350px] bg-[#6179c3] rounded-lg" autoplay autoplaySpeed={2200} draggable arrows infinite>
                                          {ressources.map((ressource: Ressource) => (
                                                 <div key={ressource.id} className="p-8 text-white space-y-6">
                                                        <div>
                                                               <span className="text-4xl">{ressource.label}</span>
                                                        </div>
                                                        <div>
                                                               <Paragraph className="!text-white" ellipsis={{rows: 6}}>{ressource.description}</Paragraph>
                                                        </div>
                                                 </div>
                                          ))}
                                   </Carousel>
                                   
                            )
                     : <Empty description="Aucune ressource disponible. Soyez le premier à en créer une !"></Empty>
                     }
                     </>
              }
       </>
       )
}