// logout.js
import axios, { AxiosError } from 'axios';
import { message } from 'antd';
import { useUser } from "@/providers/userProvider"; // Assuming useUserContext is a hook to access setUser
import { useRouter } from 'next/navigation';

const useLogout = () => {
       const { setUser } = useUser();
       const router = useRouter();

       const logout = async () => {
              try {
                     const logOutResponse = await axios({
                            method: 'post',
                            baseURL: 'http://localhost/api',
                            url: "/logout",
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000,
                     });

                     if (logOutResponse.status === 200) {
                            message.success('Déconnexion réussie');
                            setUser(null); // Remove user from context/state
                            router.replace('/connexion'); // Redirect to home page
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
       };
       return logout;
};

export default useLogout;