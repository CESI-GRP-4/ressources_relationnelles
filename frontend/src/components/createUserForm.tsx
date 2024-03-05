import { useState } from "react";
import { Button, Modal, Form, Input, Select } from "antd";
import UserAddOutlined from "@ant-design/icons/UserAddOutlined";
import User from "@/types/user";
import PasswordInputComponent from "@/components/PasswordInput";

export default function CreateUserForm() {
       const [isModalOpen, setIsModalOpen] = useState(false);

       const showModal = () => {
              setIsModalOpen(true);
       };

       const handleOk = () => {
              setIsModalOpen(false);
       };

       const handleCancel = () => {
              setIsModalOpen(false);
       };

       return (
              <>
                     <Button type="primary" onClick={() => { showModal() }} icon={<UserAddOutlined />}>Ajouter un utilisateur</Button>
                     <Modal
                            title="Ajouter un utilisateur"
                            cancelText="Annuler"
                            okText={`Ajouter l'utilisateur`}
                            open={isModalOpen}
                            onOk={handleOk}
                            onCancel={handleCancel}
                     >

                            {/* form based on the User type */}

                            <Form
                                   layout="vertical"
                                   initialValues={{ size: 'default' }}
                            >
                                   <Form.Item<User> label="Email" name="email" rules={[{ required: true, message: "Veuillez entrer un email" }]}>
                                          <Input />
                                   </Form.Item>
                                   <Form.Item<User> label="Nom" name="lastName" rules={[{ required: true, message: "Veuillez entrer un nom" }]}>
                                          <Input />
                                   </Form.Item>

                                   <Form.Item<User> label="Prénom" name="firstName" rules={[{ required: true, message: "Veuillez entrer un prénom" }]}>
                                          <Input />
                                   </Form.Item>

                                   <Form.Item<User> name="role" label="Rôle" rules={[{ required: true, message: "Veuillez sélectionner un rôle" }]}>
                                          <Select>
                                                 <Select.Option value="admin">Admin</Select.Option>
                                                 <Select.Option value="user">Utilisateur</Select.Option>
                                          </Select>

                                   </Form.Item>
                                   <PasswordInputComponent label="Mot de passe" name="password" rules={[{ required: true, message: "Veuillez entrer un mot de passe" }]} />
                            </Form>

                     </Modal>

              </>
       )
}