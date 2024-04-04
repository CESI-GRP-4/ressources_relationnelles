import React, { useState } from "react";
import {Button, Form, Input, message, Modal, notification, Select, Space, Switch} from "antd";
import {AppstoreAddOutlined} from "@ant-design/icons";
import axios, { AxiosError } from "axios";


export default function CreateCategoryForm( {refreshCategories}: {refreshCategories: Function}) {
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isCreateCategoryLoading, setCreateCategoryLoading] = useState(false);
    const [formRef] = Form.useForm();

    type CreateCategoryForm = {
        title: string;
        description: string;
        color: string;
        icon: string;
        isActive: boolean;
    };

    interface ApiResponse {
        message: string;
        errors: Record<string, string[]>;
    }

    const showModal = () => {
        setIsModalOpen(true);
    };

    const handleOk = () => {
        message.success('Catégorie créée avec succès.');
        formRef.resetFields();
        refreshCategories();
        setIsModalOpen(false);
    };

    const handleCancel = () => {
        formRef.resetFields();
        setIsModalOpen(false);
    };

    const onSwitch = (checked: boolean) => {
        formRef.setFieldsValue({ isActive: checked });
    }

    async function onSubmit(form: CreateCategoryForm) {
        setCreateCategoryLoading(true);
        try {
            const response = await axios({
                method: 'post',
                baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                url: "/createCategory",
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
                setCreateCategoryLoading(false);
            }, 1000);
        }

    }

    return (
        <>
            <Button type="primary" onClick={showModal} icon={<AppstoreAddOutlined />}>
                Créer une nouvelle catégorie
            </Button>
            <Modal title="Créer une nouvelle catégorie"
                   onCancel={handleCancel}
                   open={isModalOpen}
                   footer={null}
            >
                <Form
                    form={formRef}
                    name="createCategoryForm"
                    layout='vertical'
                    style={{ marginBottom: 0, paddingTop: 20, paddingLeft: 20, paddingRight: 20 }}
                    onFinish={onSubmit}
                    size='large'
                    disabled={isCreateCategoryLoading}
                    autoComplete="off"
                    initialValues={{
                        color: "#000000"
                    } as CreateCategoryForm
                    }
                >

                    {/* title */}
                    <Form.Item<CreateCategoryForm>
                        style={{ marginBottom: 0 }}
                        label="Titre de la catégorie"
                        name="title"
                        rules={[
                            { required: true, message: 'Veuillez entrer un titre' }]}>
                        <Input allowClear placeholder="Sélectionner un titre" />
                    </Form.Item>

                    {/* description */}
                    <Form.Item
                        style={{ marginBottom: 0 }}
                        label="Description"
                        name="description"
                        rules={[
                            { required: true, message: 'Veuillez entrer une description' }]}>
                        <Input.TextArea allowClear placeholder="Sélectionner une description" />
                    </Form.Item>

                    {/* color */}
                    <Form.Item
                        style={{ marginBottom: 0 }}
                        label="Couleur"
                        name="color"
                    >
                        <Input type="color" allowClear placeholder="Sélectionner une couleur" />
                    </Form.Item>

                    {/* icon */}
                    <Form.Item
                        style={{ marginBottom: 0 }}
                        label="Icône"
                        name="icon"
                        rules={[
                            { required: true, message: 'Veuillez entrer une icône' }]}>
                        <Input allowClear placeholder="Sélectionner une icône" />
                    </Form.Item>

                    {/* isActive */}
                    <Form.Item
                        style={{ marginBottom: 0 }}
                        label="Activer la catégorie"
                        name="isActive"
                        valuePropName="checked">
                        <Switch checkedChildren="Oui" unCheckedChildren="Non" defaultChecked onChange={onSwitch}/>
                    </Form.Item>

                    <div className="flex justify-between mt-5">
                        <Form.Item>
                            <Space>
                                <Button type="default" onClick={handleCancel}>Annuler</Button>
                                <Button type="primary" htmlType="submit" loading={isCreateCategoryLoading}>{`Créer la catégorie`}</Button>
                            </Space>
                        </Form.Item>
                    </div>
                </Form >
            </Modal>
        </>
    )
}