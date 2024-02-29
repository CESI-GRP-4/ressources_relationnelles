import React, { useEffect, useState } from 'react';
import { Avatar, Button, List, Skeleton, Card, Typography, Tag } from 'antd';
import User from '@/types/user';
interface DataType {
       userModified: User;
       by: User;
       action: 'modifié' | 'banni' | 'supprimé'
}
const getTagColor = (action: 'modifié' | 'banni' | 'supprimé') => {
       switch (action) {
              case 'modifié':
                     return 'blue';
              case 'banni':
                     return 'volcano';
              case 'supprimé':
                     return 'red';
              default:
                     return 'default';
       }
};

export default function History() {
       const [list, setList] = useState<DataType[]>([{
              userModified: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aa",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              by: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aa",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              action: "modifié"
       }, {
              userModified: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aasssssssssssssssssssssss",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              by: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aasssssssssssssssssssssss",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              action: "supprimé"
       },
       {
              userModified: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aasssssssssssssssssssssss",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              by: {
                     firstName: "John",
                     lastName: "Doe",
                     email: "aa@aa.aasssssssssssssssssssssss",
                     imgURL: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
                     id: "1",
                     role: "Utilisateur",
                     isEmailVerified: true,
                     city: "New York",
                     country: "USA",
                     postalCode: "10001",
              },
              action: "banni"
       }]);

       return (
              <Card
              title="Actions récentes sur les utilisateurs"
              extra={<Typography.Link href="/gestion-utilisateurs">Plus</Typography.Link>}>
                     <List
                            itemLayout="horizontal"
                            dataSource={list}
                            renderItem={(item) => (
                                   <List.Item>
                                          <div className='flex flex-row justify-start items-center'>
                                                 <Avatar src={item.userModified.imgURL} />
                                                 <div style={{ margin: '0 8px', display: 'flex', alignItems: 'center' }}>
                                                        <div>
                                                               {`${item.userModified.firstName} ${item.userModified.lastName} was `}
                                                               <Tag color={getTagColor(item.action)}>{item.action}</Tag>
                                                               {` by `}
                                                               <Typography.Link href={`mailto:${item.by.email}`}>
                                                                      {item.by.email}
                                                               </Typography.Link>
                                                        </div>

                                                 </div>
                                          </div>
                                   </List.Item>
                            )}
                     />
              </Card>
       );
};