"use client"
import React, { useEffect, useState } from 'react';
import { Form, Button, message, Card, Row, Col } from 'antd';
import { SaveOutlined } from '@ant-design/icons';

import axios from 'axios';
import type User from '@/types/user';
import PasswordInputComponent from '@/components/PasswordInput';

const ChangeUserPassword = () => {
       const [form] = Form.useForm();
       const [userData, setUserData] = useState<User | null>(null);

       const onFinish = async (values: any) => {
              try {
                     console.log('Données envoyées:', values);

                     const response = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/profil/updatePassword",
                            data: values, // Envoyer directement les valeurs, pas besoin de les encapsuler dans un objet 'values'
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });
                     // Mise à jour des données utilisateur si nécessaire
                     if (setUserData) {
                            setUserData(response.data);
                     }
                     message.success('Mot de passe modifié avec succès!');
                     form.resetFields();
              } catch (error) {
                     console.error('Error saving password:', error);
                     message.error('Une erreur est survenue lors de l\'enregistrement du mot de passe');
              }
       };


       return (
              <Card title="Modification de votre mot de passe" bordered={true} style={{ marginBottom: 16, maxWidth: '1000px', borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                     <Form
                            form={form}
                            layout="horizontal"
                            onFinish={onFinish}
                     >
                            <Row gutter={[16, 16]}>
                                   <Col span={24}>
                                          <PasswordInputComponent
                                                 useRegex={false}
                                                 label="Ancien mot de passe"
                                                 name="oldPassword"
                                                 required={true}
                                                 style={{ width: '100%' }}
                                          />
                                   </Col>
                            </Row>
                            <Row gutter={[16, 16]}>
                                   <Col span={24}>
                                          <PasswordInputComponent
                                                 useRegex={true}
                                                 label="Nouveau mot de passe"
                                                 name="password"
                                                 required={true}
                                                 style={{ width: '100%' }}
                                          />
                                   </Col>
                            </Row>
                            <Row gutter={[16, 16]}>
                                   <Col span={24}>
                                          <PasswordInputComponent
                                                 useRegex={true}
                                                 label="Confirmer le mot de passe"
                                                 name="confirmPassword"
                                                 required={true}
                                                 style={{ width: '100%' }}
                                          />
                                   </Col>
                            </Row>
                            <Form.Item style={{ textAlign: 'center' }}>
                                   <Button
                                          type="primary"
                                          htmlType="submit"
                                          icon={<SaveOutlined />}
                                          style={{
                                                 whiteSpace: 'normal',  // Allow wrapping
                                                 overflow: 'hidden',    // Prevent overflow
                                                 textOverflow: 'ellipsis', // Use ellipsis for text that can't be broken
                                                 display: 'inline-block',  // Ensure the button respects wrapping
                                                 width: '100%',        // Take full width to manage button size on small screens
                                          }}
                                   >
                                          Enregistrer le mot de passe
                                   </Button>
                            </Form.Item>




                     </Form>
              </Card>
       );


};

export default ChangeUserPassword;
