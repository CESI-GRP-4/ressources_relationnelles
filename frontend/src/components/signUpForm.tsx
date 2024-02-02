// components/signUpForm.tsx
import React, { useState } from 'react';
import { Button, message, Form, Input } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';
import type SignUpResponse from '@/types/logInAndSignUpResponse';
import PasswordInputComponent from './PasswordInput';
import {
       emailRegex,
       firstNameRegex,
       lastNameRegex,
} from '@/utils/regex';

export default function SignUpForm() {
       const { setUser } = useUser();
       const [isSignUpLoading, setSignUpLoading] = useState(false);

       type SignUpForm = {
              email: string;
              firstName: string;
              lastName: string;
              password: string;
       };

       const emailValidationRule = {
              pattern: new RegExp(emailRegex),
              message: "L'adresse e-mail n'est pas valide",
       };
       const firstNameValidationRule = {
              pattern: new RegExp(firstNameRegex),
              message: "Le prénom n'est pas valide",
       };
       const lastNameValidationRule = {
              pattern: new RegExp(lastNameRegex),
              message: "Le nom de famille n'est pas valide",
       };
  
       async function handleSignUpForm(form: SignUpForm): Promise<User | null> {
              setSignUpLoading(true);
              try {
                     const response: AxiosResponse<SignUpResponse> = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api', // * Might be changed depending on the backend implementation
                            url: "/signup",
                            data: form,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     const userData: User = response.data.user;
                     setUser(userData);
                     message.success('Inscription réussie. Bienvenue ! 🎉');
                     return userData; // * Not sure if this is necessary. Information is already stored in the userProvider
              } catch (error) {
                     const axiosError = error as AxiosError;
                     console.error(`Erreur lors de l'inscription. Axios error :`, axiosError);

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
                     return null;
              }
              finally {
                     setTimeout(() => {
                            setSignUpLoading(false);
                     }, 1000);
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
                     disabled={isSignUpLoading}
                     // onFinishFailed={onFinishFailed}
                     autoComplete="off">

                     {/* email */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            label="Adresse e-mail"
                            name="email"
                            tooltip="Votre adresse e-mail sera utilisée pour vous connecter, recevoir des notifications et réinitialiser votre mot de passe en cas d'oubli. Elle ne sera (par défaut) pas visible par les autres utilisateurs."
                            rules={[
                                   { required: true, message: 'Veuillez entrer votre adresse e-mail' }, emailValidationRule]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* firstName */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            tooltip="Votre prénom sera visible par les autres utilisateurs."
                            label="Prénom"
                            name="firstName"
                            rules={[{ required: true, message: 'Veuillez entrer votre adresse e-mail' }, firstNameValidationRule]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* lastName */}
                     <Form.Item<SignUpForm>
                            style={{ marginBottom: 0 }}
                            label="Nom"
                            name="lastName"
                            tooltip="Votre nom ne sera pas visible par les autres utilisateurs."
                            rules={[{ required: true, message: 'Veuillez entrer votre adresse e-mail' }, lastNameValidationRule]}>
                            <Input allowClear />
                     </Form.Item>

                     {/* password */}
                     <PasswordInputComponent
                            label="Mot de passe"
                            name="password"
                            hasFeedback
                            style={{ marginBottom: 50 }} />
                     <Form.Item>
                            <Button type="primary" className='w-full' shape="round" loading={isSignUpLoading} size='large' htmlType="submit">
                                   {`S'inscrire`}
                            </Button>
                     </Form.Item>
              </Form >
       )
}