import { useState } from 'react';
import axios, { AxiosError } from 'axios';
import { message } from 'antd';
import { useUser } from "@/providers/userProvider"; // Supposons que useUser est un hook pour accéder à setUser
import { useRouter } from 'next/navigation';

const useLogout = () => {
       const { setUser } = useUser();
       const router = useRouter();
       const [isLoading, setIsLoading] = useState(false); // Ajout de l'état isLoading

       const logout = async () => {
              setIsLoading(true); // Commence le chargement
              try {
                     const logOutResponse = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: "/logout",
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
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
              } finally {
                     setUser(null); // Remove user from context/state
                     setIsLoading(false); // Arrête le chargement quelle que soit l'issue
                     router.replace('/connexion'); // Redirect to login page
              }
       };
       return { logout, isLoading }; // Retourne à la fois la fonction logout et l'état isLoading
};

export default useLogout;
