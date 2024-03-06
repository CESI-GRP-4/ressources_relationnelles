import React, { useState } from 'react';
import { Avatar, Button, List, Card, Typography, Tag } from 'antd';
// import User from '@/types/user';
import Link from 'next/link';
import { PlusCircleOutlined } from '@ant-design/icons';

interface DataType {
       userHistory: {
              userModified: User;
              modifiedBy: User;
              action: 'Modify' | 'Delete' | 'Ban' | 'Unban';
              time: string;
       }[];
}

const getTagColor = (action: 'Modify' | 'Delete' | 'Ban' | 'Unban') => {
       switch (action) {
              case 'Modify':
                     return 'blue';
              case 'Ban':
                     return 'volcano';
              case 'Delete':
                     return 'red';
              case 'Unban':
                     return 'green'; // Assuming you want a color for 'Unban' action as well
              default:
                     return 'default';
       }
};

interface User {
       firstName: string;
       lastName: string;
       email: string;
       imgURL: string;
}

// Mock Users
const user1: User = {
       firstName: "John",
       lastName: "Doe",
       email: "john.doe@example.com",
       imgURL: "https://randomuser.me/api/portraits/men/1.jpg",
};

const user2: User = {
       firstName: "Jane",
       lastName: "Doe",
       email: "jane.doe@example.com",
       imgURL: "https://randomuser.me/api/portraits/women/1.jpg",
};

// Mock Data for userHistory
const mockUserHistory: DataType = {
       userHistory: [
              {
                     userModified: user1,
                     modifiedBy: user2,
                     action: 'Modify',
                     time: "2023-03-15T12:00:00Z",
              },
              {
                     userModified: user2,
                     modifiedBy: user1,
                     action: 'Ban',
                     time: "2023-03-16T15:00:00Z",
              },
              {
                     userModified: user1,
                     modifiedBy: user2,
                     action: 'Unban',
                     time: "2023-03-17T18:00:00Z",
              },
              {
                     userModified: user2,
                     modifiedBy: user1,
                     action: 'Delete',
                     time: "2023-03-18T20:00:00Z",
              },
       ],
};
export default function History({ isPreview = false }: { isPreview?: boolean }) {
       const [list, setList] = useState<DataType>(mockUserHistory); // Updated to not be an array

       return (
              <Card
                     title="Actions récentes sur les utilisateurs"
                     extra={<Link href="/gestion-utilisateurs-historique"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
              >
                     <List
                            itemLayout="horizontal"
                            dataSource={list.userHistory} // Directly use list.userHistory since list is now a DataType object
                            renderItem={(item) => (
                                   <List.Item>
                                          <div className='flex flex-row justify-start items-center'>
                                                 <Avatar src={item.userModified.imgURL} />
                                                 <div style={{ margin: '0 8px', display: 'flex', flexDirection: 'column', alignItems: 'start' }}>
                                                        <div>
                                                               {`${item.userModified.firstName} ${item.userModified.lastName} a été `}
                                                               <Tag color={getTagColor(item.action)}>{item.action}</Tag>
                                                               {` par `}
                                                               <Typography.Link href={`mailto:${item.modifiedBy.email}`}>
                                                                      {item.modifiedBy.email}
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
