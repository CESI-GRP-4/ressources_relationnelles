"use client"
import React, { useEffect, useState } from 'react';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import { Table, Input, InputNumber, Popconfirm, Form, Typography, Select, Button, message } from 'antd';

const EditableTable: React.FC = () => {
       interface tableSettings {
              perPage: number;
              page: number;
              total?: number;
              lastPage?: number;
       }

       const [form] = Form.useForm();
       const [data, setData] = useState([] as User[]);
       const [editingKey, setEditingKey] = useState('');
       const isEditing = (record: User) => record.id === editingKey;
       const [tableParams, setTableParams] = useState({ perPage: 10, page: 1 } as tableSettings);
       const [loading, setLoading] = useState(false);
       const [selectedColumns, setSelectedColumns] = useState<string[]>([
              'email', 'firstName', 'lastName', 'role', 'isEmailVerified', 'operation'
       ]);


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
                     let inputNode = <Input />;
                     if (inputType === 'select' && dataIndex === 'role') {
                            inputNode = (
                                   <Select>
                                          <Select.Option value="user">User</Select.Option>
                                          <Select.Option value="moderator">Moderator</Select.Option>
                                          <Select.Option value="administrator">Administrator</Select.Option>
                                          <Select.Option value="superadministrator">Super-administrator</Select.Option>
                                   </Select>
                            );
                     } else if (inputType === 'number') {
                            inputNode = <InputNumber />;
                     } else if (inputType === 'boolean') {
                            inputNode = (
                                   <Form.Item
                                          name={dataIndex}
                                          valuePropName="checked"
                                          style={{ margin: 0 }}
                                   >
                                          <Input type="checkbox" />
                                   </Form.Item>
                            );
                     }

                     return (
                            <td {...restProps}>
                                   {editing ? (
                                          <Form.Item
                                                 name={dataIndex}
                                                 style={{ margin: 0 }}
                                                 rules={[{ required: true, message: `Please Input ${title}!` }]}
                                          >
                                                 {inputNode}
                                          </Form.Item>
                                   ) : (
                                          children
                                   )}
                            </td>
                     );
              };

       const edit = (record: User) => {
              console.log("🚀 ~ edit ~ record:", record);
              form.setFieldsValue({ ...record, city: record.city, country: record.country, postalCode: record.postalCode });
              setEditingKey(record.id as string);

              if (record.id !== undefined) {
                     setEditingKey(record.id as string);
              } else {
                     console.error('Attempted to edit a record without an ID.');
              }
       };

       const handleTableChange = (pagination: any, filters: any, sorter: any) => {
              fetchData({ ...tableParams, perPage: pagination.pageSize, page: pagination.current });
       }

       const fetchData = async (tableParams: tableSettings) => {
              setLoading(true);
              try {
                     const response = await axios({
                            method: 'get',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: "/users",
                            withCredentials: true,
                            params: tableParams,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     const userData: User[] = response.data.users;
                     setData(userData);
                     setTableParams({ ...tableParams, total: response.data.totalUsers, lastPage: response.data.lastPage, perPage: tableParams.perPage, page: tableParams.page });
              } catch (error) { // TODO : Handle errors
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 422:
                                          message.error('Champs manquants ou invalides');
                                          break;
                                   case 409:
                                          message.error(`Un compte avec cette adresse e-mail existe déjà`);
                                   default:
                                          message.error(`Échec de l'inscription`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
                     // return null;
              }
              finally {
                     setTimeout(() => {
                            setLoading(false);
                     }, 1000);
              }
       };

       const cancel = () => {
              setEditingKey('');
       };

       const save = async (key: React.Key) => {
              try {
                     const row = await form.validateFields();
                     const newData = [...data];
                     const index = newData.findIndex(item => key === item.id);

                     if (index > -1) {
                            const item = newData[index];
                            newData.splice(index, 1, { ...item, ...row });
                            setData(newData);
                            setEditingKey('');
                     }
              } catch (errInfo) {
                     console.log('Validate Failed:', errInfo);
              }
       };

       const columns: ColumnType<User>[] = [
              {
                     title: 'Email',
                     dataIndex: 'email',
                     editable: true,
                     fixed: 'left' as const,
                     width: 200,
              },
              {
                     title: 'Prénom',
                     dataIndex: 'firstName',
                     editable: true,
              },
              {
                     title: 'Nom',
                     dataIndex: 'lastName',
                     editable: true,
              },
              {
                     title: 'Rôle',
                     dataIndex: 'role',
                     editable: true,
                     render: (role: User['role']) => role ? role.charAt(0).toUpperCase() + role.slice(1) : '',
              },
              {
                     title: 'Pays',
                     dataIndex: 'country',
                     editable: true,
              },
              {
                     title: 'Ville',
                     dataIndex: 'city',
                     editable: true,
              },

              {
                     title: 'Code Postal',
                     dataIndex: 'postalCode',
                     editable: true,
              },
              {
                     title: 'Email vérifié',
                     dataIndex: 'isEmailVerified',
                     editable: true,
                     align: 'center' as const,
                     render: (isEmailVerified: User['isEmailVerified']) => isEmailVerified ? <CheckCircleOutlined style={{ color: 'green' }} className='px-4' /> : <CloseCircleOutlined className='px-4' style={{ color: 'red' }} />,
              },
              {
                     title: 'Créé le',
                     dataIndex: 'createdAt',
                     editable: false,
                     render: (createdAt: User['createdAt']) =>
                            createdAt ? new Date(createdAt).toLocaleDateString('fr-FR', { year: 'numeric', month: 'long', day: 'numeric' }) : 'N/A',
              },
              {
                     title: 'Modifié le',
                     dataIndex: 'updatedAt',
                     editable: false,
                     render: (updatedAt: User['updatedAt']) =>
                            updatedAt ? new Date(updatedAt).toLocaleDateString('fr-FR', { year: 'numeric', month: 'long', day: 'numeric' }) : 'N/A',
              },
       ].map(col => ({
              ...col,
              onCell: (record: User) => ({
                     record,
                     inputType: col.dataIndex === 'isEmailVerified' ? 'boolean' : col.dataIndex === 'role' ? 'select' : 'text',
                     dataIndex: col.dataIndex,
                     title: col.title,
                     editing: isEditing(record),
              }),
       }));

       columns.push({
              title: 'Actions',
              dataIndex: 'operation',
              width: 250,
              fixed: 'right' as const,
              render: (_, record: User) => {
                     const editable = isEditing(record);
                     return editable ? (
                            <span>
                                   <Popconfirm title="Sauvegarder ?" className='mr-2' onConfirm={() => save(record.id!)}>
                                          <Button type="primary" ghost>Enregistrer</Button>
                                   </Popconfirm>

                                   <Popconfirm title="Annuler ?" onConfirm={cancel}>
                                          <Button danger>Annuler</Button>
                                   </Popconfirm>
                            </span>
                     ) : (
                            <Typography.Link disabled={editingKey !== ''} onClick={() => edit(record)}>
                                   Modifier
                            </Typography.Link>
                     );
              },
       });

       const handleColumnChange = (value: string[]) => {
              setSelectedColumns(value);
       };

       const getVisibleColumns = (): ColumnType<User>[] => {
              return columns.filter(col => selectedColumns.includes(col.dataIndex as string));
       };

       return (
              <div className='space-y-10'>
                     <div className="flex flex-col">
                            <span>Colonnes à afficher</span>
                            <Select
                                   maxTagCount={5}
                                   mode="multiple"
                                   allowClear
                                   className='w-56' placeholder="Select columns"
                                   defaultValue={selectedColumns.map(col => col as string)}
                                   onChange={handleColumnChange}
                            >
                                   {columns.map(col => (
                                          <Select.Option key={col.dataIndex as string} value={col.dataIndex as string}>
                                                 {col.title as string}
                                          </Select.Option>
                                   ))}
                            </Select>
                     </div>
                     <Form form={form} component={false}>
                            <Table
                                   onChange={handleTableChange}
                                   style={{ overflow: 'auto' }}
                                   sticky
                                   loading={loading}
                                   components={{ body: { cell: EditableCell } }}
                                   bordered
                                   dataSource={data}
                                   columns={getVisibleColumns()}
                                   rowKey="id"
                                   pagination={{ onChange: cancel,showQuickJumper: true, total: tableParams.total, pageSize: tableParams.perPage, current: tableParams.page, showSizeChanger: true, pageSizeOptions: ['10', '20', '50', '100'], showTotal: (total, range) => `${range[0]}-${range[1]} of ${total} items` }}
                                   scroll={{ x: 'max-content', y: 500 }}
                            />
                     </Form>
              </div>
       );
};
export default EditableTable;
