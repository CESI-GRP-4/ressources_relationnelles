import { Popconfirm, Tooltip, Button, message } from 'antd';
import { DeleteOutlined } from '@ant-design/icons';
import axios, { AxiosError } from 'axios';
import User from '@/types/user';

export default function DeleteUserButton({ user, isDisabled, onDelete }: { user: User | null, isDisabled: boolean, onDelete: (userId: string) => void }) {
       // if user is a super admin, disable the button
       if (user?.role === 'SuperAdministrateur') {
              isDisabled = true;
       }
       const deleteUser = async () => {
              try {
                     const deleteUserResponse = await axios({
                            method: 'delete',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL, // * Might be changed depending on the backend implementation
                            url: `/deleteUser/${user?.id}`,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });

                     if (deleteUserResponse.status === 200) {
                            onDelete(user?.id!);
                     }
              } catch (error) { // TODO : Handle errors
                     const axiosError = error as AxiosError;
                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 403:
                                          message.error(`Vous n'êtes pas autorisé à effectuer cette action`);
                                          break;
                                   case 404:
                                          message.error(`Utilisateur introuvable`);
                                          break;
                                   case 422:
                                          message.error('Champs manquants ou invalides');
                                          break;
                                   case 429:
                                          message.error('Trop de tentatives');
                                          break;
                                   default:
                                          message.error(`Erreur inconnue`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              }
       }
       return (
              <Popconfirm title="Êtes-vous sûr de vouloir supprimer cet utilisateur ?" onConfirm={deleteUser}>
                     <Tooltip title="Supprimer l'utilisateur">
                            <Button disabled={isDisabled} danger type='text' icon={<DeleteOutlined style={{ fontSize: '22px' }} />} />
                     </Tooltip>
              </Popconfirm>
       )
}