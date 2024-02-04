"use client"
import React, { useState } from 'react';
import { Table, Input, InputNumber, Popconfirm, Form, Typography } from 'antd';
import User from '@/types/user';
import { Select } from 'antd';
import { ColumnType } from 'antd/es/table';
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';

const originData: User[] = [];
for (let i = 0; i < 100; i++) {
       originData.push({
              id: i.toString(),
              firstName: `Edward ${i}`,
              lastName: `Smith ${i}`,
              email: `edwafezefzfzefzefzefzfzefzefrd${i}@example.com`,
              role: i % 2 === 0 ? 'user' : 'moderator', // Example role
              city: `City ${i}`,
              country: `Country ${i}`,
              postalCode: `${i}${i}${i}${i}`,
              isEmailVerified: i % 2 === 0,
       });
}

const EditableTable = () => {
       const [data, setData] = useState(originData);
       const [editingKey, setEditingKey] = useState('');

       const expandedRowRender = (record: User) => (
              <p>
                     City: {record.city}, Country: {record.country}, Postal Code: {record.postalCode}
              </p>
       );

       // Will return either the value of the cell or an input to edit the cell
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

       const [form] = Form.useForm();

       const isEditing = (record: User) => record.id === editingKey;

       const edit = (record: User) => {
              form.setFieldsValue({ ...record });
              setEditingKey(record.id!);
       };

       const cancel = () => {
              setEditingKey('');
       };

       const save = async (key: React.Key) => {
              try {
                     const row = (await form.validateFields()) as User;
                     const newData = [...data];
                     const index = newData.findIndex((item) => key === item.id);
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
              {
                     title: 'Mail Verified',
                     dataIndex: 'isEmailVerified',
                     editable: false,
                     width: 150,
                     align: 'center' as const,
                     render: (_: unknown, { isEmailVerified }: User) => (
                            isEmailVerified ? <CheckCircleOutlined style={{ color: "green", fontSize: "1.2rem" }} /> : <CloseCircleOutlined style={{ color: "red", fontSize: "1.2rem" }} />
                     ),
              },
              {
                     title: 'Image',
                     dataIndex: 'imgURL',
                     editable: false,
                     render: (imgURL: string) => imgURL ? <img src={imgURL} alt="User" style={{ width: "50px", height: "50px", borderRadius: "50%" }} /> : "No image",
              },
              {
                     title: 'City',
                     dataIndex: 'city',
                     editable: true,
              },
              {
                     title: 'Country',
                     dataIndex: 'country',
                     editable: true,
              },
              {
                     title: 'Postal Code',
                     dataIndex: 'postalCode',
                     editable: true,
              },
              // Operation column remains as previously defined...
       ].map(col => ({
              ...col,
              onCell: (record: User) => ({
                     record,
                     inputType: col.dataIndex === 'isEmailVerified' ? 'boolean' : (col.dataIndex === 'email' ? 'email' : (col.dataIndex === 'role' ? 'select' : 'text')),
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
                            columns={columns as any}
                            rowClassName="editable-row"
                            rowKey="id"
                            pagination={{ onChange: cancel }}
                            rowSelection={{ type: 'checkbox' }}
                            expandable={{
                                   expandedRowRender: record => expandedRowRender(record),
                            }}
                            scroll={{ x: "max-content" }} // Adjust this value based on the total width of your columns

                     />

              </Form>
       );
};

export default EditableTable;
