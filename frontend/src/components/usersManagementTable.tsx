"use client"
import React, { useEffect, useState } from 'react';
import { Table, Input, InputNumber, Popconfirm, Form, Typography, Select, Button, Divider, message } from 'antd';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { Avatar, Space } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';

const originData: User[] = [];
for (let i = 0; i < 100; i++) {
       originData.push({
              id: i.toString(),
              firstName: `Edward ${i}`,
              lastName: `Smith ${i}`,
              email: `edward${i}@example.com`,
              role: i % 2 === 0 ? 'Utilisateur' : 'Moderateur',
              city: `City ${i}`,
              country: `Country ${i}`,
              postalCode: `${i}${i}${i}${i}`,
              isEmailVerified: i % 2 === 0,
       });
}

const EditableTable: React.FC = () => {
       interface tableSettings {
              perPage: number;
              page: number;
              total?: number;
              lastPage?: number;
       }
       const [form] = Form.useForm();
       const [data, setData] = useState(originData);
       const [editingKey, setEditingKey] = useState('');
       const isEditing = (record: User) => record.id === editingKey;
       const [tableParams, setTableParams] = useState({ perPage: 10, page: 1 } as tableSettings);
       const [loading, setLoading] = useState(false);

       useEffect(() => {
              setLoading(true);
              const fetchData = async () => {
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
                            setTableParams({ ...tableParams, total: response.data.totalUsers, lastPage: response.data.lastPage });

                            const userData: User[] = response.data.users;
                            setData(userData);

                     } catch (error) {
                            console.log("we get tehe")
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
              fetchData(); // Call the fetchData function
       }, []);

       const EditableCell: React.FC<{ editing: boolean; dataIndex: keyof User; title: string; inputType: 'text' | 'number' | 'select' | 'boolean'; record: User; index: number; children: React.ReactNode; }> = ({ editing, dataIndex, title, inputType, record, index, children, ...restProps }) => {
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
                                   valuePropName="checked" // Ensure the Form.Item correctly binds the checkbox state
                                   style={{ margin: 0 }}
                            >
                                   <Input type="checkbox" checked={record[dataIndex] as unknown as boolean} />
                            </Form.Item>
                     );
              }

              return (
                     <td {...restProps}>
                            {editing ? (
                                   <Form.Item
                                          // name={dataIndex}
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
              form.setFieldsValue({ ...record, city: record.city, country: record.country, postalCode: record.postalCode });
              if (record.id !== undefined) {
                     setEditingKey(record.id);
              } else {
                     console.error('Attempted to edit a record without an ID.');
              }
       };

       const handleTableChange = (pagination: any, filters: any, sorter: any) => {
              setLoading(true);
              const fetchData = async () => {
                     try {
                            const response = await axios({
                                   method: 'get',
                                   baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                                   url: "/users",
                                   withCredentials: true,
                                   params: { perPage: pagination.pageSize, page: pagination.current },
                                   responseType: 'json',
                                   timeout: 10000, // * Increased value because we had some timeout errors
                            });

                            const userData: User[] = response.data.users;
                            setData(userData);
                            setTableParams({ ...tableParams, total: response.data.totalUsers, lastPage: response.data.lastPage, perPage: pagination.pageSize, page: pagination.current });
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
              fetchData(); // Call the fetchData function
       }

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

       const expandedRowRender = (record: User) => {
              const editable = isEditing(record);
              return (
                     <div className='flex flex-col md:flex-row h-96 p-10'>
                            <div className='w-full md:w-1/2 p-4'>
                                   {editable ? (
                                          <>
                                                 <Form.Item label="City" name="city" style={{ marginBottom: 7 }}>
                                                        <Input />
                                                 </Form.Item>
                                                 <Form.Item label="Country" name="country" style={{ marginBottom: 7 }}>
                                                        <Input />
                                                 </Form.Item>
                                                 <Form.Item label="Postal Code" name="postalCode" style={{ marginBottom: 7 }}>
                                                        <Input />
                                                 </Form.Item>
                                          </>
                                   ) : (
                                          <>
                                                 <div style={{ marginBottom: 7 }}>
                                                        <strong>City:</strong> {record.city}
                                                 </div>
                                                 <div style={{ marginBottom: 7 }}>
                                                        <strong>Country:</strong> {record.country}
                                                 </div>
                                                 <div style={{ marginBottom: 7 }}>
                                                        <strong>Postal Code:</strong> {record.postalCode}
                                                 </div>
                                          </>
                                   )}
                            </div>

                            <Divider className='md:!h-full' type='vertical'></Divider>
                            <div className='w-full md:w-1/2 flex flex-row space-x-12 justify-center items-center p-4'>
                                   <Avatar draggable={false} shape="square" size={150} src="https://cdn-icons-png.flaticon.com/512/1160/1160358.png" />

                                   {/* <img src="https://cdn-icons-png.flaticon.com/512/1160/1160358.png" alt="User" style={{ width: "100px", height: "100px", borderRadius: "50%", marginTop: "10px" }} /> */}
                            </div>
                     </div>
              );
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
                     title: 'First Name',
                     dataIndex: 'firstName',
                     editable: true,
              },
              {
                     title: 'Last Name',
                     dataIndex: 'lastName',
                     editable: true,
              },
              {
                     title: 'Role',
                     dataIndex: 'role',
                     editable: true,
                     render: (role: User['role']) => role ? role.charAt(0).toUpperCase() + role.slice(1) : '',
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
              title: 'Operation',
              dataIndex: 'operation',
              fixed: 'right' as const,
              render: (_, record: User) => {
                     const editable = isEditing(record);
                     return editable ? (
                            <span>
                                   <Typography.Link
                                          onClick={() => save(record.id!)}
                                          style={{ marginRight: 8 }}
                                   >
                                          Save
                                   </Typography.Link>
                                   <Popconfirm title="Sure to cancel?" onConfirm={cancel}>
                                          <a>Cancel</a>
                                   </Popconfirm>
                            </span>
                     ) : (
                            <Typography.Link disabled={editingKey !== ''} onClick={() => edit(record)}>
                                   Edit
                            </Typography.Link>
                     );
              },
       });

       return (
              <Form form={form} component={false}>
                     <Table
                            onChange={handleTableChange}
                            style={{ overflow: 'auto' }}
                            sticky
                            loading={loading}
                            components={{ body: { cell: EditableCell } }}
                            bordered
                            dataSource={data}
                            columns={columns}
                            rowKey="id"
                            pagination={{ onChange: cancel, total: tableParams.total, pageSize: tableParams.perPage, current: tableParams.page, showSizeChanger: true, pageSizeOptions: ['10', '20', '50', '100'], showTotal: (total, range) => `${range[0]}-${range[1]} of ${total} items` }}
                            // rowSelection={{ type: 'checkbox' }}
                            expandable={{ expandedRowRender }}
                            scroll={{ x: 'max-content' }}
                     />
              </Form>
       );
};
export default EditableTable;
