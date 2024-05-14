"use client"
import { useState } from "react";
import { Form, Input, Button, message, Checkbox, Tooltip } from "antd";
import { SaveOutlined } from "@ant-design/icons";
import axios, { AxiosError, AxiosResponse } from "axios";
import type Ressource from "@/types/ressource";
import { useUser } from '@/providers/userProvider';
import PageSummary from "@/components/pageSummary";
import SelectCategory from "@/components/selectCategory";

export default function CreateRessourceForm() {
       const [form] = Form.useForm();
       const [isLoading, setIsLoading] = useState(false);
       const { user } = useUser();

       const onFinish = async (ressourceForm: Ressource) => {
              const ressourceFormWithUserId = { ...ressourceForm };

              try {
                     setIsLoading(true);
                     const response: AxiosResponse = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/create',
                            data: ressourceFormWithUserId,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });

                     message.success("La ressource a été créée avec succès");
                     form.resetFields();
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à créer une ressource. Est-ce que votre mail est vérifié ?");
                                          break;
                                   case 422:
                                          message.error("Erreur de validation des données");
                                          break;
                                   default:
                                          message.error("Erreur lors de la création de la ressource");
                            }
                     } else {
                            message.error("Erreur lors de la création de la ressource");
                     }
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <div>
                     <PageSummary title={"Créer une ressource"} description={`Bienvenue sur la page "Créer une ressource" de notre plateforme. Ici, vous pouvez partager vos connaissances et expériences avec la communauté en soumettant vos propres contenus. Utilisez notre interface simple pour décrire et catégoriser votre contribution, la rendant ainsi accessible aux autres utilisateurs qui pourraient bénéficier de votre expertise. Contribuez dès aujourd'hui et aidez à enrichir notre collection de ressources relationnelles.`}></PageSummary>
                     <div className="flex flex-row justify-center w-full mt-10">
                            <Form
                                   form={form}
                                   name="createRessourceForm"
                                   onFinish={onFinish}
                                   autoComplete="off"
                                   layout="vertical"
                                   className="xl:w-1/2 lg:w-2/3 md:w-3/4 sm:w-4/5 w-full"
                                   size="large"
                            >
                                   <Form.Item label="Intitulé" name="label" rules={[{ required: true, message: "Saisissez un label" }]}>
                                          <Input disabled={isLoading} />
                                   </Form.Item>

                                   <Form.Item label="Description" name="description">
                                          <Input.TextArea disabled={isLoading} />
                                   </Form.Item>

                                   <Form.Item
                                          label="Catégorie"
                                          name="idCategory"
                                          rules={[{ required: true, message: "Sélectionnez une catégorie" }]}
                                   >
                                          <SelectCategory disabled={isLoading} />
                                   </Form.Item>

                                   <Form.Item
                                          label="Ressource publique"
                                          name="isPublic"
                                          valuePropName="checked"
                                          initialValue={true}
                                          rules={[{ required: true }]}
                                          style={{ display: 'flex', alignItems: 'center', marginBottom: '24px' }}
                                   >
                                          <Checkbox disabled={isLoading} />
                                   </Form.Item>

                                   <Form.Item>
                                          {user?.isEmailVerified ? (
                                                 <Button icon={<SaveOutlined />} type="primary" htmlType="submit" loading={isLoading}>
                                                        Enregistrer
                                                 </Button>
                                          ) : (
                                                 <Tooltip title="Votre email n'est pas vérifié">
                                                        <Button icon={<SaveOutlined />} type="primary" htmlType="submit" loading={isLoading} disabled>
                                                               Enregistrer
                                                        </Button>
                                                 </Tooltip>
                                          )}
                                   </Form.Item>
                            </Form>
                     </div>
              </div>
       );
}
