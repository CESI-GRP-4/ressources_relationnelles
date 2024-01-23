// components/logInForm.tsx

import { useState } from 'react';
import { Button, message, Form, Input, Checkbox } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';

export default function LogInForm() {
       const { setUser } = useUser();
       const [isSignInLoading, setSignInLoading] = useState(false);

       type LogInForm = {
              email: string;
              password: string;
              remember: boolean;
       };

       const emailValidationRule = {
              pattern: new RegExp(
                     /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i
              ),
              message: "L'adresse e-mail n'est pas valide",
       };

       async function handleLoginForm(form: LogInForm): Promise<User | null> {
              setSignInLoading(true);
              try {
                     const logInResponse: AxiosResponse<User> = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: "/login",
                            data: form,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     const userData: User = logInResponse.data;
                     setUser(userData);
                     message.success('Connexion réussie');
                     return userData;
              } catch (error) {
                     const axiosError = error as AxiosError;
                     console.error('Erreur lors de la connexion. Axios error :', axiosError);

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error('Email ou mot de passe incorrect');
                                          break;
                                   case 403:
                                          message.error('Compte non activé');
                                          break;
                                   case 429:
                                          message.error('Trop de tentatives de connexion');
                                          break;
                                   case 422:
                                          message.error('Champs manquants ou invalides');
                                          break;
                                   default:
                                          message.error('Échec de la connexion');
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
                     return null;
              }
              finally {
                     setTimeout(() => {
                            setSignInLoading(false);
                     }, 1000);
              }
       }

       return (
              <Form
                     name="logInForm"
                     layout='vertical'
                     style={{ marginBottom: 0, paddingTop: 20, paddingLeft: 20, paddingRight: 20 }} // * padding left & right are used to create a space between the log in form and the sign up form when changing carousel slide
                     initialValues={{ remember: true }}
                     onFinish={handleLoginForm}
                     disabled={isSignInLoading}
                     size='large'
                     // onFinishFailed={onFinishFailed}
                     autoComplete="off">

                     {/* email */}
                     <Form.Item<LogInForm>
                            style={{ marginBottom: 0 }}
                            label="Adresse e-mail"
                            name="email"
                            rules={[
                                   { required: true, message: 'Veuillez entrer votre adresse e-mail' },
                                   emailValidationRule
                            ]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* password */}
                     <Form.Item<LogInForm>
                            label="Password"
                            name="password"
                            rules={[{
                                   required: true,
                                   message: 'Veuillez entrer votre mot de passe'
                            }]}>
                            <Input.Password />
                     </Form.Item>

                     {/* remember */}
                     <Form.Item<LogInForm>
                            name="remember"
                            valuePropName="checked">
                            <Checkbox>Se souvenir de moi</Checkbox>
                     </Form.Item>

                     {/* submit */}
                     <Form.Item>
                            <Button type="primary" className='w-full' shape="round" size='large' htmlType="submit">
                                   Se connecter
                            </Button>
                     </Form.Item>
              </Form>
       )
}

