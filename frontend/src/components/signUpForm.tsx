// components/signUpForm.tsx
import React, { useState } from 'react';
import { Button, message, Form, Input } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';
import {CloseCircleOutlined} from '@ant-design/icons';

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
              pattern: new RegExp(
                     /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i
              ),
              message: "L'adresse e-mail n'est pas valide",
       };
       const firstNameValidationRule = {
              pattern: new RegExp(
                     "^[A-Za-zÀ-ÖØ-öø-ÿ-]{2,50}$"
              ),
              message: "Le prénom n'est pas valide",
       };
       const lastNameValidationRule = {
              pattern: new RegExp(
                     "^[A-Za-zÀ-ÖØ-öø-ÿ-]{2,50}$"
              ),
              message: "Le nom de famille n'est pas valide",
       };
       const passwordValidationRule = {
              pattern: new RegExp(
                     "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
              ),
              message: "Le mot de passe n'est pas valide",
       };
       const [passwordValidationResults, setPasswordValidationResults] = useState({
              minLength: false,
              oneLowerCase: false,
              oneUpperCase: false,
              oneDigit: false,
              oneSpecialChar: false,
              noInvalidChar: true, // Nouvelle règle pour les caractères non autorisés
       });
       const validatePassword = (password: string) => {
              const validCharsPattern = /^[A-Za-z\d@$!%*?&]+$/;
              setPasswordValidationResults({
                     minLength: password.length >= 8,
                     oneLowerCase: /[a-z]/.test(password),
                     oneUpperCase: /[A-Z]/.test(password),
                     oneDigit: /\d/.test(password),
                     oneSpecialChar: /[@$!%*?&]/.test(password),
                     noInvalidChar: validCharsPattern.test(password), // Vérification des caractères non autorisés
              });
       };
       const passwordTooltipContent = (
              <div>
                     {!passwordValidationResults.minLength &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Au moins 8 caractères
                            </p>}
                     {!passwordValidationResults.oneLowerCase &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Au moins une lettre minuscule
                            </p>}
                     {!passwordValidationResults.oneUpperCase &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Au moins une lettre majuscule
                            </p>}
                     {!passwordValidationResults.oneDigit &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Au moins un chiffre
                            </p>}
                     {!passwordValidationResults.oneSpecialChar &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Au moins un caractère spécial (@$!%*?&)
                            </p>}
                     {!passwordValidationResults.noInvalidChar &&
                            <p className="text-white text-sm my-1">
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />
                                   Caractères non autorisés utilisés
                            </p>}
              </div>
       );
       const allRulesRespected = () => {
              return Object.values(passwordValidationResults).every(Boolean);
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
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     const userData: User = response.data;
                     setUser(userData);
                     message.success('Inscription réussie. Bienvenue ! 🎉');
                     return userData; // * Not sure if this is necessary. Information is already stored in the userProvider
              } catch (error) {
                     const axiosError = error as AxiosError;
                     console.error(`Erreur lors de l'inscription. Axios error :`, axiosError);

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   // TODO : Handle error with switch case on error.response.status
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
                     <Form.Item<SignUpForm>
                            label="Password"
                            name="password"
                            hasFeedback
                            style={{ marginBottom: 50 }}
                            tooltip={allRulesRespected() ? undefined : passwordTooltipContent} // only show tooltip if allRulesRespected is false
                            rules={[{ required: true, message: 'Veuillez entrer votre mot de passe' }, passwordValidationRule]}>
                            <Input.Password maxLength={150} onChange={(e) => validatePassword(e.target.value)} />
                     </Form.Item>

                     <Form.Item>
                            <Button type="primary" className='w-full' shape="round" loading={isSignUpLoading} size='large' htmlType="submit">
                                   {`S'inscrire`}
                            </Button>
                     </Form.Item>
              </Form >
       )
}