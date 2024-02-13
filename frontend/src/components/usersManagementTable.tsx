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
       const [form] = Form.useForm();
       const [data, setData] = useState(originData);
       const [editingKey, setEditingKey] = useState('');
       const isEditing = (record: User) => record.id === editingKey;

       useEffect(() => {
              try {
                     const fetchData = async () => {
                            const response = await axios({
                                   method: 'get',
                                   baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                                   url: "/users",
                                   withCredentials: true,
                                   params: {
                                          "perPage": 2,
                                          "page": 1,
                                   },
                                   responseType: 'json',
                                   timeout: 10000, // * Increased value because we had some timeout errors
                            });

                            console.log("🚀 ~ fetchData ~ response", response.data);

                            const userData: User[] = response.data.users;
                            console.log("🚀 ~ fetchData ~ userData:", userData);
                            setData(userData);
                     };
                     fetchData(); // Call the fetchData function

              } catch (error) {
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
                            // setSignUpLoading(false);
                     }, 1000);
              }

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

       // Adjusted expandedRowRender to include Mail Verified and Image
       const expandedRowRender = (record: User) => {
              const editable = isEditing(record);
              return (
                     <div className='flex flex-col md:flex-row h-96 p-10'>
                            <div className='w-full md:w-1/2 p-4'>
                                   <Form
                                          form={form}
                                          layout="horizontal"
                                          initialValues={{ city: record.city, country: record.country, postalCode: record.postalCode }}
                                   >
                                          <Form
                                                 form={form}
                                                 layout="horizontal"
                                                 initialValues={{ city: record.city, country: record.country, postalCode: record.postalCode }}
                                          >
                                                 <Form.Item label="City" name="city"
                                                        style={{ marginBottom: 7 }}
                                                 >
                                                        {editable ? <Input /> : record.city}
                                                 </Form.Item>
                                                 <Form.Item
                                                        style={{ marginBottom: 7 }}

                                                        label="Country" name="country">
                                                        {editable ? <Input /> : record.country}
                                                 </Form.Item>
                                                 <Form.Item
                                                        style={{ marginBottom: 7 }}

                                                        label="Postal Code" name="postalCode">
                                                        {editable ? <Input /> : record.postalCode}
                                                 </Form.Item>

                                                 <div className='flex flex-row items-center space-x-2'>

                                                        <span>{"Mail Verified: "}</span>
                                                        {record.isEmailVerified ? (
                                                               <CheckCircleOutlined style={{ color: "green", fontSize: "1.2rem" }} />
                                                        ) : (
                                                               <CloseCircleOutlined style={{ color: "red", fontSize: "1.2rem" }} />
                                                        )}
                                                 </div>
                                          </Form>
                                   </Form>
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
                            style={{ overflow: 'auto' }}
                            sticky
                            components={{ body: { cell: EditableCell } }}
                            bordered
                            dataSource={data}
                            columns={columns}
                            rowKey="id"
                            pagination={{ onChange: cancel }}
                            // rowSelection={{ type: 'checkbox' }}
                            expandable={{ expandedRowRender }}
                            scroll={{ x: 'max-content' }}
                     />
              </Form>
       );
};


export default EditableTable;
