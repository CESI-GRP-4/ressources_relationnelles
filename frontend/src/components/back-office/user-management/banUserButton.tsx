"use client"
import React, { useState, useEffect } from 'react';
import User from "@/types/user";
import { Popconfirm, Tooltip, Button, message, Modal, Divider, Form, Checkbox, DatePickerProps, CheckboxProps } from "antd";
import { Icon as Iconify } from '@iconify/react';
import axios, { AxiosError } from "axios";
import { useUser } from '@/providers/userProvider';
import { DatePicker, notification } from 'antd';
import dayjs from 'dayjs';
import 'dayjs/locale/fr'; // Importez le locale français
dayjs.locale('fr'); // Utilisez le locale français

export default function BanUserButton({ user, isDisabled, onBanChange }: { user: User, isDisabled: boolean, onBanChange: (userId: string, isBanned: boolean) => void }) {
       const { user: currentUser } = useUser();
       const [isBanned, setisBanned] = useState(user.isBanned);
       const [isModalVisible, setIsModalVisible] = useState(false);
       const [banEndDate, setBanEndDate] = useState(''); // Initialisez avec la date actuelle
       const [banEndTime, setBanEndTime] = useState('');
       const [isPermanent, setIsPermanent] = useState(false);
       const [banTimestamp, setBanTimestamp] = useState(0);
       const banDuration = isPermanent ? "toujours" : `${banEndDate} à ${banEndTime}`;
       const disabledDate = (current: any) => {
              return current && current < dayjs().startOf('day');
       };

       if (!currentUser || (!currentUser.role || currentUser.role === 'Utilisateur') || (user.id === currentUser.id) || user.role === 'Administrateur' || user.role === 'SuperAdministrateur') {
              isDisabled = true;
       }

       useEffect(() => {
              setisBanned(user.isBanned);
       }, [user.isBanned]);

       const handleCancel = () => {
              setIsModalVisible(false);
       };

       const handleBanSubmit = () => {
              isBanned ? handleUnban() : handleBan();
       }

       const handleBan = async () => {
              console.log(banTimestamp)
              if (banTimestamp === 0 && !isPermanent) {
                     notification.error({
                            message: 'Erreur de validation des données. Champs manquants ou invalides.',
                            description: `Veuillez sélectionner une date et une heure de fin de ban ou cocher la case "Bannir définitivement"`,
                            duration: 15,
                            placement: 'top',
                     });
                     return;
              }

              try {
                     const response = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/banUser/${user.id}`,
                            withCredentials: true,
                            headers: {
                                   'Content-Type': 'application/json',
                            },
                            data: {
                                   isPermanent: isPermanent,
                                   banTimestamp: banTimestamp,
                            },
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     if (response.status === 200) {
                            setisBanned(true); // Update state to trigger re-render
                            onBanChange(user.id ?? '', true); // Invoke callback function with default value
                            setIsModalVisible(false);
                            message.success(`Utilisateur banni ${isPermanent ? "définitivement" : `jusqu'au ${banDuration}`}`);
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
                                          notification.error({
                                                 message: 'Erreur de validation des données. Champs manquants ou invalides.',
                                                 description: `Veuillez vérifier les données saisies, l'heure ne peut pas être inférieur à l'heure actuelle si la date est aujourd'hui`,
                                                 duration: 15,
                                                 placement: 'top',
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
       };

       const handleUnban = async () => {
              try {
                     const response = await axios({
                            method: 'patch',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: `/unbanUser/${user.id}`,
                            withCredentials: true,
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     if (response.status === 200) {
                            message.success('Bannissement révoqué');
                            setisBanned(false); // Update state to trigger re-render
                            onBanChange(user.id ?? '', false); // Invoke callback function with default value
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

       const handleBanDateChange: DatePickerProps['onChange'] = (date) => {
              if (date) {
                     setBanTimestamp(date.valueOf());
                     const formattedDate = date.format('DD/MM/YYYY');
                     const formattedTime = date.format('HH:mm');

                     setBanEndDate(formattedDate);
                     setBanEndTime(formattedTime);
              } else {
                     setBanEndDate(dayjs().format('DD/MM/YYYY'));
                     setBanEndTime('');
              }
       };

       const handlePermanentBanChange: CheckboxProps['onChange'] = (e) => {
              setIsPermanent(e.target.checked);
       };

       const showBanModal = () => {
              setIsModalVisible(true);
       };

       return (
              <>
                     <Tooltip title={isBanned ? `Révoquer le bannissement de ${user.firstName} ${user.lastName}` : `Bannir ${user.firstName} ${user.lastName}`}>
                            {isBanned ?
                                   <Popconfirm
                                          title={"Êtes-vous sûr de vouloir révoquer le bannissement de cet utilisateur ?"}
                                          onConfirm={handleBanSubmit}
                                   >
                                          <Button type='text' aria-label="Révoquer bannissement" disabled={isDisabled} icon={<Iconify style={{ fontSize: '26px', color: isDisabled ? "rgba(0, 0, 0, 0.25)" : "green" }} icon="basil:user-block-solid" />}></Button>
                                   </Popconfirm>
                                   :
                                   <Button type='text' aria-label="Bannir l'utilisateur" onClick={showBanModal} disabled={isDisabled} icon={<Iconify style={{ fontSize: '26px', color: isDisabled ? "rgba(0, 0, 0, 0.25)" : "orange" }} icon="basil:user-block-solid" />}></Button>
                            }
                     </Tooltip>

                     <Modal title={isBanned ? `Révoquer le bannissement de ${user.firstName} ${user.lastName}` : `Bannir ${user.firstName} ${user.lastName}`} open={isModalVisible} onOk={handleBanSubmit} onCancel={handleCancel}>
                            <div className="mt-5">
                                   <Form
                                          disabled={isPermanent}>
                                          <Form.Item>
                                                 <DatePicker
                                                        className="w-full"
                                                        showTime={{ format: 'HH:mm' }}
                                                        format="DD/MM/YYYY HH:mm"
                                                        placeholder="Sélectionner une date et une heure de fin de ban"
                                                        disabledDate={disabledDate}
                                                        onChange={handleBanDateChange}
                                                        showNow={false}
                                                 />
                                          </Form.Item>
                                   </Form>
                                   <Divider>Ou</Divider>
                                   <Form>
                                          <Form.Item>
                                                 <Checkbox onChange={handlePermanentBanChange}>Bannir définitivement</Checkbox>
                                          </Form.Item>
                                   </Form>
                            </div>
                     </Modal>
              </>
       );
}
