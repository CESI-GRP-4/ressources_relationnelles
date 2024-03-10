"use client"
import React, { useEffect, useRef, useState } from 'react';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { ReloadOutlined, RightCircleOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import { Table, Typography, Select, Button, message, Tooltip, Avatar, Checkbox, Tag } from 'antd';
import { useUser } from '@/providers/userProvider';
import { getUserAttributeLabelsInFrench } from '@/types/userAttributesToFrench';

interface userHistory {
       userModified: User;
       modifyBy: User;
       action: 'Modify' | 'Delete' | 'Ban' | 'Unban';
       time: string;
       colName: string;
       newValue: string;
       oldValue: string;
};

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

const UserManagementHistoryTable: React.FC = () => {
       interface tableSettings {
              perPage: number;
              page: number;
              total?: number;
              lastPage?: number;
       }
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
       const [isFixed, setIsFixed] = useState(true); // New state for tracking checkbox
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
              console.log("table settings changed", tableParams)
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

                     console.log("response", response.data);
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
                     render: (_: any, record: userHistory) => (
                            <div className='flex flex-row justify-start items-center'>
                                   <Avatar
                                          src={record.userModified.imgURL}
                                          alt={`${record.userModified.firstName} ${record.userModified.lastName}`}
                                   />
                                   <div style={{ marginLeft: 8 }}>
                                          {`${record.userModified.firstName} ${record.userModified.lastName}`}
                                   </div>
                            </div>
                     ),
              },
              {
                     title: 'Action',
                     dataIndex: 'action',
                     key: 'action',
                     render: (action: 'Modify' | 'Delete' | 'Ban' | 'Unban') => (
                            <Tag color={getTagColor(action)}>{action}</Tag>
                     ),
              },
              {
                     title: 'Changement',
                     key: 'change',
                     dataIndex: 'change',
                     render: (_: unknown, record: userHistory) => {
                            const translatedColName = userLabelsInFrench[record.colName]; // Assume this is correctly translating

                            return (
                                   record.action === 'Modify' && record.colName && record.oldValue !== undefined && record.newValue !== undefined
                                          ? <span>
                                                 {translatedColName}:
                                                 <span style={{ backgroundColor: '#ffebee', color: '#d32f2f' }} className='ml-1'>{record.oldValue}</span>
                                                 <RightCircleOutlined style={{ color: 'blue' }} className='mx-1' />
                                                 <span style={{ backgroundColor: '#e8f5e9', color: '#2e7d32' }}>{record.newValue}</span>
                                          </span> // Use the translated column name
                                          : null
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