// components/logInForm.tsx

import { useState } from 'react';
import { Button, message, Form, Input, Checkbox } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import { useUser } from '@/providers/userProvider';
import type User from '@/types/user';
import type LogInResponse from '@/types/logInAndSignUpResponse';
import { useRouter } from 'next/navigation';
import { useConsent } from '@/contexts/CookiesConsentContext';

export default function LogInForm() {
       const { consentStatus, setConsent } = useConsent();

       const router = useRouter();
       const { setUser } = useUser();
       const [isLoginLoading, setLoginLoading] = useState(false);

       type LogInForm = {
              email: string;
              password: string;
              remember: boolean;
       };

       async function handleLoginForm(form: LogInForm) {
              setLoginLoading(true);
              try {
                     const logInResponse: AxiosResponse<LogInResponse> = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/login",
                            data: form,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     const userData: User = logInResponse.data.user;
                     if (userData) {
                            setUser(userData, form.remember);
                            message.success('Connexion réussie');
                            router.push('/'); // * Redirect to the home page
                     }
              } catch (error) {
                     const axiosError = error as AxiosError;
                     console.error('Erreur lors de la connexion. Axios error :', axiosError);

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error('Email ou mot de passe incorrect');
                                          break;
                                   case 403:
                                          message.error('Compte banni');
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
              }
              finally {
                     setTimeout(() => {
                            setLoginLoading(false);
                     }, 1000);
              }
       }

       const handleRememberMeChange = (e: any) => {
       }

       return (
              <Form
                     name="logInForm"
                     layout='vertical'
                     style={{ marginBottom: 0, paddingTop: 20, paddingLeft: 20, paddingRight: 20 }} // * padding left & right are used to create a space between the log in form and the sign up form when changing carousel slide
                     initialValues={{ remember: (consentStatus === 'accepted') }}
                     onFinish={handleLoginForm}
                     size='large'
                     // onFinishFailed={onFinishFailed}
                     autoComplete="off">

                     {/* email */}
                     <Form.Item<LogInForm>
                            style={{ marginBottom: 0 }}
                            label="Adresse e-mail"
                            name="email"
                            rules={[{ required: true, message: 'Veuillez entrer votre adresse e-mail' }]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* password */}
                     {/* no regex for password input in case the password rule has changed in the time */}
                     <Form.Item<LogInForm>
                            label="Mot de passe"
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
                            valuePropName="checked"
                     >
                            <Checkbox disabled={consentStatus !== 'accepted'}>Se souvenir de moi</Checkbox>
                     </Form.Item>

                     {/* submit */}
                     <Form.Item
                     >
                            <Button type="primary" className='w-full' shape="round" size='large' htmlType="submit" loading={isLoginLoading}>
                                   Se connecter
                            </Button>
                     </Form.Item>
              </Form>
       )
}