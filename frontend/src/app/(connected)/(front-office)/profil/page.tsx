"use client"
import React, { useEffect, useState } from 'react';
import { Card, Avatar, Typography, Spin, Button, message, Form, Space, Input } from 'antd';
import { EditOutlined, SaveOutlined, LeftOutlined } from '@ant-design/icons';
import { UserOutlined } from '@ant-design/icons';
import type User from '@/types/user';
import { useUser } from '@/providers/userProvider';
import { Row, Col } from 'antd';
import axios from 'axios';
import SelectCountry from '@/components/selectCountry';
import PasswordForm from '@/components/front-office/user-management/changeUserPassword'; // Importez le composant PasswordForm
import { emailRegex, firstNameRegex, lastNameRegex, cityRegex, postalCodeRegex } from '@/utils/regex';

const { Meta } = Card;
const { Title } = Typography;

const UserProfilePage = () => {
    const [userData, setUserData] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    const [editing, setEditing] = useState(false);
    const { user } = useUser();
    const [form] = Form.useForm();
    const [selectedCountry, setSelectedCountry] = useState(null);
    useEffect(() => {
        const fetchUserData = async () => {
            try {
                console.log('Fetching user data...');
                console.log('User before fetch:', user);

                // Mettez à jour le state avec les données utilisateur
                setUserData(user);

                // Remplissez le formulaire avec les données de l'utilisateur
                form.setFieldsValue({
                    lastName: user?.lastName,
                    firstName: user?.firstName,
                    email: user?.email,
                    city: user?.city,
                    postalCode: user?.postalCode,
                    country: user?.country,
                    role: user?.role,
                });
            } catch (error) {
                console.error('Error fetching user data:', error);
                throw new Error('Utilisateur non connecté ou non trouvé');
            } finally {
                setLoading(false);
            }
        };

        fetchUserData();
    }, [form, user]);

    const handleEdit = () => {
        // Activer le mode d'édition lors du clic sur le bouton "Modifier"
        setEditing(true);
    };

    const handleSave = async () => {
        let isFormValid = false;

        try {
            console.log('Entré dans le bloc try.');

            // Forcer une validation manuelle du formulaire pour s'assurer que les règles de validation sont appliquées
            await form.validateFields();

            // Si la validation réussit, les valeurs dans le formulaire sont récupérées avec getFieldsValue
            const values = form.getFieldsValue();
            console.log('Form values:', values);

            // Vérifiez si l'email a été modifié
            const emailChanged = values.email !== userData?.email;
            if (emailChanged) {
                values.isEmailVerified = false; // Met isEmailVerified à false si l'email a changé
            } else {
                values.isEmailVerified = userData?.isEmailVerified; // Conserve la valeur actuelle si l'email n'a pas changé
            }

            // Temporairement retiré pour tester les champs sans connexion à l'API
            // const response: any = await axios({
            //   method: 'post',
            //   baseURL: 'http://localhost/api',
            //   url: "/saveUserData",
            //   data: {
            //     userId: id,
            //     updatedData: values,
            //   },
            //   withCredentials: true,
            //   responseType: 'json',
            //   timeout: 10000,
            // });

            // Temporairement utilisé pour simuler une réponse du serveur
            const response = { data: { ...values, isEmailVerified: values.isEmailVerified } };

            setUserData(response.data);
            message.success('Data saved successfully!');

            isFormValid = true;
        } catch (error) {
            console.error('Error saving user data:', error);
        } finally {
            if (isFormValid) {
                setEditing(false);
            }
        }
    };

    const handleCancel = () => {
        // Désactiver le mode édition lors du clic sur le bouton "Retour"
        setEditing(false);
        // Réinitialiser le formulaire
        form.resetFields();
    };

    if (loading || user === null) {
        console.log('Utilisateur non trouvé ');
        return <Spin />;
    }

    return (
        <Card
            style={{ width: '100%', maxWidth: '1000px', margin: 'auto', marginTop: '2%', marginBottom: '2%', borderColor: '#aeaeaecc'}}
            actions={[
                <Button
                    icon={editing ? <LeftOutlined /> : <EditOutlined />}
                    onClick={editing ? handleCancel : handleEdit}
                    key="edit"
                    disabled={true}
                >
                    {editing ? 'Retour' : 'Modifier'}
                </Button>
            ]}
        >
            <Meta
                avatar={<Avatar src={userData?.imgURL} style={{ height: 50, width: 50 }} icon={<UserOutlined />} />}
                style={{ marginBottom: '2%' }}
                title={`${userData?.firstName} ${userData?.lastName}`}
                description="Les informations vous concernant"
            />

            <Form
                form={form}
                initialValues={{
                    lastName: userData?.lastName,
                    firstName: userData?.firstName,
                    email: userData?.email,
                    city: userData?.city,
                    postalCode: userData?.postalCode,
                    country: userData?.country,
                    role: userData?.role,
                }}
                labelCol={{ span: 8 }}
                wrapperCol={{ span: 16 }}
            >
                <Row gutter={16}>
                    <Col span={12}>
                        <Card title="Détails" bordered={true} style={{ marginBottom: 16, borderColor: '#aeaeaecc'}} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                            <Form.Item
                                label="Nom"
                                name="lastName"
                                rules={[
                                    {
                                        required: editing,
                                        message: 'Veuillez renseigner un nom',
                                        pattern: lastNameRegex
                                    },
                                ]}
                            >
                                {editing ? <Input /> : <span>{userData?.lastName}</span>}
                            </Form.Item>

                            <Form.Item
                                label="Prénom"
                                name="firstName"
                                rules={[
                                    {
                                        required: editing,
                                        message: 'Veuillez renseigner un prénom',
                                        pattern: firstNameRegex
                                    },
                                ]}
                            >
                                {editing ? <Input /> : <span>{userData?.firstName}</span>}
                            </Form.Item>

                            <Form.Item
                                label="Email"
                                name="email"
                                rules={[
                                    {
                                        required: editing,
                                        message: 'Veuillez renseigner une adresse mail',
                                    },
                                    {
                                        min: 5,
                                        max: 100,
                                        type: 'email',
                                        pattern: emailRegex,
                                        message: 'Entrez une adresse mail valide',
                                    },
                                ]}
                            >
                                {editing ? <Input /> : <span>{userData?.email}</span>}
                            </Form.Item>
                        </Card>
                    </Col>
                    <Col span={12}>
                        <Card title="Localisation" bordered={true} style={{ marginBottom: 16, borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                            <Form.Item
                                label="Ville"
                                name="city"
                                rules={[
                                    {
                                        min: 2,
                                        max: 50,
                                        required: editing,
                                        message: 'Veuillez renseigner une ville',
                                    },
                                    {
                                        pattern: cityRegex,
                                        message: 'Le nom de la ville ne peut contenir que des lettres, des tirets et des apostrophes',
                                    }
                                ]}
                            >
                                {editing ? <Input /> : <span>{userData?.city}</span>}
                            </Form.Item>

                            <Form.Item
                                label="Code postal"
                                name="postalCode"
                                rules={[
                                    {
                                        required: editing,
                                        message: 'Veuillez renseigner un code postal',
                                    },
                                    {
                                        pattern: postalCodeRegex,
                                        len: 5,
                                        message: 'Le code postal doit contenir uniquement des chiffres et doit avoir une longueur de 5',
                                    }
                                ]}
                            >
                                {editing ? <Input /> : <span>{userData?.postalCode}</span>}
                            </Form.Item>

                            <Form.Item
                                label="Pays"
                                name="country"
                                rules={[
                                    {
                                        required: editing,
                                        message: 'Veuillez renseigner un pays',
                                    },
                                ]}
                            >
                                {editing ? (
                                    <SelectCountry
                                        value={selectedCountry}
                                        onChange={(value: any) => setSelectedCountry(value)}
                                    />
                                ) : (
                                    <Space>
                                        <Avatar src={`https://flagcdn.com/h240/${userData?.countryCode?.toLowerCase()}.png`} />
                                        <span>{userData?.country}</span>
                                    </Space>
                                )}
                            </Form.Item>
                        </Card>
                    </Col>
                </Row>
                <Col span={12}>
                    <Card title="Vos accès" bordered={true} style={{ marginBottom: 16, width: '200%', borderColor: '#aeaeaecc' }} headStyle={{ borderBottomColor: '#aeaeaecc' }}>
                        <Form.Item
                            label="Role"
                            name="role"
                            style={{ width: '50%' }}
                            rules={[
                            ]}
                        >
                            <span>{userData?.role}</span>
                        </Form.Item>
                    </Card>
                </Col>
            </Form>
            {editing && <PasswordForm />}
            {editing && (
                    <div style={{ display: 'flex', justifyContent: 'center', paddingTop: '1%' }}>
                        <Button type="primary" onClick={handleSave} icon={<SaveOutlined />}>
                            Enregistrer
                        </Button>
                    </div>
                )}
        </Card>

    );
};

export default UserProfilePage;
