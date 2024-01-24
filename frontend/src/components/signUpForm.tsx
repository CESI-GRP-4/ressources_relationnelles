// components/signUpForm.tsx
import React, { useState } from 'react';
import { Button, message, Form, Input } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';
import { CloseCircleOutlined, CheckCircleOutlined } from '@ant-design/icons';
import type SignUpResponse from '@/types/logInAndSignUpResponse';
import {
       emailRegex,
       firstNameRegex,
       lastNameRegex,
       minLengthPasswdRegex,
       oneLowerCasePasswdRegex,
       oneUpperCasePasswdRegex,
       oneDigitPasswdRegex,
       oneSpecialCharPasswdRegex,
       authorizedCharsPasswdRegex
} from '@/utils/regex';
import { RuleObject } from 'antd/lib/form'; // Import the RuleObject type from Ant Design

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

       const passwordValidationRule = {
              validator: async (rule: RuleObject, password: string) => {
                     if (!password) {
                            return Promise.reject(new Error(undefined)); // Do not display any error message if the field is empty (handled by the required rule)
                     }
                     if (!minLengthPasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe doit contenir au moins 8 caractères"));
                     }
                     if (!oneLowerCasePasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe doit contenir au moins une lettre minuscule"));
                     }
                     if (!oneUpperCasePasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe doit contenir au moins une lettre majuscule"));
                     }
                     if (!oneDigitPasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe doit contenir au moins un chiffre"));
                     }
                     if (!oneSpecialCharPasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe doit contenir au moins un caractère spécial (@$!%*?&)"));
                     }
                     if (!authorizedCharsPasswdRegex.test(password)) {
                            return Promise.reject(new Error("Le mot de passe contient des caractères non autorisés"));
                     }
                     return Promise.resolve();
              }
       };

       const [passwordValidationResults, setPasswordValidationResults] = useState({
              minLength: false,
              oneLowerCase: false,
              oneUpperCase: false,
              oneDigit: false,
              oneSpecialChar: false,
              noInvalidChar: true,
       });
       const validatePassword = (password: string) => {
              setPasswordValidationResults({
                     minLength: minLengthPasswdRegex.test(password),
                     oneLowerCase: oneLowerCasePasswdRegex.test(password),
                     oneUpperCase: oneUpperCasePasswdRegex.test(password),
                     oneDigit: oneDigitPasswdRegex.test(password),
                     oneSpecialChar: oneSpecialCharPasswdRegex.test(password),
                     noInvalidChar: authorizedCharsPasswdRegex.test(password),
              });
       };
       const passwordTooltipContent = (
              <div>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.minLength ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Au moins 8 caractères
                     </p>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.oneLowerCase ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Au moins une lettre minuscule
                     </p>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.oneUpperCase ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Au moins une lettre majuscule
                     </p>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.oneDigit ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Au moins un chiffre
                     </p>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.oneSpecialChar ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Au moins un caractère spécial (@$!%*?&)
                     </p>
                     <p className="text-white text-sm my-1">
                            {passwordValidationResults.noInvalidChar ?
                                   <CheckCircleOutlined className="mr-2" style={{ color: 'green' }} /> :
                                   <CloseCircleOutlined className="mr-2" style={{ color: 'red' }} />}
                            Aucun caractère non autorisé utilisé
                     </p>
              </div>
       );

       const allRulesRespected = () => {
              return Object.values(passwordValidationResults).every(Boolean);
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