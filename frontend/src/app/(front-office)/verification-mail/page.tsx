"use client"
import { useEffect, useState, useRef } from 'react';
import { useSearchParams } from 'next/navigation'
import axios, { AxiosError, AxiosResponse } from "axios";
import { CheckCircleOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { message } from 'antd';

export default function VerificationMail() {
       const searchParams = useSearchParams()
       const token = searchParams.get('token');
       const [isVerified, setIsVerified] = useState<null | boolean>(null);
       const requestSent = useRef(false);

       useEffect(() => {
              const fetchData = async () => {
                     if (token && !requestSent.current) {
                            requestSent.current = true;
                            try {
                                   const logInResponse: AxiosResponse = await axios({
                                          method: 'post',
                                          baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                                          url: "/email/verify",
                                          data: { token: token },
                                          withCredentials: true,
                                          responseType: 'json',
                                          timeout: 10000,
                                   });
                                   console.log(logInResponse)
                                   setIsVerified(logInResponse.status === 200)
                            } catch (error) {
                                   console.error('Error: ', error);
                                   setIsVerified(false);

                                   const axiosError = error as AxiosError;
                                   console.error('Axios error: ', axiosError);

                                   if (axiosError.response) {
                                          switch (axiosError.response.status) {
                                                 case 401:
                                                        message.error("Vous n'êtes pas autorisé à effectuer cette action");
                                                        break;
                                                 case 403:
                                                        message.error("Vous n'êtes pas autorisé à effectuer cette action");
                                                        break;
                                                 case 404:
                                                        message.error("Le token n'existe pas");
                                                        break;
                                                 case 500:
                                                        message.error("Erreur interne du serveur");
                                                        break;
                                                 default:
                                                        message.error("Erreur inconnue");
                                                        break;
                                          }
                                   } else {
                                          console.error("Erreur réseau ou serveur indisponible");
                                   }
                            }
                     }
              };
              fetchData();
       }, [token]);

       switch (isVerified) {
              case null:
                     return (
                            <div className="flex items-center flex-col">
                                   <h1 className="text-4xl font-semibold">Vérification du mail</h1>
                                   <p className="mt-14">Vérification en cours...</p>
                            </div>
                     );
              case true:
                     return (
                            <div className="flex items-center flex-col">
                                   <div className="flex flex-row items-center space-x-5">
                                          <h1 className="text-4xl font-semibold">Vérification du mail</h1>
                                          <CheckCircleOutlined style={{ fontSize: '3rem', color: 'green' }} />
                                   </div>
                                   <div className="mt-14"><p>Votre mail a été vérifié avec succès ! Vous pouvez désormais fermer cette fenetre ou</p><a href="/connexion"> vous connecter</a></div>
                            </div>
                     );
              case false:
                     return (
                            <div className="flex items-center flex-col">
                                   <div className="flex flex-row items-center space-x-5">
                                          <h1 className="text-4xl font-semibold">Vérification du mail</h1>
                                          <CloseCircleOutlined style={{ fontSize: '3rem', color: 'red' }} />
                                   </div>
                                   <p className="mt-14">La vérification du mail a échouée.</p>
                            </div>
                     );

              default:
                     return (
                            <div className="flex items-center flex-col">
                                   <h1 className="text-4xl font-semibold">Vérification du mail</h1>
                                   <p className="mt-14">Une erreur inconnue est survenue.</p>
                            </div>
                     );
       }
}

