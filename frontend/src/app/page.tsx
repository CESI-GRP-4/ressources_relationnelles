"use client"
import React, { useState } from 'react';
import { Card, Layout, Tooltip, Typography, Input, List, Spin, AutoComplete } from 'antd';
import OfflineHeader from '@/components/offlineHeader';
import Header from '@/components/header';
const { Content } = Layout;
const { Text } = Typography;
import { useUser } from '@/providers/userProvider';
import PageSummary from "@/components/pageSummary";
import logo from "/public/logo.png";
import Image from 'next/image';
import CategoriesTab from "@/components/categoriesTab";
import Ressource from '@/types/ressource';
import { Category } from '@/types/category';
import axios from 'axios';
import Link from 'next/link';
export default function Home() {
       const { user } = useUser();
       const [searchResults, setSearchResults] = useState<{ ressources: Ressource[], categories: Category[] }>({ ressources: [], categories: [] });
       const [isLoading, setIsLoading] = useState(false);
       const [isSearchLoading, setIsSearchLoading] = useState(false);

       const onSearch = async (value: string) => {
              if (!value.trim()) return
              setIsSearchLoading(true);

              try {
                     const response = await axios.post(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/search`, { searchValue: value }, { withCredentials: true });
                     setSearchResults(response.data);
              } catch (error) {
                     console.error("Error fetching search results:", error);
              } finally {
                     setIsSearchLoading(false);
              }
       };

       const renderItem = (title: string, description: string, id: number, type: "ressource" | "categorie") => ({
              value: title,
              label: (
                     <Link href={`/${type}/${id}`}>
                            <span>{title}</span>
                            <br />
                            <Text type="secondary">{description}</Text>
                     </Link>
              ),
              key: id + title
       });

       const noResultsOption = [{
              label: <Text type="secondary">{`Aucun résultat`}</Text>,
              options: [],
       }];

       const options = [];

       if (searchResults.ressources.length > 0) {
              options.push({
                     label: <Text code>{`Ressources`}</Text>,
                     options: searchResults.ressources.map(item => renderItem(item.label, item.description, item.id, "ressource")),
              });
       }

       if (searchResults.categories.length > 0) {
              options.push({
                     label: <Text code>{`Catégories`}</Text>,
                     options: searchResults.categories.map(item => renderItem(item.title, item.description, item.id, "categorie")),
              });
       }

       if (options.length === 0) {
              options.push(noResultsOption[0]);
       }

       return (
              <Layout style={{ minHeight: '100vh' }}>
                     <Layout>
                            {user ? <Header collapsed={true} setCollapsed={function (collapsed: boolean): void { }} /> : <OfflineHeader />}
                            <Content className="py-20 px-10 lg:px-32">
                                   <Card className=''>
                                          <div className="w-full h-full flex flex-col gap-16">
                                          <PageSummary
                                                 title={"(Re)Sources Relationnelles"}
                                                 description={
                                                        <div className="flex md:flex-row flex-col items-start gap-5 justify-center">
                                                               <Tooltip title="(Re)Sources Relationnelles - Cube">
                                                                      <Image
                                                                             draggable={false}
                                                                             className='rounded-none pl-8 py-2'
                                                                             src={logo}
                                                                             alt="Logo (Re)Sources Relationnelles - Cube"
                                                                             width={200}
                                                                             height={220}
                                                                      />
                                                               </Tooltip>
                                                               <Text>{`Bienvenue sur (RE)Sources Relationnelles, une plateforme dynamique, conçue pour enrichir les échanges interpersonnels et renforcer la cohésion sociale. Ici, vous accéderez à une vaste gamme de ressources soigneusement catégorisées, facilitant une navigation intuitive et personnalisée selon vos centres d'intérêt. Engagez-vous dans des discussions constructives, partagez vos connaissances et expériences, et participez à l'apprentissage collaboratif au sein de notre communauté. Ensemble, construisons un espace qui favorise un accès continu à la connaissance et qui soutient l'amélioration des relations interpersonnelles tout en restant adaptable aux besoins évolutifs de notre société. Rejoignez-nous pour faire avancer le bien-être individuel et la solidarité collective.`}</Text>
                                                        </div>}
                                          />
                                          <div className="w-full flex flex-row justify-center">
                                                 <AutoComplete
                                                        size='large'
                                                        className='w-[300px] lg:w-[500px]'
                                                        options={options}
                                                        defaultActiveFirstOption={false}
                                                        onSearch={onSearch}
                                                        placeholder="Qu'est ce qui vous interesse ?"
                                                 >
                                                 </AutoComplete>
                                          </div>
                                          {isLoading ? (
                                                 <Spin />
                                          ) : (
                                                 <CategoriesTab />
                                          )}
                                          </div>
                                   </Card>
                            </Content>
                     </Layout>
              </Layout>
       );
}
