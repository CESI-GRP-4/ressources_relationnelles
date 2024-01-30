// /mot-de-passe-oublie/page.tsx
"use client"
import { useState } from "react";
import { Form, Input, Button, message } from "antd";
import { SendOutlined } from "@ant-design/icons";
import axios, { AxiosError, AxiosResponse } from "axios";

export default function MotDePasseOublie() {
       type RecoverPasswordForm = {
              email: string;
       };

       const [isPasswordRecoveryLoading, setPasswordRecoveryLoading] = useState(false);
       const [isMailSent, setMailSent] = useState(false);

       const onRecoverPassword = async (form: RecoverPasswordForm) => {
              setPasswordRecoveryLoading(true);

              try{
                     const response: AxiosResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: '/forgot-password/send-mail',
                            data: {
                                   email: form.email,
                            },
                            responseType: 'json',
                            timeout: 10000,
                     });

                     message.success("Un mail de récupération a été envoyé à l'adresse indiquée");
                     setMailSent(true);
              }
              catch(error){
                     console.error("error: ", error)
                     const axiosError = error as AxiosError;
                     console.error("axios error: ", axiosError);
                     message.error("Une erreur est survenue lors de l'envoi du mail de récupération");
              }
              finally{
                     setPasswordRecoveryLoading(false);
              }
       }

       const onRecoverPasswordFailed = (errorInfo: any) => {
              console.log('Failed:', errorInfo);
       }
       return (
              <div className="flex items-center flex-col">
                     <h1 className="text-4xl font-semibold">Mot de passe oublié</h1>
                     <p className="mt-14">Entrez votre adresse email pour recevoir un lien de réinitialisation de votre mot de passe.</p>
                     <div className="mt-10">
                            <Form
                                   name="passwordRecoveryForm"
                                   disabled={isPasswordRecoveryLoading || isMailSent}
                                   onFinish={onRecoverPassword}
                                   onFinishFailed={onRecoverPasswordFailed}
                                   autoComplete="off"
                                   className="flex flex-row space-x-5 mt-10"
                                   size="large"
                            >
                                   <Form.Item<RecoverPasswordForm>
                                          label="Adresse e-mail"
                                          name="email"
                                          rules={[{ required: true, message: 'Saisissez une adresse e-mail' }]}
                                   >
                                          <Input />
                                   </Form.Item>

                                   <Form.Item>
                                          <Button icon={<SendOutlined />} type="primary" htmlType="submit">
                                                 Envoyer
                                          </Button>
                                   </Form.Item>
                            </Form>
                     </div>
              </div>
       );
}