// components/signUpForm.tsx
import React, { useState } from 'react';
import { Button, message, Form, Input, Checkbox } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';

export default function SignUpForm() {
       const { setUser } = useUser();
       const [isSignUpLoading, setSignUpLoading] = useState(false);

       const emailValidationRule = {
              pattern: new RegExp(
                     /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i
              ),
              message: "L'adresse e-mail n'est pas valide",
       };

       type SignUpForm = {
              email: string;
              firstName: string;
              lastName: string;
              password: string;
              remember: string;
       };

       async function handleSignUpForm(form: SignUpForm): Promise<User | null> {
              setSignUpLoading(true);
              try {
                     const response: AxiosResponse<User> = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: "/signup",
                            data: form,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 1000,
                     });

                     const userData: User = response.data;
                     setUser(userData);
                     message.success('Inscription réussie');
                     return userData;
              } catch (error) {
                     const axiosError = error as AxiosError;
                     console.error(`Erreur lors de l'inscription. Axios error :`, axiosError);

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   default:
                                          message.error(`Échec de l'inscription`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
                     return null;
              }
              finally {
                     setSignUpLoading(false);
              }
       }

       return (
              <Form
                     name="signUpForm"
                     layout='vertical'
                     style={{ marginBottom: 0, paddingTop: 20, paddingLeft: 20, paddingRight: 20 }}
                     initialValues={{ remember: true }}
                     onFinish={handleSignUpForm}
                     size='large'
                     disabled={true} // * Disabled until the sign up feature is implemented
                     // disabled={isSignUpLoading} // * Commented out because the sign up feature is not implemented yet
                     // onFinishFailed={onFinishFailed}
                     autoComplete="off">

                     {/* email */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            label="Adresse e-mail"
                            name="email"
                            tooltip="Votre adresse e-mail sera utilisée pour vous connecter, recevoir des notifications et réinitialiser votre mot de passe en cas d'oubli. Elle ne sera (par défaut) pas visible par les autres utilisateurs."
                            rules={[
                                   { required: true, message: 'Veuillez entrer votre adresse e-mail' },
                                   emailValidationRule
                            ]}                            >
                            <Input allowClear />
                     </Form.Item>

                     {/* firstName */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            tooltip="Votre prénom sera visible par les autres utilisateurs."
                            label="Prénom"
                            name="firstName"
                            rules={[{ required: true, message: 'Veuillez entrer votre adresse e-mail' }]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* lastName */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            label="Nom"
                            name="lastName"
                            tooltip="Votre nom ne sera pas visible par les autres utilisateurs."
                            rules={[{ required: true, message: 'Veuillez entrer votre adresse e-mail' }]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* password */}
                     <Form.Item<SignUpForm>
                            label="Password"
                            name="password"
                            rules={[{ required: true, message: 'Veuillez entrer votre mot de passe' }]}>
                            <Input.Password maxLength={150} />
                     </Form.Item>

                     {/* remember */}
                     <Form.Item<SignUpForm>
                            name="remember"
                            valuePropName="checked">
                            <Checkbox >Remember me</Checkbox>
                     </Form.Item>

                     <Form.Item>
                            <Button type="primary" className='w-full' shape="round" loading={isSignUpLoading} size='large' htmlType="submit">
                                   {`S'inscrire`}
                            </Button>
                     </Form.Item>
              </Form>
       )
}