import { Badge, Button, Card, List, Tag, message, Spin } from "antd";
import Link from "next/link";
import { PlusCircleOutlined } from "@ant-design/icons";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
import { Category } from "@/types/category";
import { Icon } from '@iconify/react';
import { useWCAG } from '@/contexts/wcagContext';

export default function CategoriesPreview() {
       const [categories, setCategories] = useState<Category[]>([]);
       const [isLoading, setIsLoading] = useState<boolean>(true);
       const [stats, setStats] = useState<{ noIconCount: number; inactiveCount: number }>({ noIconCount: 0, inactiveCount: 0 });
       const { wcagEnabled } = useWCAG();

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

                     // Calculate stats
                     const noIconCount = responseCategories.data.categories.filter((cat: Category) => !cat.icon || cat.icon.trim() === '').length;
                     const inactiveCount = responseCategories.data.categories.filter((cat: Category) => !cat.isActive).length;
                     setStats({ noIconCount, inactiveCount });
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page")
                                          break
                                   default:
                                          message.error("Erreur lors de la récupération des catégories")
                            }
                     } else {
                            message.error("Erreur lors de la récupération des catégories")
                     }
              }
              finally {
                     setIsLoading(false)
              }
       }

       const getTagColor = (count: number) => {
              const total = categories.length;
              const percentage = (count / total) * 100;

              if (percentage > 75) return 'red';
              if (percentage > 50) return 'volcano';
              if (percentage > 25) return 'orange';
              return 'green';
       };

       return (
              <Badge.Ribbon text={categories.length} color="blue">
                     <Card
                            title="Catégories"
                            extra={<Link href="/gestion-categories"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     >
                            {isLoading ? <div className="flex flex-row justify-center w-full"><Spin></Spin></div> : (
                                   <List
                                          itemLayout="horizontal"
                                          dataSource={[
                                                 { key: 'no_icon', icon: "solar:ghost-broken", description: 'Catégories sans icons', count: stats.noIconCount },
                                                 { key: 'inactive', icon: "mingcute:sleep-fill", description: 'Catégories inactives', count: stats.inactiveCount },
                                          ]}
                                          renderItem={(item) => (
                                                 <List.Item key={item.key}>
                                                        <div className='flex flex-row justify-start items-center'>
                                                               <Icon icon={item.icon} style={{ fontSize: '32px', marginRight: 8 }} />
                                                               {item.description}
                                                               <Tag color={!wcagEnabled ? getTagColor(item.count): undefined} style={{ marginLeft: 8 }}>{item.count}</Tag>
                                                        </div>
                                                 </List.Item>
                                          )}
                                   />
                            )}

                     </Card></Badge.Ribbon>
       );
}