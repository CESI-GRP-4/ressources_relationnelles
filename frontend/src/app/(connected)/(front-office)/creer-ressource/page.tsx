// /creer-ressource/page.tsx
"use client"
import { useState, useEffect } from "react";
import { Form, Input, Select, Button, message, Typography, Checkbox, Tooltip } from "antd";
import { SaveOutlined } from "@ant-design/icons";
import axios, { AxiosError, AxiosResponse } from "axios";
import type Ressource from "@/types/ressource";
import { useUser } from '@/providers/userProvider';
import { Category } from "@/types/category";
const { Option } = Select;
const { Title } = Typography;
import PageSummary from "@/components/pageSummary";

export default function CreateRessourceForm() {
       const [form] = Form.useForm();
       const [isLoading, setIsLoading] = useState(false);
       const [categories, setCategories] = useState<Category[]>([]);
       const { user } = useUser();

       useEffect(() => {
              fetchCategories();
       }, []);

       const fetchCategories = async () => {
              try {
                     setIsLoading(true);
                     const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error("Erreur lors de la récupération des catégories et des statuts:", error);
              } finally {
                     setIsLoading(false);
              }
       };

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
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à créer une ressource. Est-ce que votre mail est vérifié ?")
                                          break;
                                   case 422:
                                          message.error("Erreur de validation des données")
                                          break;
                                   default:
                                          message.error("Erreur lors de la création de la ressource")
                            }
                     } else {
                            message.error("Erreur lors de la création de la ressource")
                     }
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <div>
                     <PageSummary title={"Créer une ressource"} description={"Créez une ressource pour la partager avec la communauté. Vous pouvez choisir de la rendre publique ou privée. Avant publication, un modérateur vérifiera le contenu de votre ressource."}></PageSummary>
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
                                          <Select
                                                 showSearch
                                                 optionFilterProp="label"
                                                 filterOption={(input, option) =>
                                                        (option?.label as string).toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                 }
                                                 loading={isLoading}
                                          >
                                                 {(categories).map((category) => (
                                                        <Option key={category.id} value={category.id} label={category.title}>
                                                               {category.title}
                                                        </Option>
                                                 ))}
                                          </Select>
                                   </Form.Item>

                                   <Form.Item
                                          label="Ressource publique"
                                          name="isPublic"
                                          valuePropName="checked" // This sets the checkbox state
                                          initialValue={true} // Default checked
                                          rules={[{ required: true }]}
                                          style={{ display: 'flex', alignItems: 'center', marginBottom: '24px' }} // Ensures label and checkbox are on the same row
                                   >
                                          <Checkbox disabled={isLoading} />
                                   </Form.Item>

                                   {/* <Form.Item label="Fichiers" name="files" valuePropName="fileList" getValueFromEvent={(e) => e.fileList} >
                                                 <Dragger style={{ width: "50%" }}>
                                                        <p className="ant-upload-drag-icon">
                                                               <InboxOutlined />
                                                        </p>
                                                        <p className="ant-upload-text">Cliquez ou faites glisser des fichiers ici</p>
                                                 </Dragger>
                                          </Form.Item> */}

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
