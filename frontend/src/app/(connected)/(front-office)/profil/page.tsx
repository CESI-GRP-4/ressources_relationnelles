"use client"
import React, { useEffect, useState, useCallback, useRef } from 'react';
import { Card, Avatar, Button, message, Form, Space, Input, Select, Empty, Tooltip, InputRef, Divider } from 'antd';
import { EditOutlined, SaveOutlined, LeftOutlined, PlusOutlined, UserOutlined } from '@ant-design/icons';
import type User from '@/types/user';
import type City from '@/types/city';
import type PostalCode from '@/types/postalCode';
import { useUser } from '@/providers/userProvider';
import axios, { AxiosResponse } from 'axios';
import SelectCountry from '@/components/selectCountry';
import PageSummary from '@/components/pageSummary';
import PasswordForm from '@/components/front-office/user-management/changeUserPassword'; // Importez le composant PasswordForm
import { emailRegex, firstNameRegex, lastNameRegex, cityRegex, postalCodeRegex } from '@/utils/regex';
const { Meta } = Card;

const UserProfilePage = () => {
       const [loading, setLoading] = useState(true);
       const [editing, setEditing] = useState(false);
       const { user, setUser } = useUser();
       const [form] = Form.useForm();
       const [selectedCountry, setSelectedCountry] = useState(null);

       const [cities, setCities] = useState<City[]>([]);
       const [postalCodes, setPostalCodes] = useState<PostalCode[]>([]);

       const [cityItems, setCityItems] = useState(cities.map(city => city.name));
       const [postalCodeItems, setPostalCodeItems] = useState(postalCodes.map(postalcode => postalcode.postal_code));
       const [cityName, setCityName] = useState('');
       const [postalCodeName, setPostalCodeName] = useState('');
       const inputRef = useRef<InputRef>(null);
       let index = 0;

       const onCityNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
              setCityName(event.target.value);
       };

       const onPostalCodeNameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
              setPostalCodeName(event.target.value);
       };

       const addCityItem = (e: React.MouseEvent<HTMLButtonElement | HTMLAnchorElement>) => {
              e.preventDefault();
              setCityItems([...cities.map(city => city.name), cityName || `New item ${index++}`]);
              setCityName('');
              setTimeout(() => {
                     inputRef.current?.focus();
              }, 0);
       };

       const addCodePostalItem = (e: React.MouseEvent<HTMLButtonElement | HTMLAnchorElement>) => {
              e.preventDefault();
              setPostalCodeItems([...postalCodes.map(postalcode => postalcode.postal_code), postalCodeName || `New item ${index++}`]);
              setPostalCodeName('');
              setTimeout(() => {
                     inputRef.current?.focus();
              }, 0);
       };

       useEffect(() => {
              fetchCities();
              fetchPostalCode();
       }, []);

       // Déclarez fetchUserData en dehors de l'effet useEffect
       const setFormData = useCallback(async () => {
              form.setFieldsValue({
                     id: user?.id,
                     lastName: user?.lastName,
                     firstName: user?.firstName,
                     email: user?.email,
                     city: user?.city,
                     postalCode: user?.postalCode,
                     country: user?.country,
                     role: user?.role,
              });
       }, [form, user]);

       useEffect(() => {
              setFormData();
       }, [user]);

       useEffect(() => {
              if (cities.length > 0) {
                     setCityItems(cities.map(city => city.name));
              }
              if (postalCodes.length > 0) {
                     setPostalCodeItems(postalCodes.map(postalcode => postalcode.postal_code));
              }
       }, [cities, postalCodes]);

       const fetchCities = async () => {
              setLoading(true)
              try {
                     // Appel API pour récupérer la liste des villes depuis la base de données
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/cities',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setCities(response.data);
              } catch (error) {
                     console.error('Error fetching cities:', error);
                     message.error('Une erreur est survenue lors du chargement des villes.');
              }
              finally {
                     setLoading(false)
              }
       };

       const fetchPostalCode = async () => {
              try {
                     // Appel API pour récupérer la liste des codes postaux depuis la base de données
                     const response = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/postalCodes',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setPostalCodes(response.data); // Mettre à jour l'état des codes postaux avec la réponse de l'API
              } catch (error) {
                     console.error('Error fetching postal code:', error);
                     message.error('Une erreur est survenue lors du chargement des codes postaux.');
              }
       };

       // Fonction pour gérer l'enregistrement des modifications de l'utilisateur
       const handleSave = async () => {
              let isFormValid = false;
              setLoading(true)
              try {
                     form.validateFields();
                     const values = await form.getFieldsValue();

                     // Appel à l'API pour enregistrer les modifications de l'utilisateur
                     const response: AxiosResponse<{ message: string, user: User }> = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/profil/update",
                            data: {
                                   ...values,
                            },
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });
                     console.log(response)
                     setUser(response.data.user)

                     // Si la mise à jour est réussie, actualisez les données de l'utilisateur
                     setFormData();
                     message.success('Informations mises à jour avec succès !');
                     isFormValid = true;
              } catch (error) {
                     console.error('Error saving user data:', error);
              }
              finally {
                     if (isFormValid) {
                            setEditing(false);
                     }
                     setLoading(false)
              }
       };

       const handleEdit = () => {
              // Activer le mode d'édition lors du clic sur le bouton "Modifier"
              setEditing(true);
       };

       const handleCancel = () => {
              // Désactiver le mode édition lors du clic sur le bouton "Retour"
              setEditing(false);
              // Réinitialiser le formulaire
              form.resetFields();
       };

       return (
              <div>
                     <PageSummary title={'Profil'} description={`Bienvenue sur la page de profil de notre plateforme. Cette section est votre espace personnel où vous pouvez gérer vos informations de compte, ajuster vos paramètres de confidentialité, et personnaliser votre expérience utilisateur. Ici, vous avez la possibilité de mettre à jour vos données personnelles, modifier votre mot de passe, et configurer vos préférences de notification. Utilisez cette page pour vous assurer que votre profil reflète précisément vos attentes et besoins, permettant ainsi une interaction plus ciblée et efficace avec la communauté et les ressources de la plateforme.`}></PageSummary>
                     {(loading || user) ?
                            (
                                   <Card
                                          loading={loading}
                                          style={{ width: '100%', margin: 'auto', maxWidth: '1000px', marginTop: '2%', marginBottom: '2%', borderColor: '#aeaeaecc' }}
                                          actions={[
                                                 <Button
                                                        disabled={loading}
                                                        size='large'
                                                        icon={editing ? <LeftOutlined /> : <EditOutlined />}
                                                        onClick={editing ? handleCancel : handleEdit}
                                                        key="edit"
                                                 >
                                                        {editing ? 'Retour' : 'Modifier'}
                                                 </Button>
                                          ]}
                                   >
                                          <Meta
                                                 avatar={<Avatar src={user?.imgURL} style={{ height: 50, width: 50 }} icon={<UserOutlined />} />}
                                                 style={{ marginBottom: '2%' }}
                                                 title={`${user?.firstName} ${user?.lastName}`}
                                                 description="Les informations vous concernant"
                                          />

                                          <Form
                                                 form={form}
                                                 initialValues={{
                                                        lastName: user?.lastName,
                                                        firstName: user?.firstName,
                                                        email: user?.email,
                                                        city: user?.city,
                                                        postalCode: user?.postalCode,
                                                        country: user?.country,
                                                        role: user?.role,
                                                 }}
                                                 onFinish={handleSave}
                                                 disabled={loading}
                                                 name='profilForm'
                                          >
                                                 <div className='flex flex-col mt-10 md:flex-row gap-5 md:justify-center justify-normal items-center md:items-start'>
                                                        <Card title="Détails" bordered={true} style={{ marginBottom: 16, width: "100%", borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                               <Form.Item
                                                                      label="Nom :"
                                                                      name="lastName"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[
                                                                             {
                                                                                    required: editing,
                                                                                    message: 'Veuillez renseigner un nom',
                                                                                    pattern: lastNameRegex
                                                                             },
                                                                      ]}
                                                               >
                                                                      {editing ? <Input /> : <span>{user?.lastName}</span>}
                                                               </Form.Item>

                                                               <Form.Item
                                                                      label="Prénom"
                                                                      name="firstName"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[
                                                                             {
                                                                                    required: editing,
                                                                                    message: 'Veuillez renseigner un prénom',
                                                                                    pattern: firstNameRegex
                                                                             },
                                                                      ]}
                                                               >
                                                                      {editing ? <Input /> : <span>{user?.firstName}</span>}
                                                               </Form.Item>

                                                               <Form.Item
                                                                      label="Email"
                                                                      name="email"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[{
                                                                             required: editing,
                                                                             min: 5,
                                                                             max: 100,
                                                                             type: 'email',
                                                                             pattern: emailRegex,
                                                                             message: 'Entrez une adresse mail valide',
                                                                      },
                                                                      ]}
                                                               >
                                                                      {editing ? <Input /> : <span>{user?.email}</span>}
                                                               </Form.Item>
                                                        </Card>
                                                        <Card title="Localisation" bordered={true} style={{ marginBottom: 16, width: "100%", borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                               <Form.Item
                                                                      label="Ville"
                                                                      name="city"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[
                                                                             {
                                                                                    min: 2,
                                                                                    max: 50,
                                                                             },
                                                                             {
                                                                                    pattern: cityRegex,
                                                                                    message: 'Le nom de la ville ne peut contenir que des lettres, des tirets et des apostrophes',
                                                                             }
                                                                      ]}
                                                               >
                                                                      {editing ? (
                                                                             <Select
                                                                                    loading={loading}
                                                                                    placeholder="custom dropdown render"
                                                                                    dropdownRender={(menu) => (
                                                                                           <>
                                                                                                  {menu}
                                                                                                  <Divider style={{ margin: '8px 0' }} />
                                                                                                  <Space style={{ padding: '0 8px 4px' }}>
                                                                                                         <Input
                                                                                                                placeholder="Entrez une ville"
                                                                                                                ref={inputRef}
                                                                                                                value={cityName}
                                                                                                                onChange={onCityNameChange}
                                                                                                                onKeyDown={(e) => e.stopPropagation()}
                                                                                                                style={{ minWidth: 100 }}
                                                                                                         />
                                                                                                         <Button type="text" icon={<PlusOutlined />} onClick={addCityItem}>
                                                                                                                Ajouter
                                                                                                         </Button>
                                                                                                  </Space>
                                                                                           </>
                                                                                    )}
                                                                                    options={cityItems.map((item) => ({ label: item, value: item }))}
                                                                             />


                                                                      ) : (
                                                                             <span>{user?.city}</span>
                                                                      )}
                                                               </Form.Item>
                                                               <Form.Item
                                                                      label="Code postal"
                                                                      name="postalCode"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[
                                                                             {
                                                                                    pattern: postalCodeRegex,
                                                                                    message: 'Le code postal ne peut contenir que des chiffres'
                                                                             },
                                                                      ]}
                                                               >
                                                                      {editing ? (
                                                                             <Select
                                                                                    loading={loading}
                                                                                    placeholder="custom dropdown render"
                                                                                    dropdownRender={(menu) => (
                                                                                           <>
                                                                                                  {menu}
                                                                                                  <Divider style={{ margin: '8px 0' }} />
                                                                                                  <Space style={{ padding: '0 8px 4px' }}>
                                                                                                         <Input
                                                                                                                placeholder="Entrez un code postal"
                                                                                                                ref={inputRef}
                                                                                                                value={postalCodeName}
                                                                                                                onChange={onPostalCodeNameChange}
                                                                                                                onKeyDown={(e) => e.stopPropagation()}
                                                                                                                style={{ minWidth: 100 }}
                                                                                                         />
                                                                                                         <Button type="text" icon={<PlusOutlined />} onClick={addCodePostalItem}>
                                                                                                                Ajouter
                                                                                                         </Button>
                                                                                                  </Space>
                                                                                           </>
                                                                                    )}
                                                                                    options={postalCodeItems.map((item) => ({ label: item, value: item }))}
                                                                             />
                                                                      ) : (
                                                                             <span>{user?.postalCode}</span>
                                                                      )}
                                                               </Form.Item>

                                                               <Form.Item
                                                                      label="Pays"
                                                                      name="country"
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                               >
                                                                      {editing ? (
                                                                             <SelectCountry
                                                                                    value={selectedCountry}
                                                                                    onChange={(value: any) => setSelectedCountry(value)}
                                                                             />
                                                                      ) : (
                                                                             <Space>
                                                                                    <Avatar src={`https://flagcdn.com/h240/${user?.countryCode?.toLowerCase()}.png`} />
                                                                                    <span>{user?.country}</span>
                                                                             </Space>
                                                                      )}
                                                               </Form.Item>
                                                        </Card>
                                                 </div>
                                                 <div className='flex flex-col md:flex-row gap-5 md:justify-center justify-normal items-center md:items-start'>

                                                        <Card title="Vos accès" bordered={true} style={{ marginBottom: 16, width: "100%", borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                               <Form.Item
                                                                      label="Role"
                                                                      name="role"
                                                                      style={{ width: '50%' }}
                                                                      labelCol={{ style: { textAlign: 'left', fontWeight: "bold" } }}
                                                                      rules={[
                                                                      ]}
                                                               >
                                                                      <span>{user?.role}</span>
                                                               </Form.Item>

                                                               {user?.isEmailVerified ? (
                                                                      <span>
                                                                             {`Email vérifié, vous avez accès à toutes les fonctionnalités`}
                                                                      </span>)
                                                                      : (
                                                                             <span>
                                                                                    {`Email non vérifié, vous n'avez pas accès à toutes les fonctionnalités`}
                                                                             </span>
                                                                      )
                                                               }
                                                        </Card>
                                                        <Card
                                                               title="Vos données"
                                                               bordered={true}
                                                               style={{ marginBottom: 16, width: "100%", borderColor: '#aeaeaecc' }}
                                                               headStyle={{ borderBottomColor: '#aeaeaecc' }}
                                                        >
                                                               <Tooltip title="Fonctionnalité bientôt disponible">
                                                                      <Button block type="primary" size='large' disabled={true} style={{ whiteSpace: "normal", height: 'auto', marginBottom: '10px' }}>Récupérer mes informations</Button>
                                                               </Tooltip>
                                                               <Tooltip title="Fonctionnalité bientôt disponible">
                                                                      <Button block type="primary" size='large' disabled={true} style={{ whiteSpace: "normal", height: 'auto', marginBottom: '10px' }}>Supprimer mes informations</Button>
                                                               </Tooltip>

                                                               <Tooltip title="Fonctionnalité bientôt disponible">
                                                                      <Button block type="primary" size='large' disabled={true} style={{ whiteSpace: "normal", height: 'auto', marginBottom: '10px' }}>Supprimer mon profil</Button>
                                                               </Tooltip>
                                                        </Card>
                                                 </div>
                                                 {editing && (
                                                        <div style={{ display: 'flex', justifyContent: 'center', paddingTop: '1%' }} className='mb-5'>
                                                               <Button loading={loading} size='large' type="primary" htmlType="submit" icon={<SaveOutlined />}>
                                                                      Enregistrer
                                                               </Button>
                                                        </div>
                                                 )}
                                          </Form>
                                          {editing && <PasswordForm />}

                                   </Card>
                            )
                            : (
                                   <Empty description="Aucune donnée concernant l'utilisateur"></Empty>
                            )
                     }
              </div>
       );
};

export default UserProfilePage;