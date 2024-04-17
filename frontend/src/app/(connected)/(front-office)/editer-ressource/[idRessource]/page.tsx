"use client"
import React, { useEffect, useState } from 'react';
import { message, Form, Input, Button, Switch, Select } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import Ressource from "@/types/ressource";
import PageSummary from '@/components/pageSummary';
import { Category } from '@/types/category';
const { Option } = Select;
import { useRouter } from 'next/navigation';
import { useUser } from '@/providers/userProvider';

export default function EditRessource({ params }: { params: { idRessource: number } }) {
       const [form] = Form.useForm();
       const [loading, setLoading] = useState<boolean>(true);
       const [categories, setCategories] = useState<Category[]>([]);
       const router = useRouter();
       const { user: currentUser } = useUser();

       useEffect(() => {
              if(currentUser?.id != undefined && currentUser?.id != null){

                     fetchRessource();
                     fetchCategories();
              }
       }, [currentUser]);

       if(!currentUser) return null;

       const fetchRessource = async () => {
              try {
                     const response: AxiosResponse<{ ressource: Ressource }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/${params.idRessource}`, {
                            method: "GET",
                            withCredentials: true
                     });

                     if (response.status === 200) {
                            if (response.data.ressource.user && response.data.ressource.user.id !== (currentUser?.id)) {
                                   message.error("Vous n'êtes pas autorisé à accéder à cette page");
                                   router.push('/mes-ressources');
                            } else {
                                   form.setFieldsValue(response.data.ressource);
                            }
                     } else {
                            throw new Error('Error fetching ressource');
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable");
                                   
                                   default:
                                          message.error("Erreur lors de la récupération de la ressource");
                            }
                     } else {
                            message.error("Erreur lors de la mise à jour de la ressource");
                     }
              } finally {
                     setLoading(false);
              }
       };

       const fetchCategories = async () => {
              setLoading(true)
              try {
                     const responseCategories = await axios({
                            method: 'GET',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/categories',
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     setCategories(responseCategories.data.categories);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à accéder à cette page")
                                          break
                                   default:
                                          message.error("Erreur lors de la récupération des catégories")
                            }
                     } else {
                            message.error("Erreur lors de la récupération des catégories")
                     }
              }
              finally {
                     setLoading(false)
              }
       }

       const onFinish = async (values: Ressource) => {
              try {
                     setLoading(true);
                     const response = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/ressource/edit/${params.idRessource}`, {
                            method: "POST",
                            withCredentials: true,
                            data: {
                                   idCategory: values.category.id,
                                   label: values.label,
                                   description: values.description,
                                   isPublic: values.isPublic
                            }
                     });

                     if (response.status === 200) {
                            let counter = 5;
                            const key = 'updateMessage';

                            // Show the initial message
                            message.loading({ content: `Ressource mise à jour avec succès. Redirection vers vos ressources dans ${counter} secondes...`, key, duration: 0 });

                            // Update the message every second
                            const intervalId = setInterval(() => {
                                   counter -= 1;
                                   message.loading({ content: `Ressource mise à jour avec succès. Redirection vers vos ressources dans ${counter} secondes...`, key, duration: 0 });

                                   if (counter === 0) {
                                          clearInterval(intervalId);
                                          message.success({ content: 'Redirection maintenant !', key, duration: 2 });
                                          router.push('/mes-ressources');
                                          // Here, you could navigate to the desired page using your routing solution, e.g.:
                                          // history.push('/path-to-ressources');
                                   }
                            }, 1000);
                     } else {
                            throw new Error('Failed to update ressource');
                     }
              } catch (error) {
                     setLoading(false);
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   case 404:
                                          message.error("Ressource introuvable");
                                   case 422:
                                          message.error("Champs manquants ou invalides");
                                   default:
                                          message.error("Erreur lors de la mise à jour de la ressource");
                            }
                     } else {
                            message.error("Erreur lors de la mise à jour de la ressource");
                     }
              }
       };

       return (
              <div className='flex flex-col gap-8'>
                     <PageSummary
                            title="Editer une ressource"
                            description="Editer une ressource car elle a été rejettée par un modérateur, ou pour la mettre à jour. Elle repassera en attente de validation et ne sera plus accessible tant qu'elle ne sera pas accéptée par un modérateur."
                     />
                     <Form
                            form={form}
                            name="edit_ressource"
                            initialValues={{ remember: true }}
                            onFinish={onFinish}
                            autoComplete="off"
                            layout="vertical"
                     >
                            <Form.Item
                                   label="Intitulé"
                                   name="label"
                                   rules={[{ required: true, message: 'Veuillez selectionner un intitulé!' }]}
                            >
                                   <Input disabled={loading} />
                            </Form.Item>

                            <Form.Item
                                   label="Description"
                                   name="description"
                                   rules={[{ required: true, message: 'Veuillez selectionner une description!' }]}
                            >
                                   <Input.TextArea disabled={loading} rows={4} />
                            </Form.Item>

                            <Form.Item
                                   label="Categorie"
                                   name={['category', 'id']}
                                   rules={[{ required: true, message: 'Veuillez selectionner une categorie!' }]}
                            >
                                   <Select
                                          // style={{ width: "50%" }}
                                          showSearch
                                          optionFilterProp="label"
                                          loading={loading}
                                          filterOption={(input, option) =>
                                                 (option?.label as string).toLowerCase().indexOf(input.toLowerCase()) >= 0
                                          }
                                   >
                                          {categories.map((category) => (
                                                 <Option key={category.id} value={category.id} label={category.title}>
                                                        {category.title}
                                                 </Option>
                                          ))}
                                   </Select>
                            </Form.Item>



                            <Form.Item
                                   name="isPublic"
                                   valuePropName="checked"
                                   label="Ressource publique"
                            >
                                   <Switch loading={loading} />
                            </Form.Item>

                            <Form.Item>
                                   <Button type="primary" htmlType="submit" loading={loading}>
                                          Sauvegarder
                                   </Button>
                            </Form.Item>
                     </Form>
              </div>
       );
}
