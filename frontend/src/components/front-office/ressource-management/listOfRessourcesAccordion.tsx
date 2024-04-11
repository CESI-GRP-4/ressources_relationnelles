import React, { useState } from 'react';
import { Avatar, Collapse, Popover, Tag, Typography, Button, message, Skeleton, Popconfirm, Badge } from 'antd';
import Ressource from '@/types/ressource';
import { Icon } from '@iconify/react';
const { Title, Text, Paragraph } = Typography;
import axios, { AxiosError } from 'axios';
import Link from 'next/link';
export default function ListOfRessourcesAccordion({ ressources, refreshRessources }: { ressources: Ressource[], refreshRessources: Function }) {
       const [loading, setLoading] = useState(false); // Used for loading state of buttons, but the global loading of the list is handle throught the parent component from the refreshRessources function

       // Prepare items for the Collapse component
       const collapseItems = ressources.map((ressource) => ({
              key: ressource.id?.toString() ?? 'unknown',
              label: <div className='flex flex-row justify-between gap-5'>
                     <div className="flex flex-row gap-5 items-start w-3/4">
                            <Paragraph strong className='text-nowrap'>{ressource.label}</Paragraph>
                            <Paragraph ellipsis={{ rows: 2, expandable: true }} type='secondary'>{ressource.description}</Paragraph>
                     </div>

                     <div className='flex flex-row items-center gap-5'>
                            <div className="flex flex-row items-center gap-2">
                                   <Tag color={ressource.category?.color || "blue"}>
                                          <div className="flex flex-row items-center gap-2">
                                                 <Icon icon={ressource.category?.icon} fontSize={"20px"} /> <span className='text-lg'>{ressource.category?.title}</span>
                                          </div>
                                   </Tag>

                                   <Icon icon={ressource.isPublic ? 'fontisto:unlocked' : 'fontisto:locked'} style={{ color: ressource.isPublic ? 'green' : 'red' }} />
                            </div>
                     </div>
              </div>
              ,
              children: (
                     <>
                            <div className="flex flex-col gap-10">
                                   {(ressource.status === 'rejected' || ressource.status === 'blocked') && (
                                          <Badge.Ribbon text={"commentaire modérateur"} color="red">
                                                 <div className="flex flex-row items-center border p-3 rounded-md">
                                                        <Text className='w-4/5'>{ressource.staffComment}</Text>
                                                 </div>
                                          </Badge.Ribbon>
                                   )}
                                   <div className="flex flex-row justify-end">
                                          <Link href={`/editer-ressource/${ressource.id}`}>
                                                 <Button className='w-fit' type='primary'>Apporter des modifications</Button>
                                          </Link>
                                   </div>
                            </div>
                     </>
              ),
       }));

       return (
              <Collapse accordion size='large' items={collapseItems} className='w-full' />
       );
};