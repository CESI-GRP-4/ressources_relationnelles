"use client"
import React, { useEffect, useRef, useState } from 'react';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import { Table, Input, InputNumber, Popconfirm, Form, Typography, Select, Button, message, Tooltip, Space } from 'antd';
import { useUser } from '@/providers/userProvider';
import { DeleteOutlined } from '@ant-design/icons';
import { Icon as Iconify } from '@iconify/react';
import { SearchOutlined } from '@ant-design/icons';
import { FilterDropdownProps } from 'antd/es/table/interface';
import { RefObject } from 'react';
import CreateUserForm from '@/components/createUserForm';
import { ReloadOutlined } from '@ant-design/icons';

const EditableTable: React.FC = () => {
       interface tableSettings {
              perPage: number;
              page: number;
              total?: number;
              lastPage?: number;
              sortBy?: string;
              sortDirection?: "asc" | "desc";
              searchColumn?: string;
              searchValue?: string;
       }
       const currentUser = useUser();
       const [editUserForm] = Form.useForm();
       const [tableData, setTableData] = useState([] as User[]);
       const [editingKey, setEditingKey] = useState('');
       const isEditingUser = (record: User) => record.id === editingKey;
       const [tableParams, setTableParams] = useState({ perPage: 10, page: 1 } as tableSettings);
       const [isTableLoading, setIsTableLoading] = useState(false);
       const [selectedColumns, setSelectedColumns] = useState<string[]>([
              'email', 'firstName', 'lastName', 'role', 'isEmailVerified', 'operation'
       ]);
       const searchInput: RefObject<HTMLInputElement> = useRef<HTMLInputElement>(null);

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
                     const isEditable = canEdit(dataIndex, currentUser.user?.role ?? '');
                     let inputNode = <Input />;
                     if (inputType === 'select' && dataIndex === 'role') {
                            inputNode = (
                                   <Select>
                                          <Select.Option value="user">Utilisateur</Select.Option>
                                          <Select.Option value="moderator">Modérateur</Select.Option>
                                          <Select.Option value="administrator">Administrateur</Select.Option>
                                          <Select.Option value="superadministrator">Super-administrateur</Select.Option>
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
                                   {editing && isEditable ? (
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
              editUserForm.setFieldsValue({ ...record, city: record.city, country: record.country, postalCode: record.postalCode });
              setEditingKey(record.id as string);

              if (record.id !== undefined) {
                     setEditingKey(record.id as string);
              } else {
                     console.error('Attempted to edit a record without an ID.');
              }
       };

       const getColumnSearchProps = (dataIndex: keyof User): ColumnType<User> => ({
              filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }: FilterDropdownProps) => (
                     <div style={{ padding: 8 }}>
                            <Input
                                   placeholder={`Search ${dataIndex}`}
                                   value={selectedKeys[0]}
                                   onChange={e => { setTableParams({ ...tableParams, searchColumn: dataIndex as string, searchValue: e.target.value }); setSelectedKeys([e.target.value]) }}
                                   onPressEnter={() => { confirm() }}
                                   style={{ marginBottom: 8, display: 'block' }}
                            />
                            <Space>
                                   <Button
                                          type="primary"
                                          onClick={() => confirm()}
                                          icon={<SearchOutlined />}
                                          size="small"
                                          style={{ width: 90 }}
                                   >
                                          Search
                                   </Button>
                                   <Button
                                          onClick={() => { }}
                                          size="small"
                                          style={{ width: 90 }}
                                   >
                                          Reset
                                   </Button>
                            </Space>
                     </div>
              ),
              filterIcon: (filtered: any) => <SearchOutlined style={{ color: filtered ? '#1890ff' : undefined }} />,
              onFilter: (value, record) => {
                     return true;
              }, onFilterDropdownOpenChange: (visible: boolean) => {
                     if (visible) {
                            // Utiliser setTimeout pour assurer que le DOM est prêt
                            setTimeout(() => searchInput.current?.select(), 100);
                     }
              },
       });

       const handleTableChange = (pagination: any, filters: any, sorter: any) => {
              console.log("table settings changed", tableParams)
              fetchData({ ...tableParams, perPage: pagination.pageSize, page: pagination.current, sortBy: sorter.order ? sorter.field : undefined, sortDirection: sorter.order ? (sorter.order === 'ascend' ? 'asc' : 'desc') : undefined });
       }

       const fetchData = async (tableParams: tableSettings) => {
              setIsTableLoading(true);
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

                     console.log("response", response.data);
                     const userData: User[] = response.data.users;
                     setTableData(userData);
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
                     setIsTableLoading(false);
              }
       };

       const cancel = () => {
              setEditingKey('');
       };

       const save = async (key: React.Key) => {
              try {
                     const row = await editUserForm.validateFields();
                     const newData = [...tableData];
                     const index = newData.findIndex(item => key === item.id);

                     if (index > -1) {
                            const item = newData[index];
                            newData.splice(index, 1, { ...item, ...row });
                            setTableData(newData);
                            setEditingKey('');
                     }
              } catch (errInfo) {
                     console.log('Validate Failed:', errInfo);
              }
       };

       const deleteUser = async (id: string) => {
              try {
                     await axios({
                            method: 'delete',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: `/users/${id}`,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     message.success('Utilisateur supprimé avec succès');
                     fetchData(tableParams);
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
              }
       }

       const banUser = async (id: string) => {
              try {
                     await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: `/users/${id}/ban`,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     message.success('Utilisateur banni avec succès');
                     fetchData(tableParams);
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
              }
       }

       const columns: ColumnType<User>[] = [
              {
                     title: 'Email',
                     dataIndex: 'email',
                     editable: true,
                     fixed: 'left' as const,
                     width: 250,
                     // enable sorting
                     sorter: true,
                     ...getColumnSearchProps('email'), // Ajouter la recherche à la colonne "Nom"

              },
              {
                     title: 'Prénom',
                     dataIndex: 'firstName',
                     editable: true,
                     sorter: true,
                     width: 180,
                     ...getColumnSearchProps('firstName'), // Ajouter la recherche à la colonne "Nom"
              },
              {
                     title: 'Nom',
                     dataIndex: 'lastName',
                     editable: true,
                     sorter: true,
                     width: 180,
                     ...getColumnSearchProps('lastName'), // Ajouter la recherche à la colonne "Nom"
              },
              {
                     title: 'Rôle',
                     dataIndex: 'role',
                     editable: true,
                     sorter: true,
                     width: 180,
                     render: (role: User['role']) => role ? role.charAt(0).toUpperCase() + role.slice(1) : '',
                     ...getColumnSearchProps('role'), // Ajouter la recherche à la colonne "Nom"
              },
              {
                     title: 'Pays',
                     dataIndex: 'country',
                     sorter: true,
                     editable: true,
                     width: 100,
                     ...getColumnSearchProps('country'), // Ajouter la recherche à la colonne "Nom"
              },
              {
                     title: 'Ville',
                     dataIndex: 'city',
                     editable: true,
                     sorter: true,
                     width: 150,
                     ...getColumnSearchProps('city'), // Ajouter la recherche à la colonne "Nom"

              },
              {
                     title: 'Code Postal',
                     dataIndex: 'postalCode',
                     editable: true,
                     sorter: true,
                     width: 150,
                     ...getColumnSearchProps('postalCode'), // Ajouter la recherche à la colonne "Nom"
              },
              {
                     title: 'Email vérifié',
                     dataIndex: 'isEmailVerified',
                     editable: true,
                     align: 'center' as const,
                     render: (isEmailVerified: User['isEmailVerified']) => isEmailVerified ? <CheckCircleOutlined style={{ fontSize: '20px', color: 'green' }} className='px-4' /> : <CloseCircleOutlined className='px-4' style={{ fontSize: '20px', color: 'red' }} />,
                     sorter: true,
                     width: 150,
              },
              {
                     title: 'Créé le',
                     dataIndex: 'createdAt',
                     editable: false,
                     render: (createdAt: User['createdAt']) =>
                            createdAt ? new Date(createdAt).toLocaleDateString('fr-FR', { year: 'numeric', month: 'long', day: 'numeric' }) : 'N/A',
                     sorter: true,
                     width: 200,
              },
              {
                     title: 'Modifié le',
                     dataIndex: 'updatedAt',
                     editable: false,
                     render: (updatedAt: User['updatedAt']) =>
                            updatedAt ? new Date(updatedAt).toLocaleDateString('fr-FR', { year: 'numeric', month: 'long', day: 'numeric' }) : 'N/A',
                     sorter: true,
                     width: 200,
              },
              {
                     title: 'Banni',
                     dataIndex: 'isBlocked',
                     editable: false,
                     align: 'center' as const,
                     render: (isBlocked: User['isBlocked']) => isBlocked ? <Iconify className='anticon' style={{ fontSize: '20px', color: "red" }} icon="fa6-solid:user-xmark" /> : <Iconify className='anticon' style={{ fontSize: '20px', color: "green" }} icon="fa6-solid:user-check" />,
                     sorter: true,
                     width: 150,
              }
              

       ].map(col => ({
              ...col,
              onCell: (record: User) => ({
                     record,
                     inputType: col.dataIndex === 'isEmailVerified' ? 'boolean' : col.dataIndex === 'role' ? 'select' : 'text',
                     dataIndex: col.dataIndex,
                     title: col.title,
                     editing: isEditingUser(record),
              }),
       }));
       columns.push({
              title: 'Actions',
              dataIndex: 'operation',
              width: 250,
              fixed: 'right' as const,
              render: (_, record: User) => {
                     const editable = isEditingUser(record);
                     return editable ? (
                            <div>
                                   <Popconfirm title="Sauvegarder ?" className='mr-2' onConfirm={() => save(record.id!)}>
                                          <Button type="primary" ghost>Enregistrer</Button>
                                   </Popconfirm>
                                   <Popconfirm title="Annuler ?" onConfirm={cancel}>
                                          <Button danger>Annuler</Button>
                                   </Popconfirm>
                            </div>
                     ) : (
                            <div className='space-x-8 flex flex-row items-center'>
                                   <Typography.Link disabled={editingKey !== ''} onClick={() => edit(record)}>
                                          Modifier
                                   </Typography.Link>

                                   {(currentUser.user?.role === 'SuperAdministrateur' || currentUser.user?.role === 'Administrateur') && (
                                          <Popconfirm title={record.isBlocked ? "Êtes-vous sûr de vouloir révoquer le bannissement de cet utilisateur ?" : "Êtes-vous sûr de vouloir bannir cet utilisateur ?"} onConfirm={() => { }}>
                                                 <Tooltip title={record.isBlocked ? "Révoquer le bannissement" : "Bannir l'utilisateur"}>
                                                 <Button type='text' disabled={editingKey !== ''} style={{ color: record.isBlocked ? "green" : "orange" }} icon={<Iconify style={{ fontSize: '26px' }} icon="basil:user-block-solid" />}></Button>
                                                 </Tooltip>
                                          </Popconfirm>
                                   )}

                                   {currentUser.user?.role === 'SuperAdministrateur' && (
                                          <Popconfirm title="Êtes-vous sûr de vouloir supprimer cet utilisateur ?" onConfirm={() => { deleteUser(record.id!) }}>
                                                 <Tooltip title="Supprimer l'utilisateur">
                                                        <Button disabled={editingKey !== ''} danger type='text' icon={<DeleteOutlined style={{ fontSize: '22px' }}/>}></Button>
                                                 </Tooltip>

                                          </Popconfirm>
                                   )}
                            </div>
                     );
              },
       });

       const handleColumnChange = (value: string[]) => {
              setSelectedColumns(value);
       };

       const getVisibleColumns = (): ColumnType<User>[] => {
              return columns.filter(col => selectedColumns.includes(col.dataIndex as string));
       };

       const canEdit = (dataIndex: string, role: string) => {
              // Logique de permission pour l'édition
              const editableByAdmin = ['email', 'firstName', 'lastName', 'isEmailVerified', 'city', 'postalCode', 'country'];
              const editableBySuperAdmin = [...editableByAdmin, 'role'];

              if (role === 'Administrateur') {
                     return editableByAdmin.includes(dataIndex);
              } else if (role === 'SuperAdministrateur') {
                     return editableBySuperAdmin.includes(dataIndex);
              }
              return false;
       };

       return (
              <div className='space-y-10'>
                     <div className="flex flex-row items-center justify-between">
                            <div className="flex flex-row space-x-5 items-center">
                                   <Select
                                          maxTagCount={5}
                                          mode="multiple"
                                          allowClear
                                          className='w-72'
                                          placeholder="Sélectionner les colonnes à afficher"
                                          value={selectedColumns} // Utiliser value au lieu de defaultValue pour contrôler le composant
                                          onChange={handleColumnChange}
                                   >
                                          {columns.map(col => (
                                                 <Select.Option key={col.dataIndex as string} value={col.dataIndex as string}>
                                                        {col.title as string}
                                                 </Select.Option>
                                          ))}
                                   </Select>
                                   <div>
                                          <Button type="primary" onClick={() => setSelectedColumns(columns.map(col => col.dataIndex as string))}>Tout afficher</Button>
                                   </div>
                                   <div>
                                          <Button type="primary" icon={<ReloadOutlined />} onClick={() => fetchData(tableParams)}>Rafraîchir</Button>
                                   </div>
                            </div>
                            <div>
                                   {/* ajouter un utilisateur */}
                                   {/* <CreateUserForm></CreateUserForm> */}
                            </div>
                     </div>
                     <Form form={editUserForm} component={false}>
                            <Table
                                   onChange={handleTableChange}
                                   style={{ overflow: 'auto' }}
                                   sticky
                                   loading={isTableLoading}
                                   components={{ body: { cell: EditableCell } }}
                                   bordered
                                   dataSource={tableData}
                                   columns={getVisibleColumns()}
                                   rowKey="id"
                                   pagination={{ onChange: cancel, showQuickJumper: true, total: tableParams.total, pageSize: tableParams.perPage, current: tableParams.page, showSizeChanger: true, pageSizeOptions: ['10', '20', '50', '100'], showTotal: (total, range) => `${range[0]}-${range[1]} sur ${total}` }}
                                   scroll={{ x: 'max-content', y: 500 }}
                            />
                     </Form>
              </div>
       );
};
export default EditableTable;