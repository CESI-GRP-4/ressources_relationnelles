// /profil/[id]/page.tsx
"use client"
import React, { useEffect, useState } from 'react';
import { Card, Avatar, Typography, Spin, Button, Input, message, Form } from 'antd';
import { EditOutlined, SaveOutlined, LeftOutlined } from '@ant-design/icons';
import { UserOutlined } from '@ant-design/icons';
import type User from '@/types/user';
import axios from 'axios';

const { Meta } = Card;
const { Title, Paragraph } = Typography;

const DefaultUserData: User[] = [{
  firstName: 'John',
  lastName: 'Doe',
  email: 'user@example.com',
  imgURL: '/vercel.svg',
  id: '0',
  role: 'user',
  isEmailVerified: true,
  city: 'Toulon',
  country: 'France',
  postalCode: '83000',
  newUser: false,
}];

const UserProfilePage = ({ params }: { params: { id: string } }) => {
  const { id } = params;
  const [userData, setUserData] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [editing, setEditing] = useState(false);

  const [form] = Form.useForm();

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        const response: any = await axios({
          method: 'post',
          baseURL: 'http://localhost/api',
          url: "/getUserData",
          data: { userId: id },
          withCredentials: true,
          responseType: 'json',
          timeout: 10000,
        });
        setUserData(response.data);

        form.setFieldsValue({
          lastName: response.data?.lastName,
          firstName: response.data?.firstName,
          email: response.data?.email,
          city: response.data?.city,
          postalCode: response.data?.postalCode,
          country: response.data?.country,
          role: response.data?.role,
        });
      } catch (error) {
        console.error('Erreur lors de la récupération de la ressource:', error);
        const defaultResource = DefaultUserData.find(item => item.id === String(id));

        if (defaultResource) {
          console.log("user found");
          setUserData(defaultResource);

          form.setFieldsValue({
            lastName: defaultResource.lastName,
            firstName: defaultResource.firstName,
            email: defaultResource.email,
            city: defaultResource.city,
            postalCode: defaultResource.postalCode,
            country: defaultResource.country,
          });
        }
      } finally {
        setLoading(false);
      }
    };

    if (id) {
      fetchUserData();
    } else {
      setUserData(null);
      setLoading(false);
    }
  }, [id, form]);

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
      const response = { data: { ...values, isEmailVerified: values.isEmailVerified }};


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

  if (loading || userData === null) {
    console.log('Utilisateur non trouvé ');
    return <Spin />;
  }

  return (
    <Card
      style={{ width: '400px', margin: 'auto' }}
      actions={[
        <Button
          icon={editing ? <LeftOutlined /> : <EditOutlined />}
          onClick={editing ? handleCancel : handleEdit}  // Utilisez handleCancel lors de l'édition, handleEdit autrement
          key="edit"
        >
          {editing ? 'Retour' : 'Modifier'}
        </Button>
      ]}
    >
      <Meta
        avatar={<Avatar src={userData?.imgURL} icon={<UserOutlined />} />}
        title={`${userData?.firstName} ${userData?.lastName}`}
        description="Les informations vous concernant"
      />
      <Title level={4}>Détails</Title>
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
      >

        <Form.Item
          label="Nom"
          name="lastName"
          rules={[
            {
              required: editing,
              message: 'Veuillez renseigner un nom',
            },
            // Ajoutez d'autres règles de validation au besoin
          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.lastName}</span>
          )}
        </Form.Item>

        <Form.Item
          label="Prénom"
          name="firstName"
          rules={[
            {
              required: editing,
              message: 'Veuillez renseigner un prénom',
            },
            // Ajoutez d'autres règles de validation au besoin
          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.firstName}</span>
          )}
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
              message: 'Entrez une adresse mail valide',
            },

          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.email}</span>
          )}
        </Form.Item>

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
              pattern: /^[a-zA-Z\s-']*$/,
              message: 'Le nom de la ville ne peut contenir que des lettres, des tirets et des apostrophes',
            }
          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.city}</span>
          )}
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
              pattern: /^[0-9]+$/,
              len: 5,
              message: 'Le code postal doit contenir uniquement des chiffres et doit avoir une longueur de 5',
            }
          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.postalCode}</span>
          )}
        </Form.Item>

        <Form.Item
          label="Pays"
          name="country"
          rules={[
            {
              min: 2, // Longueur minimale du nom du pays
              max: 50, // Longueur maximale du nom du pays
              required: editing,
              message: 'Veuillez renseigner un pays',
            },
            {
              pattern: /^[a-zA-Z\s]+$/, // Autorise les lettres majuscules et minuscules ainsi que les espaces
              message: 'Le nom du pays ne peut contenir que des lettres et des espaces',
            }
          ]}
        >
          {editing ? (
            <Input />
          ) : (
            <span>{userData?.country}</span>
          )}
        </Form.Item>

        <Form.Item
          label="Role"
          name="role"
          rules={[
          ]}
        >
          <span>{userData?.role}</span>
        </Form.Item>

        {editing && (
          <Button type="primary" onClick={handleSave} icon={<SaveOutlined />}>
            Enregistrer
          </Button>
        )}
      </Form>
    </Card>
  );
};

export default UserProfilePage;
