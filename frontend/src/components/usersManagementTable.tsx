"use client"
import React, { useEffect, useRef, useState } from 'react';
import User from '@/types/user';
import { ColumnType } from 'antd/es/table';
import { CheckCircleOutlined, CloseCircleOutlined, SearchOutlined, ReloadOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import { Table, Input, InputNumber, Popconfirm, Form, Typography, Select, Button, message, Tooltip, Space, Avatar } from 'antd';
import { useUser } from '@/providers/userProvider';
import { Icon as Iconify } from '@iconify/react';
import { FilterDropdownProps } from 'antd/es/table/interface';
import { RefObject } from 'react';
import CreateUserForm from '@/components/createUserForm';
import BanUserButton from '@/components/user-management/banUserButton';
import DeleteUserButton from "@/components/user-management/deleteUserButton";
import Country from '@/types/country';

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
       const [countries, setCountries] = useState([] as Country[]);

       useEffect(() => {
              fetchData(tableParams)
              getCountries();
       }, []);

       const getCountries = async () => {
              try {
                     const response = await axios({
                            method: 'get',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/countries',
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });

                     if (response.status === 200) {
                            console.log("response", response.data);
                            setCountries(response.data.countries);
                     }
              } catch (error) {
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 400:
                                          message.error(`Requête invalide`);
                                          break;
                                   case 401:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 403:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 404:
                                          message.error(`Ressource introuvable`);
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
       };

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
                     if (inputType === 'select' && dataIndex === 'country') {
                            inputNode = (
                                   <Select
                                          size='large'
                                          showSearch
                                          optionFilterProp="value"
                                          filterOption={(input, option) => {
                                                 return (option?.value?.toString() ?? '').toLowerCase().indexOf(input.toLowerCase()) >= 0
                                          }

                                          }
                                   >
                                          {countries.map(country => (
                                                 <Select.Option key={country.code} value={country.name}>
                                                        <Space>
                                                               {country && <Avatar alt={country?.name} src={`https://flagcdn.com/h240/${country.code.toLowerCase()}.png`} />}

                                                               <span>{country.name}</span>
                                                        </Space>
                                                 </Select.Option>

                                          ))}
                                   </Select>
                            );
                     } else if (inputType === 'select' && dataIndex === 'role') {
                            inputNode = (
                                   <Select
                                          showSearch

                                          disabled={record.id === currentUser.user?.id}
                                   >
                                          <Select.Option value="Utilisateur">Utilisateur</Select.Option>
                                          <Select.Option value="Moderateur">Modérateur</Select.Option>
                                          <Select.Option value="Administrateur">Administrateur</Select.Option>
                                          <Select.Option value="SuperAdministrateur">Super-administrateur</Select.Option>
                                   </Select>
                            );
                     } else if (inputType === 'number') {
                            inputNode = <InputNumber />;
                     } else if (inputType === 'boolean') {
                            inputNode = <Input type="checkbox" />;
                     }

                     return (
                            <td {...restProps}>
                                   {editing && isEditable ? (
                                          <Form.Item
                                                 valuePropName={inputType === 'boolean' ? 'checked' : 'value'}
                                                 name={dataIndex}
                                                 style={{ margin: 0 }}
                                                 rules={inputType !== 'boolean' ? [{ required: true, message: `Veuillez saisir une valeur dans le champs ${title}!` }] : undefined}
                                          >
                                                 {inputNode}
                                          </Form.Item>
                                   ) : (
                                          dataIndex ? (
                                                 <Tooltip
                                                        title={
                                                               dataIndex === 'isEmailVerified'
                                                                      ? record.isEmailVerified
                                                                             ? "L'adresse email est vérifiée"
                                                                             : "L'adresse email n'est pas vérifiée"
                                                                      : dataIndex === 'isBlocked'
                                                                             ? record.isBlocked
                                                                                    ? "L'utilisateur est banni"
                                                                                    : "L'utilisateur n'est pas banni"
                                                                             : children
                                                        }
                                                 >
                                                        {dataIndex === 'email' ? <Typography.Link>{children}</Typography.Link> : children}
                                                 </Tooltip>
                                          ) : children
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

       const getColumnSearchProps = (dataIndex: keyof User, title: string): ColumnType<User> => ({
              filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters }: FilterDropdownProps) => (
                     <div style={{ padding: 8 }}>
                            <Input
                                   placeholder={`Rechercher un(e) ${title}`}
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
                                   >
                                          Rechercher
                                   </Button>
                                   <Button
                                          icon={<Iconify className='anticon' icon="mdi:filter-off-outline" />}

                                          onClick={() => {
                                                 setTableParams({ ...tableParams, searchColumn: undefined, searchValue: undefined });
                                                 setSelectedKeys([]);
                                                 clearFilters?.(); // Use optional chaining here
                                                 fetchData({ ...tableParams, searchColumn: undefined, searchValue: undefined });
                                          }}
                                          size="small"
                                   >
                                          Réinitialiser
                                   </Button>
                            </Space>
                     </div>
              ),
              filterIcon: (filtered: any) => <SearchOutlined style={{ color: filtered ? '#1890ff' : undefined }} />,
              onFilter: (value, record) => {
                     return true;
              }, onFilterDropdownOpenChange: (visible: boolean) => {
                     if (visible) {
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

       const cancel = () => {
              setEditingKey('');
       };

       const save = async (user: User) => { // * Save the user. Data wont be fetched again, the table will be updated with the new data from the form if the request is successful
              setIsTableLoading(true);
              try {
                     const editUserResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: `/editUser/${user.id}`,
                            withCredentials: true,
                            responseType: 'json',
                            data: editUserForm.getFieldsValue(),
                            timeout: 10000,
                     });

                     if (editUserResponse.status === 200) {
                            message.success('Utilisateur modifié avec succès');
                            const newData = [...tableData];
                            const index = newData.findIndex(item => user.id === item.id);
                            const item = newData[index];
                            newData.splice(index, 1, { ...item, ...editUserForm.getFieldsValue() });
                            setTableData(newData);
                     }
              }
              catch (error) {
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
                                   case 429:
                                          message.error('Trop de tentatives');
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
                     setEditingKey('');
                     setIsTableLoading(false);
              }
       };

       const columns: ColumnType<User>[] = [
              {
                     title: 'Email',
                     dataIndex: 'email',
                     editable: true,
                     fixed: 'left' as const,
                     width: 250,
                     sorter: true,
                     ...getColumnSearchProps('email', 'Email'),

              },
              {
                     title: 'Prénom',
                     dataIndex: 'firstName',
                     editable: true,
                     sorter: true,
                     width: 180,
                     ...getColumnSearchProps('firstName', 'Prénom'),
              },
              {
                     title: 'Nom',
                     dataIndex: 'lastName',
                     editable: true,
                     sorter: true,
                     width: 180,
                     ...getColumnSearchProps('lastName', 'Nom'),
              },
              {
                     title: 'Rôle',
                     dataIndex: 'role',
                     editable: true,
                     sorter: true,
                     width: 180,
                     render: (role: User['role']) => role ? role.charAt(0).toUpperCase() + role.slice(1) : '',
                     ...getColumnSearchProps('role', 'Rôle'),
              },
              {
                     title: 'Pays',
                     dataIndex: 'country',
                     editable: true,
                     sorter: true,
                     width: 180,
                     ...getColumnSearchProps('country', 'Pays'),
                     render: (text: string, record: User) => {
                            const country = countries.find(country => country.name === text);
                            return (
                                   <Space>
                                          {country && <Avatar alt={country?.name} src={`https://flagcdn.com/h240/${country.code.toLowerCase()}.png`} />}
                                          <span>{text}</span>
                                   </Space>
                            );
                     },
              },
              {
                     title: 'Ville',
                     dataIndex: 'city',
                     editable: true,
                     sorter: true,
                     width: 150,
                     ...getColumnSearchProps('city', 'Ville'),

              },
              {
                     title: 'Code Postal',
                     dataIndex: 'postalCode',
                     editable: true,
                     sorter: true,
                     width: 150,
                     ...getColumnSearchProps('postalCode', 'Code postal'),
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
              },
       ].map(col => ({
              ...col,
              onCell: (record: User) => ({
                     record,
                     inputType: col.dataIndex === 'isEmailVerified' ? 'boolean' : col.dataIndex === 'role' || col.dataIndex === 'country' ? 'select' : 'text',
                     dataIndex: col.dataIndex,
                     title: col.title as string,
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
                                   <Popconfirm title="Sauvegarder ?" className='mr-2' onConfirm={() => save(record)}>
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
                                          <BanUserButton
                                                 user={record}
                                                 isDisabled={editingKey !== ''}
                                                 onBanChange={(userId, isBlocked) => {
                                                        const newData = [...tableData];
                                                        const index = newData.findIndex(item => item.id === userId);
                                                        if (index > -1) {
                                                               const updatedUser = { ...newData[index], isBlocked };
                                                               newData.splice(index, 1, updatedUser);
                                                               setTableData(newData);
                                                        }
                                                 }}
                                          ></BanUserButton>
                                   )}

                                   {currentUser.user?.role === 'SuperAdministrateur' && (
                                          <DeleteUserButton user={record} isDisabled={editingKey !== ''} onDelete={handleDeleteUser}></DeleteUserButton>
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
              const editableByAdmin = ['email', 'firstName', 'lastName', 'isEmailVerified', 'city', 'postalCode', 'country'];
              const editableBySuperAdmin = [...editableByAdmin, 'role'];

              if (role === 'Administrateur') {
                     return editableByAdmin.includes(dataIndex);
              } else if (role === 'SuperAdministrateur') {
                     return editableBySuperAdmin.includes(dataIndex);
              }
              return false;
       };

       const handleDeleteUser = (userId: string) => {
              const newData = tableData.filter(user => user.id !== userId);
              setTableData(newData);
              message.success('Utilisateur supprimé avec succès');
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
                                          value={selectedColumns}
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