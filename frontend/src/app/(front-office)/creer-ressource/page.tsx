// /creer-ressource/page.tsx
"use client"
import { useState, useEffect } from "react";
import { Form, Input, Select, Button, Upload, message } from "antd";
import { InboxOutlined, SaveOutlined } from "@ant-design/icons";
import axios, { AxiosResponse } from "axios";
import type Resource from "@/types/resource";

const { Option } = Select;
const { Dragger } = Upload;



export default function CreateResourceForm() {
       const [form] = Form.useForm();
       const [isSubmitting, setSubmitting] = useState(false);
       const [categories, setCategories] = useState([]);
       const [categoriesLoaded, setCategoriesLoaded] = useState(false);

       // Utilisez useEffect pour récupérer les catégories et les statuts lors du chargement du composant
       useEffect(() => {
              const fetchCategories = async () => {
                     try {
                            const categoriesResponse = await axios.get("http://localhost/api/getCategories");
                            setCategories(categoriesResponse.data);
                            setCategoriesLoaded(true);

                     } catch (error) {
                            console.error("Erreur lors de la récupération des catégories et des statuts:", error);
                     }
              };

              // Charger les catégories et les statuts uniquement si elles n'ont pas déjà été chargées
              if (!categoriesLoaded) {
                     fetchCategories();
              }
       }, [categoriesLoaded]); // Charger les catégories et les statuts une seule fois au chargement du composant

       // Catégories par défaut si aucune réponse du backend
       const defaultCategories = [
              { id: 1, name: "Catégorie par défaut 1" },
              { id: 2, name: "Catégorie par défaut 2" },
              { id: 3, name: "Catégorie par défaut 3" },
       ];

       const onFinish = async (ressourceForm: Resource) => {
              console.log("Données du formulaire:", ressourceForm); // Afficher les données dans la console

              setSubmitting(true);

              try {
                     // Envoi des données au backend avec axios
                     const response: AxiosResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: '/createResources',
                            data: ressourceForm,
                            responseType: 'json',
                            timeout: 10000,
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
                     <h1 className="text-center mt-4 mb-4">Création de ressource</h1>
                     <div className="row justify-content-center">
                            <div className="col-md-6">
                                   <Form
                                          form={form}
                                          name="createResourceForm"
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

                                          <Form.Item label="Contenu" name="content" rules={[{ required: true, message: "Saisissez un contenu" }]}>
                                                 <Input.TextArea style={{ width: "50%" }} />
                                          </Form.Item>

                                          <Form.Item
                                                 label="Catégorie"
                                                 name="id_category"
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
                                                        {(categoriesLoaded ? categories : defaultCategories).map((category) => (
                                                               <Option key={category.id} value={category.id} label={category.name}>
                                                                      {category.name}
                                                               </Option>
                                                        ))}
                                                 </Select>
                                          </Form.Item>


                                          <Form.Item label="Fichiers" name="files" valuePropName="fileList" getValueFromEvent={(e) => e.fileList} >
                                                 <Dragger style={{ width: "50%" }}>
                                                        <p className="ant-upload-drag-icon">
                                                               <InboxOutlined />
                                                        </p>
                                                        <p className="ant-upload-text">Cliquez ou faites glisser des fichiers ici</p>
                                                 </Dragger>
                                          </Form.Item>

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
