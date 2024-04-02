import React, { useState } from "react";
import {Button, Form, Input, message, Modal, Select, Space, notification} from "antd";
import axios, { AxiosError, AxiosResponse } from "axios";
import { emailRegex, firstNameRegex, lastNameRegex } from "@/utils/regex";
import { UserAddOutlined } from "@ant-design/icons";

export default function CreateUserForm({ refreshUsers }: { refreshUsers: () => void }) {
       const [isModalOpen, setIsModalOpen] = useState(false);
       const [isCreateUserLoading, setCreateUserLoading] = useState(false);
       const [formRef] = Form.useForm();

       type CreateUserForm = {
              email: string;
              firstName: string;
              lastName: string;
              role: string;
       };

        interface ApiResponse {
            message: string;
            errors: Record<string, string[]>;
        }

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

       const showModal = () => {
              setIsModalOpen(true);
       };

       const handleOk = () => {
              message.success('Utilisateur créé avec succès.');
              refreshUsers();
              formRef.resetFields();
              setIsModalOpen(false);
       };

       const handleCancel = () => {
              formRef.resetFields();
              setIsModalOpen(false);
       };

       async function onSubmit(form: CreateUserForm) {
              setCreateUserLoading(true);
              try {
                     const response = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/createUser",
                            data: form,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });

                     if (response.status !== 201) {
                            throw new Error('Error');
                     } else {
                            handleOk();

                     }
              } catch (error) {
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;

                                   case 422:
                                       const responseData = axiosError.response.data as ApiResponse;
                                       const errors = responseData.errors;
                                       const errorMessages = Object.keys(errors)
                                             .map(key => `- ${errors[key].join(', ')}`)
                                             .join('\n');

                                          notification.error({
                                              message: 'Champs manquants ou invalides',
                                              description: `\n${errorMessages}`,
                                              placement: 'top',
                                              duration: 3,
                                          });
                                          break;

                                   default:
                                          message.error(`Erreur inconnue`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              }
              finally {
                     setTimeout(() => {
                            setCreateUserLoading(false);
                     }, 1000);
              }
       }


       return (
              <>
                     <Button type="primary" onClick={showModal} icon={<UserAddOutlined />}
                     >
                            Créer un utilisateur
                     </Button>
                     <Modal title="Créer un utilisateur"
                            onCancel={handleCancel}
                            open={isModalOpen}
                            footer={null}
                     >
                            <Form
                                   form={formRef}
                                   name="createUserForm"
                                   layout='vertical'
                                   style={{ marginBottom: 0, paddingTop: 20, paddingLeft: 20, paddingRight: 20 }}
                                   onFinish={onSubmit}
                                   size='large'
                                   disabled={isCreateUserLoading}
                                   autoComplete="off">

                                   {/* email */}
                                   <Form.Item<CreateUserForm>
                                          style={{ marginBottom: 0 }}
                                          label="Adresse e-mail"
                                          name="email"
                                          tooltip="L'adresse e-mail sera utilisée pour se connecter, recevoir des notifications et réinitialiser le mot de passe en cas d'oubli. Elle ne sera (par défaut) pas visible par les autres utilisateurs."
                                          rules={[
                                                 { required: true, message: 'Veuillez entrer une adresse e-mail' }, emailValidationRule]}>
                                          <Input allowClear placeholder="Sélectionner une adresse e-mail" />
                                   </Form.Item>

                                   {/* firstName */}
                                   <Form.Item<CreateUserForm>
                                          style={{ marginBottom: 0 }}
                                          tooltip="Le prénom sera visible par les autres utilisateurs."
                                          label="Prénom"
                                          name="firstName"
                                          rules={[{ required: true, message: 'Veuillez entrer un prénom' }, firstNameValidationRule]}>
                                          <Input allowClear placeholder="Sélectionner un prénom" />
                                   </Form.Item>

                                   {/* lastName */}
                                   <Form.Item<CreateUserForm>
                                          style={{ marginBottom: 0 }}
                                          label="Nom"
                                          name="lastName"
                                          tooltip="Le nom ne sera pas visible par les autres utilisateurs."
                                          rules={[{ required: true, message: "Veuillez entrer un nom" }, lastNameValidationRule]}>
                                          <Input allowClear placeholder="Sélectionner un nom" />
                                   </Form.Item>

                                   {/* role */}
                                   <Form.Item
                                          style={{ marginBottom: 0 }}
                                          label="Rôle"
                                          name="role"
                                          tooltip="Le rôle de l'utilisateur."
                                          rules={[{ required: true, message: "Veuillez sélectionner le rôle de l'utilisateur" }]}
                                   >
                                          <Select
                                                 showSearch
                                                 allowClear
                                                 placeholder="Sélectionner un rôle"
                                          >
                                                 <Select.Option value="Utilisateur">Utilisateur</Select.Option>
                                                 <Select.Option value="Moderateur">Modérateur</Select.Option>
                                                 <Select.Option value="Administrateur">Administrateur</Select.Option>
                                                 <Select.Option value="SuperAdministrateur">Super-administrateur</Select.Option>
                                          </Select>
                                   </Form.Item>

                                   <div className="flex justify-end mt-5">
                                          <Form.Item>
                                                 <Space>
                                                        <Button type="default" onClick={handleCancel}>Annuler</Button>
                                                        <Button type="primary" htmlType="submit" loading={isCreateUserLoading}>{`Créer l'utilisateur`}</Button>
                                                 </Space>
                                          </Form.Item>
                                   </div>
                            </Form >
                     </Modal>
              </>
       )
}