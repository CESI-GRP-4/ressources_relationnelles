"use client"
import React, { useState, useEffect } from 'react';
import User from "@/types/user";
import { Popconfirm, Tooltip, Button, message } from "antd";
import { Icon as Iconify } from '@iconify/react';
import axios, { AxiosError } from "axios";
import { useUser } from '@/providers/userProvider';

export default function BanUserButton({ user, isDisabled }: { user: User, isDisabled: boolean }) {
       const { user: currentUser } = useUser();
       const [isBlocked, setIsBlocked] = useState(user.isBlocked);

       if (!currentUser || (!currentUser.role || currentUser.role === 'Utilisateur') || (user.id === currentUser.id) || user.role === 'Administrateur' || user.role === 'SuperAdministrateur') {
              isDisabled = true;
       }
       const handleBan = async () => {
              try {
                     const response = await axios({
                            method: 'patch',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: isBlocked ? `/unblockUser/${user.id}` : `/blockUser/${user.id}`,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     if (response.status === 200) {
                            const actionMessage = isBlocked ? "Bannissement révoqué" : "Utilisateur banni";
                            message.success(actionMessage);
                            setIsBlocked(!isBlocked); // Update state to trigger re-render
                     }
              } catch (error) {
                     console.error('An error occurred:', error);

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
                                   case 429:
                                          message.error('Trop de tentatives');
                                          break;
                                   case 422:
                                          message.error('Erreur de validation des données');
                                          break;
                                   default:
                                          message.error(`Erreur inconnue`);
                                          break;
                            }
                     } else {
                            message.error('Erreur réseau ou serveur indisponible');
                     }
              }
       };

       useEffect(() => {
              setIsBlocked(user.isBlocked);
       }, [user.isBlocked]);

       return (
              <Popconfirm
                     title={isBlocked ? "Êtes-vous sûr de vouloir révoquer le bannissement de cet utilisateur ?" : "Êtes-vous sûr de vouloir bannir cet utilisateur ?"}
                     onConfirm={handleBan}
              >
                     <Tooltip title={isBlocked ? "Révoquer le bannissement" : "Bannir l'utilisateur"}>
                            <Button type='text' disabled={isDisabled} style={{ color: isDisabled ? "rgba(0, 0, 0, 0.25)" : isBlocked ? "green" : "orange" }} icon={<Iconify style={{ fontSize: '26px' }} icon="basil:user-block-solid" />}></Button>
                     </Tooltip>
              </Popconfirm>
       );
}
