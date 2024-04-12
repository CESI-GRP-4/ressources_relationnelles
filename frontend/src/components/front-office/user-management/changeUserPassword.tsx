"use client"
import React, { useEffect, useState } from 'react';
import { Form, Button, message, Card, Row, Col } from 'antd';
import { SaveOutlined } from '@ant-design/icons';

import axios from 'axios';
import type User from '@/types/user';
import PasswordInputComponent from '@/components/PasswordInput';

const ChangeUserPassword = () => {
    const [form] = Form.useForm();
    const [userData, setUserData] = useState<User | null>(null);

    const onFinish = async (values: any) => {
        try {
            /*const response = await axios({
                       method: 'post',
                       baseURL: 'http://localhost/api',
                       url: "/changeUserPassword",
                       data: {
                        values: values
                       },
                       withCredentials: true,
                      responseType: 'json',
                       timeout: 10000,
                     });*/
            const response = { data: { ...values } };
            console.error('LES DONNEEEEEESSSSS:', response);

            // Mise à jour des données utilisateur si nécessaire
            if (setUserData) {
                setUserData(response.data);
            }
            message.success('Mot de passe modifié avec succès!');
            form.resetFields();
        } catch (error) {
            console.error('Error saving password:', error);
            message.error('Une erreur est survenue lors de l\'enregistrement du mot de passe');
        }
    };

    return (
        <Card title="Modification de votre mot de passe" bordered={false} style={{ marginBottom: 16, maxWidth: '1000px' }}>
            <Form
                form={form}
                layout="horizontal"
                onFinish={onFinish}
                labelCol={{ span: 6 }}
                wrapperCol={{ span: 18 }}
            >
                <Row gutter={[16, 16]}> {/* Utilisation de Row pour créer une ligne */}
                    <Col span={24}> {/* Utilisation de Col pour définir la largeur de la colonne */}
                        <PasswordInputComponent
                            useRegex={false}
                            label="Ancien mot de passe"
                            name="oldPassword"
                            required={true}
                            style={{ width: '100%' }}
                        />
                    </Col>
                </Row>
                <Row gutter={[16, 16]}>
                    <Col span={24}>
                        <PasswordInputComponent
                            useRegex={true}
                            label="Nouveau mot de passe"
                            name="newPassword"
                            required={true}
                            style={{ width: '100%' }}
                        />
                    </Col>
                </Row>
                <Row gutter={[16, 16]}>
                    <Col span={24}>
                        <PasswordInputComponent
                            useRegex={true}
                            label="Confirmer le mot de passe"
                            name="confirmPassword"
                            required={true}
                            style={{ width: '100%' }}
                        />
                    </Col>
                </Row>
                <Form.Item style={{ textAlign: 'center' }} wrapperCol={{ span: 24 }}>
                    <Button type="primary" htmlType="submit" icon={<SaveOutlined />}>
                        Enregistrer le mot de passe
                    </Button>
                </Form.Item>

            </Form>
        </Card>
    );


};

export default ChangeUserPassword;
