"use client"
import React, { useEffect, useRef, useState } from 'react';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { ReloadOutlined, RightCircleOutlined, CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import { Table, Typography, Select, Button, message, Tooltip, Avatar, Tag, Popover } from 'antd';
import { useUser } from '@/providers/userProvider';
const { Text } = Typography;
import { getUserAttributeLabelsInFrench } from '@/utils/userAttributesToFrench';
import { tableSettings } from '@/utils/tableParams';
interface userHistory {
       userModified: User;
       modifyBy: User;
       action: 'Modify' | 'Delete' | 'Ban' | 'Unban' | 'Created';
       time: string;
       colName: string;
       newValue: string;
       oldValue: string;
};

const getTagColor = (action: 'Modify' | 'Delete' | 'Ban' | 'Unban' | 'Created') => {
       switch (action) {
              case 'Modify':
                     return 'blue';
              case 'Ban':
                     return 'volcano';
              case 'Delete':
                     return 'red';
              case 'Unban':
                     return 'green'; // Assuming you want a color for 'Unban' action as well
              case 'Created':
                     return 'geekblue';
              default:
                     return 'default';
       }
};

const UserManagementHistoryTable: React.FC = () => {

       const currentUser = useUser();
       const [tableData, setTableData] = useState<userHistory[] | null>(null);
       const [tableParams, setTableParams] = useState({ perPage: 10, page: 1 } as tableSettings);
       const [isTableLoading, setIsTableLoading] = useState(false);
       const [selectedColumns, setSelectedColumns] = useState<string[]>([
              'userModified',
              'action',
              'change',
              'modifyBy',
              // 'time',
       ]); // array of strings representing the columns to display
       const userLabelsInFrench = getUserAttributeLabelsInFrench();

       useEffect(() => {
              fetchData(tableParams)
       }, []);

       const EditableCell: React.FC<{
              editing: boolean;
              dataIndex: keyof User;
              title: string;
              inputType: 'text' | 'number' | 'select' | 'boolean';
              record: User;
              index: number;
              children: React.ReactNode;
       }> = ({
              editing,
              dataIndex,
              title,
              inputType,
              record,
              index,
              children,
              ...restProps
       }) => {
                     return (
                            <td {...restProps}>
                                   {dataIndex ? (
                                          <Tooltip
                                                 title={
                                                        dataIndex === 'isEmailVerified'
                                                               ? record.isEmailVerified
                                                                      ? "L'adresse email est vérifiée"
                                                                      : "L'adresse email n'est pas vérifiée"
                                                               : dataIndex === 'isBanned'
                                                                      ? record.isBanned
                                                                             ? "L'utilisateur est banni"
                                                                             : "L'utilisateur n'est pas banni"
                                                                      : children
                                                 }
                                          >
                                                 {dataIndex === 'email' ? <Typography.Link>{children}</Typography.Link> : children}
                                          </Tooltip>
                                   ) : children
                                   }
                            </td>
                     );
              };

       const handleTableChange = (pagination: any, filters: any, sorter: any) => {
              fetchData({ ...tableParams, perPage: pagination.pageSize, page: pagination.current });
       }

       const fetchData = async (tableParams: tableSettings) => {
              setIsTableLoading(true);
              try {
                     const response = await axios({
                            method: 'get',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL, // * Might be changed depending on the backend implementation
                            url: "/usershistory",
                            withCredentials: true,
                            params: tableParams,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     const userData: userHistory[] = response.data.userHistory;
                     setTableData(userData);
                     setTableParams({ ...tableParams, total: response.data.totalUsers, lastPage: response.data.lastPage, perPage: tableParams.perPage, page: tableParams.page });
              } catch (error) {
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 403:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 422:
                                          message.error('Champs manquants ou invalides');
                                          break;
                                   default:
                                          message.error(`Erreur inconnue`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              }
              finally {
                     setIsTableLoading(false);
              }
       };

       const columns = [
              {
                     title: 'Utilisateur modifié',
                     dataIndex: 'userModified',
                     key: 'userModified',
                     render: (_: undefined, record: userHistory) => {
                            const userInfo = record.userModified;
                            const popoverContent = (
                                   <div>
                                          <div className="mt-5 space-y-1 pr-7">
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Email</Text>
                                                        <Typography.Link ellipsis copyable>{userInfo.email}</Typography.Link>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">ID</Text>
                                                        <Text ellipsis copyable>{userInfo.id}</Text>
                                                 </div>
                                                 {/* Display all the other information */}
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Prénom</Text>
                                                        <Text ellipsis>{userInfo.firstName}</Text>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Nom</Text>
                                                        <Text ellipsis>{userInfo.lastName}</Text>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Rôle</Text>
                                                        <Text ellipsis>{userInfo.role}</Text>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Pays</Text>
                                                        <Text ellipsis>{userInfo.country}</Text>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Adresse</Text>
                                                        <Text ellipsis>{userInfo.city}</Text>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Text type="secondary" className="whitespace-nowrap">Code postal</Text>
                                                        <Text ellipsis>{userInfo.postalCode}</Text>
                                                 </div>
                                          </div>
                                   </div>
                            );

                            return (
                                   <Popover content={popoverContent} title="Informations de l'utilisateur" trigger="hover">
                                          <div className='flex flex-row justify-start items-center' style={{ cursor: 'pointer' }}>
                                                 <Avatar
                                                        src={userInfo.imgURL}
                                                        alt={`${userInfo.firstName} ${userInfo.lastName}`}
                                                 />
                                                 <div style={{ marginLeft: 8 }}>
                                                        {`${userInfo.firstName} ${userInfo.lastName}`}
                                                 </div>
                                          </div>
                                   </Popover>
                            );
                     },
              },
              {
                     title: 'Action',
                     dataIndex: 'action',
                     key: 'action',
                     render: (action: 'Modify' | 'Delete' | 'Ban' | 'Unban' | 'Created') => {
                            let actionText;
                            switch (action) {
                                   case 'Delete':
                                          actionText = 'Utilisateur supprimé';
                                          break;
                                   case 'Ban':
                                          actionText = 'Utilisateur banni';
                                          break;
                                   case 'Unban':
                                          actionText = 'Utilisateur débanni';
                                          break;
                                   case 'Modify':
                                          actionText = 'Utilisateur modifié';
                                          break;
                                   case 'Created':
                                          actionText = 'Utilisateur créé';
                                          break;
                                   default:
                                          break;
                            }
                            return <Tag color={getTagColor(action)}>{actionText}</Tag>;
                     },
              },
              {
                     title: 'Changement',
                     key: 'change',
                     dataIndex: 'change',
                     render: (_: unknown, record: userHistory) => {
                            if (record.action === 'Unban') {
                                   return null; // or return ""; to explicitly render nothing
                            }

                            const translatedColName = userLabelsInFrench[record.colName]; // Assume this correctly translates attribute names

                            let oldValueDisplay;
                            let newValueDisplay;

                            const options: Intl.DateTimeFormatOptions = {
                                   year: 'numeric',
                                   month: 'long',
                                   day: 'numeric',
                                   hour: '2-digit',
                                   minute: '2-digit',
                            };
                            // Convert timestamp to readable date in French format for "Ban" action
                            if (record.action === 'Ban') {
                                   if (record.oldValue) {
                                          const oldDate = new Date(parseInt(record.oldValue) * 1000);
                                          oldValueDisplay = new Intl.DateTimeFormat('fr-FR', options).format(oldDate);
                                   } else {
                                          oldValueDisplay = "N/A";
                                   }

                                   if (record.newValue) {
                                          const newDate = new Date(parseInt(record.newValue) * 1000);
                                          newValueDisplay = new Intl.DateTimeFormat('fr-FR', options).format(newDate);
                                   } else {
                                          newValueDisplay = "N/A";
                                   }

                                   oldValueDisplay = <span style={{ backgroundColor: '#ffebee', color: '#d32f2f' }}>{oldValueDisplay}</span>;
                                   newValueDisplay = <span style={{ backgroundColor: '#e8f5e9', color: '#2e7d32' }}>{newValueDisplay}</span>;
                            } else if (record.colName === 'is_verified') {
                                   // Specific logic for isEmailVerified attribute
                                   oldValueDisplay = record.oldValue === '1' ? (
                                          <Tooltip title="L'email était vérifié">
                                                 <CheckCircleOutlined style={{ color: 'green' }} />
                                          </Tooltip>
                                   ) : (
                                          <Tooltip title="L'email n'était pas vérifié">
                                                 <CloseCircleOutlined style={{ color: 'red' }} />
                                          </Tooltip>
                                   );

                                   newValueDisplay = record.newValue === '1' ? (
                                          <Tooltip title="L'email est désormais vérifié">
                                                 <CheckCircleOutlined style={{ color: 'green' }} />
                                          </Tooltip>
                                   ) : (
                                          <Tooltip title="L'email est désormais non vérifié">
                                                 <CloseCircleOutlined style={{ color: 'red' }} />
                                          </Tooltip>
                                   );
                            } else {
                                   // Default display for other attributes
                                   oldValueDisplay = <span style={{ backgroundColor: '#ffebee', color: '#d32f2f' }}>{record.oldValue}</span>;
                                   newValueDisplay = <span style={{ backgroundColor: '#e8f5e9', color: '#2e7d32' }}>{record.newValue}</span>;
                            }

                            // Combine old value, arrow icon, and new value for display
                            return (
                                   <span>
                                          {record.action === 'Modify' && (translatedColName || record.colName)}{record.action === 'Modify' && ":"}
                                          <span className='ml-1'>{oldValueDisplay}</span>
                                          <RightCircleOutlined style={{ color: 'blue' }} className='mx-1' />
                                          {newValueDisplay}
                                   </span>
                            );
                     },
              }
              ,
              {
                     title: 'Par',
                     dataIndex: 'modifyBy',
                     key: 'modifyBy',
                     render: (modifyBy: User) => (
                            <Typography.Link href={`mailto:${modifyBy.email}`}>
                                   {modifyBy.email}
                            </Typography.Link>
                     ),
              },
              {
                     title: 'Date',
                     dataIndex: 'time',
                     key: 'time',
                     render: (time: string) => (
                            <Typography.Text>
                                   {new Date(time).toLocaleString()}
                            </Typography.Text>
                     ),
              },
       ];
       // .map(col => ({
       //        ...col,
       //        onCell: (record: userHistory) => ({ // Update the type of the 'record' parameter to 'userHistory'
       //               record,
       //               inputType: col.dataIndex === 'isEmailVerified' ? 'boolean' : col.dataIndex === 'role' || col.dataIndex === 'country' ? 'select' : 'text',
       //               dataIndex: col.dataIndex,
       //               title: col.title as string,
       //        }),
       // }));

       const handleColumnChange = (value: string[]) => {
              setSelectedColumns(value);
       };

       const getVisibleColumns = (): ColumnType<userHistory>[] => {
              return columns.filter(col => selectedColumns.includes(col.dataIndex as string) || selectedColumns.includes(col.key as string));
       };

       return (
              <div className='space-y-10'>
                     <div className="flex flex-col items-start lg:flex-row lg:items-center gap-5">
                            <Select
                                   maxTagCount={5}
                                   mode="multiple"
                                   allowClear
                                   className='w-72'
                                   placeholder="Sélectionner les colonnes à afficher"
                                   value={selectedColumns}
                                   onChange={handleColumnChange}
                            >
                                   {columns.map(col => (
                                          <Select.Option key={col.dataIndex as string} value={col.dataIndex as string}>
                                                 {col.title as string}
                                          </Select.Option>
                                   ))}
                            </Select>
                            <Button
                                   type="primary"
                                   onClick={() => setSelectedColumns(columns.map(col => col.dataIndex || col.key))}
                            >
                                   Tout afficher
                            </Button>


                            <Button type="primary" icon={<ReloadOutlined />} onClick={() => fetchData(tableParams)}>Rafraîchir</Button>


                     </div>
                     <Table
                            onChange={handleTableChange}
                            style={{ overflow: 'auto' }}
                            sticky
                            loading={isTableLoading}
                            components={{ body: { cell: EditableCell } }}
                            bordered
                            dataSource={tableData ?? []} // * Added nullish coalescing operator to prevent error
                            columns={getVisibleColumns()}
                            rowKey={record => `${record.userModified.id}-${record.modifyBy.id}-${record.time}`}
                            pagination={{ showQuickJumper: true, total: tableParams.total, pageSize: tableParams.perPage, current: tableParams.page, showSizeChanger: true, pageSizeOptions: ['10', '20', '50', '100'], showTotal: (total, range) => `${range[0]}-${range[1]} sur ${total}` }}
                            scroll={{ x: 'max-content', y: 610 }}
                     />
              </div>
       );
};
export default UserManagementHistoryTable;