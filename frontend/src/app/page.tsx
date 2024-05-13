// page.tsx (default page at frontend/src/app/page.tsx)
"use client"
import React, { useState } from 'react';
import { Card, Layout, Tooltip, Typography, Input } from 'antd';
import OfflineHeader from '@/components/offlineHeader';
import Header from '@/components/header';
const { Content } = Layout;
const { Text } = Typography;
import { useUser } from '@/providers/userProvider';
import PageSummary from "@/components/pageSummary";
import logo from "/public/logo.png"
import Image from 'next/image';
import CategoriesTab from "@/components/categoriesTab";
import type { SearchProps } from 'antd/es/input/Search';
import Ressource from '@/types/ressource';
import { Category } from '@/types/category';
import axios from 'axios';

const { Search } = Input;

export default function Home() {
       const { user } = useUser();
       const [searchResults, setSearchResults] = useState<{ ressources: Ressource[], categories: Category[] }>({ ressources: [], categories: [] });
       const [isLoading, setIsLoading] = useState(false);

       const onSearch: SearchProps['onSearch'] = async (value) => {
              setIsLoading(true);
              try {
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/search`, { data: { searchValue : value }, withCredentials: true, method: "POST"});
                     setSearchResults(response.data);
                     console.log("🚀 ~ constonSearch:SearchProps['onSearch']= ~ response:", response);
              } catch (error) {
                     console.error("Error fetching search results:", error);
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Layout>
                            {user ? <Header collapsed={true} setCollapsed={function (collapsed: boolean): void { }} /> : <OfflineHeader />}
                            <Content className="py-20 px-10 lg:px-32">
                                   <Card className='w-full h-full flex flex-col gap-10'>
                                          <div className="flex lg:flex-row flex-col justify-between md:space-x-5 space-x-0 md:space-y-0 space-y-5">
                                                 <PageSummary
                                                        title={"(Re)Sources Relationnelles"}
                                                        description={
                                                               <div className="flex md:flex-row flex-col items-start gap-5 justify-center">
                                                                      <Tooltip title="(Re)Sources Relationnelles - Ministère des solidarités et de la santé ">
                                                                             <Image
                                                                                    draggable={false}
                                                                                    className='rounded-none pl-8 py-2'
                                                                                    src={logo}
                                                                                    alt="Logo du ministère des solidarités et de la santé"
                                                                                    width={200}
                                                                                    height={220}
                                                                             />
                                                                      </Tooltip>
                                                                      <Text>{`Bienvenue sur (RE)Sources Relationnelles, une plateforme dynamique soutenue par le ministère des Solidarités et de la Santé, conçue pour enrichir les échanges interpersonnels et renforcer la cohésion sociale. Ici, vous accéderez à une vaste gamme de ressources soigneusement catégorisées, facilitant une navigation intuitive et personnalisée selon vos centres d'intérêt. Engagez-vous dans des discussions constructives, partagez vos connaissances et expériences, et participez à l'apprentissage collaboratif au sein de notre communauté. Ensemble, construisons un espace qui favorise un accès continu à la connaissance et qui soutient l'amélioration des relations interpersonnelles tout en restant adaptable aux besoins évolutifs de notre société. Rejoignez-nous pour faire avancer le bien-être individuel et la solidarité collective.`}</Text>
                                                               </div>} />
                                          </div>
                                          <div className="flex flex-col gap-10">
                                                 <div className="w-[300px] lg:w-[500px]">
                                                        <Search size="large" placeholder="Qu'est ce qui vous interesse ?" onSearch={onSearch} className="mt-5 w-full" />
                                                 </div>
                                                 <CategoriesTab></CategoriesTab>
                                          </div>
                                   </Card>
                            </Content>
                     </Layout>
              </Layout>
       )
}

