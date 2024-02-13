// /reinitialisation-mot-de-passe/page.tsx
"use client"
import { useState } from "react";
import { Form, Button, message } from "antd";
import { SendOutlined } from "@ant-design/icons";
import PasswordInput from "@/components/PasswordInput";
import axios, { AxiosError, AxiosResponse } from "axios";
import { useSearchParams } from 'next/navigation'

export default function ReinitialisationMotDePasse() {
       const searchParams = useSearchParams()
       const token = searchParams.get('token');
       const [isResetPasswordLoading, setResetPasswordLoading] = useState(false);
       const [isRequestSent, setRequestSent] = useState(false);

       type ResetPasswordForm = {
              password: string;
              verifyPassword: string;
       };

       const onResetPassword = async (form: ResetPasswordForm) => {
              if (!token) {
                     message.error("Erreur. Veuillez réessayer plus tard");
                     return;
              }
              setResetPasswordLoading(true);

              if (form.password !== form.verifyPassword) {
                     message.error("Les mots de passe ne correspondent pas");
                     setResetPasswordLoading(false);
                     return;
              }

              try {
                     console.log("reset password TOKEN: ", token)
                     const response: AxiosResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: '/forgot-password/reset',
                            data: {
                                   password: form.password,
                                   verifyPassword: form.verifyPassword,
                                   token: token
                            },
                            responseType: 'json',
                            withCredentials: true,
                            timeout: 10000,
                     });
                     message.success("Mot de passe réinitialisé avec succès");
                     setRequestSent(true);
              }
              catch (error) {
                     console.error("error: ", error)
                     const axiosError = error as AxiosError;
                     console.error("Axios error: ", axiosError);

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé à effectuer cette action");
                                          break;
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à effectuer cette action");
                                          break;
                                   case 429:
                                          message.error("Trop de tentatives");
                                          break;
                                   case 422:
                                          message.error("Champs manquants ou invalides");
                                          break;
                                   default:
                                          message.error("Échec de la réinitialisation du mot de passe");
                                          break;
                            }
                     }
                     else {
                            message.error("Erreur. Veuillez réessayer plus tard");
                     }
              }
              finally {
                     setResetPasswordLoading(false);
              }
       }

       const onResetPasswordFailed = (errorInfo: any) => {
              console.log('Failed:', errorInfo);
       }
       return (
              <div className="flex items-center flex-col">
                     <h1 className="text-4xl font-semibold">Réinitialisation du mot de passe</h1>

                     <p className="mt-14"> </p>
                     <p className="text-justify">Veuillez entrer votre nouveau mot de passe</p>
                     <div className="mt-10 w-[250px]" >
                            <Form
                                   layout='vertical'
                                   name="resetPasswordForm"
                                   disabled={isResetPasswordLoading || isRequestSent}
                                   onFinish={onResetPassword}
                                   onFinishFailed={onResetPasswordFailed}
                                   autoComplete="off"
                                   className="mt-10"
                                   size="large">

                                   <PasswordInput
                                          style={{ marginBottom: 0 }}
                                          label="Mot de passe"
                                          hasFeedback
                                          name="password" />

                                   <PasswordInput
                                          label="Confirmer mot de passe"
                                          name="verifyPassword"
                                          hasFeedback />

                                   <Form.Item className="text-center">
                                          <Button icon={<SendOutlined />} type="primary" htmlType="submit">
                                                 Réinitialiser
                                          </Button>
                                   </Form.Item>
                            </Form>
                     </div>
              </div>
       );
}