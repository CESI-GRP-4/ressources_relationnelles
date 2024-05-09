"use client"
import React, { useEffect, useState, useCallback } from 'react';
import { Card, Avatar, Typography, Spin, Button, message, Form, Space, Input, Select } from 'antd';
import { EditOutlined, SaveOutlined, LeftOutlined } from '@ant-design/icons';
import { UserOutlined } from '@ant-design/icons';
import type User from '@/types/user';
import type City from '@/types/city';
import type PostalCode from '@/types/postalCode';
import { useUser } from '@/providers/userProvider';
import { Row, Col } from 'antd';
import axios from 'axios';
import SelectCountry from '@/components/selectCountry';
import PageSummary from '@/components/pageSummary';
import PasswordForm from '@/components/front-office/user-management/changeUserPassword'; // Importez le composant PasswordForm
import { emailRegex, firstNameRegex, lastNameRegex, cityRegex, postalCodeRegex } from '@/utils/regex';
import { Span } from 'next/dist/trace';

const { Meta } = Card;
const { Title } = Typography;
const { Option } = Select;


const UserProfilePage = () => {
       const [userData, setUserData] = useState<User | null>(null);
       const [loading, setLoading] = useState(true);
       const [editing, setEditing] = useState(false);
       const { user } = useUser();
       const [form] = Form.useForm();
       const [selectedCountry, setSelectedCountry] = useState(null);
       const [cities, setCities] = useState<City[]>([]);
       const [postalCodes, setPostalCodes] = useState<PostalCode[]>([]);


       // Déclarez fetchUserData en dehors de l'effet useEffect
       const fetchUserData = useCallback(async () => {
              try {
                     setUserData(user);
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
              } catch (error) {
                     console.error('Error fetching user data:', error);
                     throw new Error('Utilisateur non connecté ou non trouvé');
              } finally {
                     setLoading(false);
              }
       }, [form, user]);


       const fetchCities = async () => {
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
                     setCities(response.data); // Stockez les villes dans l'état cities
              } catch (error) {
                     console.error('Error fetching cities:', error);
                     message.error('Une erreur est survenue lors du chargement des villes.');
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

       useEffect(() => {
              fetchUserData();
              fetchCities();
              fetchPostalCode();
       }, [form, user, fetchUserData]);

       // Fonction pour gérer l'enregistrement des modifications de l'utilisateur
       const handleSave = async () => {
              let isFormValid = false;

              try {
                     await form.validateFields();

                     const values = form.getFieldsValue();

                     console.log('Données envoyées :', {
                            ...values,
                     });

                     // Appel à l'API pour enregistrer les modifications de l'utilisateur
                     const response = await axios({
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

                     // Si la mise à jour est réussie, actualisez les données de l'utilisateur
                     fetchUserData();

                     message.success('Data saved successfully!');

                     isFormValid = true;
              } catch (error) {
                     console.error('Error saving user data:', error);
              } finally {
                     if (isFormValid) {
                            setEditing(false);
                     }
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

       if (loading || user === null) {
              console.log('Utilisateur non trouvé ');
              return <Spin />;
       }

       return (
              <div>
                     <PageSummary title={'Profil'} description={"Vous pouvez retrouver ici vos informations, les modifier, supprimer votre profil ou ses données ainsi qu'exporter vos données"}></PageSummary>
                     <Card
                            style={{ width: '100%', maxWidth: '1000px', margin: 'auto', marginTop: '2%', marginBottom: '2%', borderColor: '#aeaeaecc' }}
                            actions={[
                                   <Button
                                          icon={editing ? <LeftOutlined /> : <EditOutlined />}
                                          onClick={editing ? handleCancel : handleEdit}
                                          key="edit"
                                   >
                                          {editing ? 'Retour' : 'Modifier'}
                                   </Button>
                            ]}
                     >
                            <Meta
                                   avatar={<Avatar src={userData?.imgURL} style={{ height: 50, width: 50 }} icon={<UserOutlined />} />}
                                   style={{ marginBottom: '2%' }}
                                   title={`${userData?.firstName} ${userData?.lastName}`}
                                   description="Les informations vous concernant"
                            />

                            <Form
                                   form={form}
                                   initialValues={{
                                          lastName: userData?.lastName,
                                          firstName: userData?.firstName,
                                          email: userData?.email,
                                          city: userData?.city,
                                          postalCode: userData?.postalCode,
                                          country: userData?.country,
                                          role: userData?.role,
                                   }}
                                   labelCol={{ span: 8 }}
                                   wrapperCol={{ span: 16 }}
                            >
                                   <Row gutter={16}>
                                          <Col span={12}>
                                                 <Card title="Détails" bordered={true} style={{ marginBottom: 16, borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                        <Form.Item
                                                               label="Nom"
                                                               name="lastName"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner un nom',
                                                                             pattern: lastNameRegex
                                                                      },
                                                               ]}
                                                        >
                                                               {editing ? <Input /> : <span>{userData?.lastName}</span>}
                                                        </Form.Item>

                                                        <Form.Item
                                                               label="Prénom"
                                                               name="firstName"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner un prénom',
                                                                             pattern: firstNameRegex
                                                                      },
                                                               ]}
                                                        >
                                                               {editing ? <Input /> : <span>{userData?.firstName}</span>}
                                                        </Form.Item>

                                                        <Form.Item
                                                               label="Email"
                                                               name="email"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner une adresse mail',
                                                                      },
                                                                      {
                                                                             min: 5,
                                                                             max: 100,
                                                                             type: 'email',
                                                                             pattern: emailRegex,
                                                                             message: 'Entrez une adresse mail valide',
                                                                      },
                                                               ]}
                                                        >
                                                               {editing ? <Input /> : <span>{userData?.email}</span>}
                                                        </Form.Item>
                                                 </Card>
                                          </Col>
                                          <Col span={12}>
                                                 <Card title="Localisation" bordered={true} style={{ marginBottom: 16, borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                        <Form.Item
                                                               label="Ville"
                                                               name="city"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             min: 2,
                                                                             max: 50,
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner une ville',
                                                                      },
                                                                      {
                                                                             pattern: cityRegex,
                                                                             message: 'Le nom de la ville ne peut contenir que des lettres, des tirets et des apostrophes',
                                                                      }
                                                               ]}
                                                        >
                                                               {editing ? (
                                                                      <Select>
                                                                             {cities.map(city => (
                                                                                    <Option key={city.id} value={city.name}>{city.name}</Option>
                                                                             ))}
                                                                      </Select>

                                                               ) : (
                                                                      <span>{userData?.city}</span>
                                                               )}
                                                        </Form.Item>

                                                        <Form.Item
                                                               label="Code postal"
                                                               name="postalCode"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner un code postal',
                                                                      },
                                                               ]}
                                                        >
                                                               {editing ? (
                                                                      <Select>
                                                                             {postalCodes.map(postalCode => (
                                                                                    <Option key={postalCode.id} value={postalCode.postal_code}>{postalCode.postal_code}</Option>
                                                                             ))}
                                                                      </Select>

                                                               ) : (
                                                                      <span>{userData?.postalCode}</span>
                                                               )}
                                                        </Form.Item>

                                                        <Form.Item
                                                               label="Pays"
                                                               name="country"
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                                      {
                                                                             required: editing,
                                                                             message: 'Veuillez renseigner un pays',
                                                                      },
                                                               ]}
                                                        >
                                                               {editing ? (
                                                                      <SelectCountry
                                                                             value={selectedCountry}
                                                                             onChange={(value: any) => setSelectedCountry(value)}
                                                                      />
                                                               ) : (
                                                                      <Space>
                                                                             <Avatar src={`https://flagcdn.com/h240/${userData?.countryCode?.toLowerCase()}.png`} />
                                                                             <span>{userData?.country}</span>
                                                                      </Space>
                                                               )}
                                                        </Form.Item>
                                                 </Card>
                                          </Col>
                                   </Row>
                                   <Row gutter={16}>
                                          <Col span={12}>
                                                 <Card title="Vos accès" bordered={true} style={{ marginBottom: 16, borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                                                        <Form.Item
                                                               label="Role"
                                                               name="role"
                                                               style={{ width: '50%' }}
                                                               labelCol={{ style: { textAlign: 'left' } }}
                                                               rules={[
                                                               ]}
                                                        >
                                                               <span>{userData?.role}</span>
                                                        </Form.Item>

                                                        {userData?.isEmailVerified ? (
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
                                          </Col>
                                          <Col span={12}>
                                                 <Card
                                                        title="Vos données"
                                                        bordered={true}
                                                        style={{ marginBottom: 16, borderColor: '#aeaeaecc' }}
                                                        headStyle={{ borderBottomColor: '#aeaeaecc' }}
                                                 >
                                                        <Button type="primary" disabled={true} style={{ marginBottom: '8px', display: 'block' }}>Récupérer mes informations</Button>
                                                        <Button type="primary" disabled={true} style={{ marginBottom: '8px', display: 'block' }}>Supprimer mes informations</Button>
                                                        <Button type="primary" disabled={true} style={{ display: 'block' }}>Supprimer mon profil</Button>
                                                 </Card>
                                          </Col>
                                   </Row>

                            </Form>
                            {editing && <PasswordForm />}
                            {editing && (
                                   <div style={{ display: 'flex', justifyContent: 'center', paddingTop: '1%' }}>
                                          <Button type="primary" onClick={handleSave} icon={<SaveOutlined />}>
                                                 Enregistrer
                                          </Button>
                                   </div>
                            )}
                     </Card>
              </div>
       );
};

export default UserProfilePage;