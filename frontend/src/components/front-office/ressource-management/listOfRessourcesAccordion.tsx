import React, { useState } from 'react';
import { Avatar, Collapse, Popover, Tag, Typography, Button, message, Skeleton, Popconfirm } from 'antd';
import Ressource from '@/types/ressource';
import { Icon } from '@iconify/react';
const { Title, Text, Paragraph } = Typography;
import axios, { AxiosError } from 'axios';

export default function ListOfRessourcesAccordion({ ressources, refreshRessources }: { ressources: Ressource[], refreshRessources: Function }) {
       const [loading, setLoading] = useState(false); // Used for loading state of buttons, but the global loading of the list is handle throught the parent component from the refreshRessources function

       // Prepare items for the Collapse component
       const collapseItems = ressources.map((ressource) => ({
              key: ressource.id?.toString() ?? 'unknown', // Ensure key is a string and unique; use a placeholder if id is not available
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
                     <></>
              ),
       }));

       return (
              <Collapse accordion size='large' items={collapseItems} className='w-full' />
       );
};