"use client"
import React, { useEffect, useState } from 'react';
import { message, Form, Input, Button, Switch, Select, Alert } from 'antd';
import axios, { AxiosError, AxiosResponse } from 'axios';
import Ressource from "@/types/ressource";
import PageSummary from '@/components/pageSummary';
import { Category } from '@/types/category';
const { Option } = Select;
import { useRouter } from 'next/navigation';
import { useUser } from '@/providers/userProvider';
import { Typography } from 'antd';
const { Text, Title } = Typography;

export default function EditRessource({ params }: { params: { idRessource: number } }) {
       const [form] = Form.useForm();
       const [loading, setLoading] = useState<boolean>(true);
       const [categories, setCategories] = useState<Category[]>([]);
       const router = useRouter();
       const { user: currentUser } = useUser();
       const [ressource, setRessource] = useState<Ressource>();

       useEffect(() => {
              if (currentUser?.id != undefined && currentUser?.id != null) {
                     fetchRessource();
                     fetchCategories();
              }
       }, [currentUser]);

       if (!currentUser) return null;

       const fetchRessource = async () => {
              try {
                     setLoading(true);
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
                                   setRessource(response.data.ressource);
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
              finally {
                     setLoading(false);
              }
       };

       return (
              <div className='flex flex-col gap-8'>
                     <PageSummary
                            title="Editer une ressource"
                            description={`
                            Bienvenue sur la page "Éditer une Ressource" de notre plateforme. Accessible à tous les utilisateurs, cette section vous permet de modifier et de mettre à jour les ressources que vous avez précédemment soumises. Ici, vous pouvez apporter des changements aux contenus, ajuster les catégorisations, ou mettre à jour les informations associées à chaque ressource pour s'assurer qu'elles restent pertinentes et actuelles. Utilisez cette page pour améliorer la qualité et l'utilité de vos contributions, en les gardant alignées avec les besoins et les intérêts de la communauté. Cette fonctionnalité est essentielle pour maintenir un niveau élevé de contenu accessible sur la plateforme.`}
                     />
                     {ressource?.status === "blocked" && (
                            <Alert
                                   message={<Title level={4}>{`Ressource bloquée`}</Title>}
                                   description={
                                          <Text>
                                                 {`La ressource a été bloquée par un modérateur. Vous ne pouvez plus la modifier.`}{' '}
                                                 {ressource?.staffComment
                                                        ? <Text>La ressource a été bloquée pour la raison suivante : <Text strong>{ressource.staffComment}</Text></Text>
                                                        : 'Aucun commentaire supplémentaire fourni par le staff.'}
                                          </Text>
                                   }
                                   type="error"
                                   showIcon
                            />
                     )}

                     {ressource?.status === "rejected" && (
                            <Alert
                                   message={<Title level={4}>{`Ressource refusée`}</Title>}
                                   description={
                                          <Text>
                                                 {`La ressource a été refusée par un modérateur. Vous devez la modifier pour qu'elle soit ressoumise à une nouvelle vérification.`}{' '}
                                                 {ressource?.staffComment
                                                        ? <Text>{`La ressource a été refusée pour la raison suivante : `}<Text strong>{ressource.staffComment}</Text></Text>
                                                        : 'Aucun commentaire supplémentaire fourni par le staff.'}
                                          </Text>

                                   }
                                   type="warning"
                                   showIcon
                            />
                     )}

                     {ressource?.status === "pending" && (
                            <Alert
                                   message={<Title level={4}>{`Ressource en attente`}</Title>}
                                   description={
                                          <Text>
                                                 {`La ressource est en attente de vérification. Vous devez attenndre la vérification d'un modérateur pour qu'elle soit publiée. Vous pouvez toujours modifier votre ressource.`}
                                          </Text>
                                   }
                                   type="info"
                                   showIcon
                            />
                     )}

                     {ressource?.status === "accepted" && (
                            <Alert
                                   message={<Title level={4}>{`Ressource acceptée`}</Title>}
                                   description={
                                          <Text>
                                                 {`La ressource a été acceptée par un modérateur. Vous pouvez toujours la modifier. Elle est actuellement visible par la communauté.`}
                                          </Text>
                                   }
                                   type="success"
                                   showIcon
                            />
                     )}


                     <Form
                            form={form}
                            name="edit_ressource"
                            initialValues={{ remember: true }}
                            onFinish={onFinish}
                            autoComplete="off"
                            layout="vertical"
                            disabled={ressource?.status === "blocked"}
                     >
                            <Form.Item
                                   label="Intitulé"
                                   name="label"
                                   rules={[{ required: true, message: 'Veuillez selectionner un intitulé!' }]}
                            >
                                   <Input />
                            </Form.Item>

                            <Form.Item
                                   label="Description"
                                   name="description"
                                   rules={[{ required: true, message: 'Veuillez selectionner une description!' }]}
                            >
                                   <Input.TextArea autoSize={{ minRows: 4 }} />
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
