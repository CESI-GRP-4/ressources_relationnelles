import { useState } from "react";
import axios, { AxiosError, AxiosResponse } from 'axios';
import { Button, Tooltip, message } from 'antd';
import { LogoutOutlined } from '@ant-design/icons';
import { useUser } from "@/providers/userProvider";

export default function LogoutButton() {
       const { setUser } = useUser();
       const [isLogoutLoading, setLogoutLoading] = useState(false);

       const handleLogout = async (): Promise<void> => {
              setLogoutLoading(true);
              try {
                     const logOutResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: "/logout",
                            withCredentials: true, // Necessary for HTTP-only cookies in cross-origin scenarios
                            responseType: 'json',
                            timeout: 10000, // Increased value because we had some timeout errors
                     });

                     if (logOutResponse.status === 200) {
                            message.success('Déconnexion réussie');
                     }
              } catch (error) {
                     console.error('Logout request failed:', error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error('Vous n\'êtes pas connecté');
                                          break;
                                   case 403:
                                          message.error('Vous n\'êtes pas autorisé à effectuer cette action');
                                          break;
                                   case 429:
                                          message.error('Trop de tentatives de connexion');
                                          break;
                                   default:
                                          message.error('Échec de la déconnexion');
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              }
              finally {
                     setUser(null);
                     setLogoutLoading(false);
              }
       };

       return (
              <Tooltip title="Se déconnecter">
                     <Button loading={isLogoutLoading} danger size="large" onClick={handleLogout} shape="circle" icon={<LogoutOutlined />} />
              </Tooltip>
       );
}
