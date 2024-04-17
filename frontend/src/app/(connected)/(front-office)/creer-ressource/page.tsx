// /creer-ressource/page.tsx
"use client"
import { useState, useEffect } from "react";
import { Form, Input, Select, Button, Upload, message, Typography, Checkbox } from "antd";
import { InboxOutlined, SaveOutlined } from "@ant-design/icons";
import axios, { AxiosResponse } from "axios";
import type Ressource from "@/types/ressource";
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';
import { Category } from "@/types/category";
const { Option } = Select;
const { Dragger } = Upload;
const { Title } = Typography;

export default function CreateRessourceForm() {
       const [form] = Form.useForm();
       const [isSubmitting, setSubmitting] = useState(false);
       const [categories, setCategories] = useState<Category[]>([]);
       const [categoriesLoaded, setCategoriesLoaded] = useState(false);
       const { user } = useUser();
       // Utilisez useEffect pour récupérer les catégories et les statuts lors du chargement du composant
       useEffect(() => {
              const fetchCategories = async () => {
                     try {
                            const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                            setCategories(categoriesResponse.data.categories);
                            setCategoriesLoaded(true);

                     } catch (error) {
                            console.error("Erreur lors de la récupération des catégories et des statuts:", error);
                     }
              };

              if (!categoriesLoaded) {
                     fetchCategories();
              }
       }, [categoriesLoaded]); // Charger les catégories et les statuts une seule fois au chargement du composant


       const onFinish = async (ressourceForm: Ressource) => {
              const ressourceFormWithUserId = { ...ressourceForm};

              console.log("Données du formulaire:", ressourceFormWithUserId); // Afficher les données dans la console

              setSubmitting(true);

              try {
                     // Envoi des données au backend avec axios
                     const response: AxiosResponse = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/ressource/create',
                            data: ressourceFormWithUserId,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });

                     // Traitement de la réponse (éventuellement)
                     console.log(response.data);

                     message.success("La ressource a été créée avec succès");
                     form.resetFields();
              } catch (error) {
                     console.error("Erreur lors de la création de la ressource:", error);
                     message.error("Une erreur est survenue lors de la création de la ressource");
              } finally {
                     setSubmitting(false);
              }
       };

       return (
              <div>
                     <Title style={{ textAlign: 'center', marginTop: '2%', marginBottom: '2%' }}>Créer une ressource</Title>
                     <div className="row justify-content-center">
                            <div className="col-md-6">
                                   <Form
                                          form={form}
                                          name="createRessourceForm"
                                          onFinish={onFinish}
                                          autoComplete="off"
                                          labelCol={{ span: 8 }}
                                          wrapperCol={{ span: 16 }}
                                   >
                                          <Form.Item label="Intitulé" name="label" rules={[{ required: true, message: "Saisissez un label" }]}>
                                                 <Input style={{ width: "50%" }} />
                                          </Form.Item>

                                          <Form.Item label="Description" name="description">
                                                 <Input.TextArea style={{ width: "50%" }} />
                                          </Form.Item>

                                          <Form.Item
                                                 label="Catégorie"
                                                 name="idCategory"
                                                 rules={[{ required: true, message: "Sélectionnez une catégorie" }]}
                                          >
                                                 <Select
                                                        style={{ width: "50%" }}
                                                        showSearch
                                                        optionFilterProp="label"
                                                        filterOption={(input, option) =>
                                                               (option?.label as string).toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                        }
                                                 >
                                                        {(categoriesLoaded ? categories : categories).map((category) => (
                                                               <Option key={category.id} value={category.id} label={category.title}>
                                                                      {category.title}
                                                               </Option>
                                                        ))}
                                                 </Select>
                                          </Form.Item>

                                          <Form.Item
                                                 label="Ressource publique"
                                                 name="isPublic"
                                                 valuePropName="checked" // Pour gérer la valeur cochée
                                                 initialValue={true} // Valeur par défaut cochée
                                                 rules={[{ required: true}]}
                                          >
                                                 <Checkbox />
                                          </Form.Item>


                                          {/* <Form.Item label="Fichiers" name="files" valuePropName="fileList" getValueFromEvent={(e) => e.fileList} >
                                                 <Dragger style={{ width: "50%" }}>
                                                        <p className="ant-upload-drag-icon">
                                                               <InboxOutlined />
                                                        </p>
                                                        <p className="ant-upload-text">Cliquez ou faites glisser des fichiers ici</p>
                                                 </Dragger>
                                          </Form.Item> */}

                                          <Form.Item wrapperCol={{ offset: 8, span: 16 }}>
                                                 <Button icon={<SaveOutlined />} type="primary" htmlType="submit" loading={isSubmitting}>
                                                        Enregistrer
                                                 </Button>
                                          </Form.Item>
                                   </Form>
                            </div>
                     </div>
              </div>
       );
}
