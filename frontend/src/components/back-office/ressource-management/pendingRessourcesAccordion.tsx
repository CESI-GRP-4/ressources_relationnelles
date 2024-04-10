import React from 'react';
import { Avatar, Collapse, Popover, Tag } from 'antd';
import Ressource from '@/types/ressource';
import { Icon } from '@iconify/react';
import { Typography } from 'antd';
const { Title, Text, Paragraph } = Typography;

export default function PendingRessourcesAccordion({ ressources }: { ressources: Ressource[] }) {
       console.log(ressources); // Log the creation date of the first ressource, or 'unknown' if it is not available


       // Prepare items for the Collapse component
       const collapseItems = ressources.map((ressource) => ({
              key: ressource.id?.toString() ?? 'unknown', // Ensure key is a string and unique; use a placeholder if id is not available
              label: <div className='flex flex-row justify-between gap-5'>
                     <div className="flex flex-row gap-5 items-start w-3/4">
                            <Paragraph strong className='text-nowrap'>{ressource.label}</Paragraph>
                            <Paragraph ellipsis={{ rows: 2, expandable: true }} type='secondary'>{ressource.description}</Paragraph>
                     </div>

                     <div className='flex flex-row items-center gap-5'>
                            <Popover content={
                                   <div className="mt-5 space-y-1 pr-7">
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Email</Text>
                                                 <Typography.Link ellipsis copyable>{ressource.user?.email}</Typography.Link>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">ID</Text>
                                                 <Text ellipsis copyable>{ressource.user?.id}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Rôle</Text>
                                                 <Text ellipsis>{ressource.user?.role}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Pays</Text>
                                                 <Text ellipsis>{ressource.user?.country}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Adresse</Text>
                                                 <Text ellipsis>{ressource.user?.city}</Text>
                                          </div>
                                          <div className="flex flex-row gap-2">
                                                 <Text type="secondary" className="whitespace-nowrap">Code postal</Text>
                                                 <Text ellipsis>{ressource.user?.postalCode}</Text>
                                          </div>
                                   </div>

                            }
                                   title="Informations de l'utilisateur" trigger="hover">
                                   <div className='flex flex-row justify-start items-center' style={{ cursor: 'pointer' }}>
                                          <Avatar
                                                 src={ressource.user?.imgURL}
                                                 alt={`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                                          />
                                          <div style={{ marginLeft: 8 }}>
                                                 {`${ressource.user?.firstName} ${ressource.user?.lastName}`}
                                          </div>
                                   </div>
                            </Popover>
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
              children: <p>{ressource.description}</p>, // The main content of the panel
              // You can include more detailed structures here as needed
       }));

       return (
              <Collapse accordion size='large' items={collapseItems} className='w-full' />
       );
};