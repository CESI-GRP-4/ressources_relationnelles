import { Category } from "@/types/category";
import { Modal, Button, Form, Input, Checkbox, message } from "antd";
import { useState } from "react";
import { DeleteOutlined } from "@ant-design/icons";
import axios, { AxiosError } from "axios";
export default function ModifyCategoryModal({ category, visible, setVisible }: { category: Category, visible: boolean, setVisible: Function }) {
       const [isModifyingCategoryLoading, setIsModifyingCategoryLoading] = useState<boolean>(false);

       const onSubmit = async (values: any) => {
              console.log(values.title, values.description, values.color, values.isActive);
              setIsModifyingCategoryLoading(true);

              try {
                     const response = await axios({
                            method: 'POST',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/editCategory/' + category.id,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                            data: {
                                   title: values.title,
                                   description: values.description,
                                   color: values.color,
                                   icon: category.icon,
                                   isActive: values.isActive
                            }
                     });
                     if (response.status === 200) {
                            message.success("Catégorie modifiée avec succès")
                            console.log(response.data)

                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à modifier cette catégorie")
                                          break
                                   default:
                                          message.error("Erreur lors de la modification de la catégorie")
                            }
                     } else {
                            message.error("Erreur lors de la modification de la catégorie")
                     }
              } finally {
                     setIsModifyingCategoryLoading(false)
              }
       }

       type FormValues = {
              title: string,
              description: string,
              color: string,
              icon: string,
              isActive: boolean
       }
       return (
              <div>
                     <Modal
                            title="Modifier une catégorie"
                            open={visible}
                            onCancel={() => setVisible(false)}
                            footer={[]}
                     >
                            <div className="mt-4">
                                   <Form
                                          layout="vertical"
                                          name="modifyCategoryForm"
                                          style={{ marginBottom: 0, paddingLeft: 20, paddingRight: 20 }}
                                          onFinish={onSubmit}
                                          size='large'
                                          disabled={isModifyingCategoryLoading}
                                          autoComplete="off"
                                          initialValues={{
                                                 title: category.title,
                                                 description: category.description,
                                                 color: category.color,
                                          } as FormValues
                                          }
                                   >
                                          <Form.Item<FormValues>
                                                 label="Nom de la catégorie"
                                                 rules={[
                                                        { required: true, message: 'Veuillez entrer un titre de catégorie' }]}
                                                 name={"title"}
                                          >
                                                 <Input allowClear placeholder={category.title || "Titre de la catégorie"} />
                                          </Form.Item>

                                          <Form.Item<FormValues>
                                                 label="Description de la catégorie"
                                                 rules={[
                                                        { required: true, message: 'Veuillez entrer une description' }]}
                                                 name={"description"}
                                          >
                                                 <Input.TextArea allowClear placeholder={category.description || "Description de la catégorie"} />
                                          </Form.Item>

                                          <Form.Item<FormValues>
                                                 rules={[
                                                        { required: true, message: 'Veuillez séléctionner une couleur' }]}
                                                 name={"color"}
                                                 label="Couleur de la catégorie">
                                                 <Input type="color" allowClear placeholder="Couleur de la catégorie" />
                                          </Form.Item>

                                          <Form.Item<FormValues>
                                                 name={"isActive"}
                                                 label="Catégorie active">
                                                 <Checkbox checked={category.isActive} defaultChecked={category.isActive}></Checkbox>
                                          </Form.Item>

                                          <div className="flex flex-row justify-between items-center mt-4">
                                                 <div>
                                                        <Button icon={<DeleteOutlined />} type="primary" danger>
                                                               Supprimer
                                                        </Button>
                                                 </div>
                                                 <div className="flex flex-row gap-2">
                                                        <Button key="back" onClick={() => setVisible(false)}>
                                                               Annuler
                                                        </Button>
                                                        <Button key="submit" htmlType="submit" type="primary">
                                                               Enregistrer
                                                        </Button>
                                                 </div>
                                          </div>
                                   </Form>
                            </div>
                     </Modal>
              </div>
       );

}