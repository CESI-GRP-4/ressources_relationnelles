"use client"
import React, { useState, useEffect } from 'react';
import User from "@/types/user";
import { Popconfirm, Tooltip, Button, message, Modal, Input, Divider, Form, Checkbox } from "antd";
import { Icon as Iconify } from '@iconify/react';
import axios, { AxiosError } from "axios";
import { useUser } from '@/providers/userProvider';
import { CheckboxChangeEvent } from 'antd/lib/checkbox';

export default function BanUserButton({ user, isDisabled, onBanChange }: { user: User, isDisabled: boolean, onBanChange: (userId: string, isBanned: boolean) => void }) {
       const { user: currentUser } = useUser();
       const [isBanned, setisBanned] = useState(user.isBanned);
       const [isModalVisible, setIsModalVisible] = useState(false);
       const [banEndDate, setBanEndDate] = useState('');
       const [banEndTime, setBanEndTime] = useState('');
       const [isPermanent, setIsPermanent] = useState(false);

       if (!currentUser || (!currentUser.role || currentUser.role === 'Utilisateur') || (user.id === currentUser.id) || user.role === 'Administrateur' || user.role === 'SuperAdministrateur') {
              isDisabled = true;
       }

       const handleBan = async () => {
              try {
                     const response = await axios({
                            method: 'post',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: isBanned ? `/unbanUser/${user.id}` : `/banUser/${user.id}`,
                            withCredentials: true,
                            headers: {
                                   'Content-Type': 'application/json',
                            },
                            data: {
                                   isPermanent: isPermanent,
                                   endDate: banEndDate,
                                   endTime: banEndTime,
                            },
                            responseType: 'json',
                            timeout: 10000, // * Increased value because we had some timeout errors
                     });
                     if (response.status === 200) {
                            const actionMessage = isBanned ? "Bannissement révoqué" : "Utilisateur banni";
                            message.success(actionMessage);
                            setisBanned(!isBanned); // Update state to trigger re-render
                            onBanChange(user.id ?? '', !isBanned); // Invoke callback function with default value
                            setIsModalVisible(false);
                            message.success(`Utilisateur banni pour ${banDuration}`);
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
              setisBanned(user.isBanned);
       }, [user.isBanned]);
       const handleCancel = () => {
              setIsModalVisible(false);
       };

       const showBanModal = () => {
              setIsModalVisible(true);
       };
       const banDuration = isPermanent ? "toujours" : `${banEndDate} à ${banEndTime}`;

       const handleTimeChange = (e: React.ChangeEvent<HTMLInputElement>) => {
              console.log("🚀 ~ handleTimeChange ~ e:", e.target.value);
              setBanEndTime(e.target.value);
       };

       const handleDateChange = (e: React.ChangeEvent<HTMLInputElement>) => {
              console.log("🚀 ~ handleDateChange ~ e:", e.target.value);
              setBanEndDate(e.target.value);
       };

       const handleChange = (e: CheckboxChangeEvent) => {
              setIsPermanent(e.target.checked);
              console.log(e.target.checked);
       };
       
       return (
              <>
                     <Tooltip title={isBanned ? "Révoquer le bannissement" : "Bannir l'utilisateur"}>
                            <Button type='text' onClick={showBanModal} disabled={isDisabled} icon={<Iconify style={{ fontSize: '26px', color: isDisabled ? "rgba(0, 0, 0, 0.25)" : isBanned ? "green" : "orange" }} icon="basil:user-block-solid" />}></Button>
                     </Tooltip>
                     <Modal title="Bannir l'utilisateur pour une durée" open={isModalVisible} onOk={handleBan} onCancel={handleCancel}>
                            <div className="mt-5">
                                   <Form
                                          disabled={isPermanent}>
                                          <Form.Item>
                                                 <Input addonBefore="Date de fin" onChange={handleDateChange} type="date" />
                                          </Form.Item>
                                          <Form.Item>
                                                 <Input addonBefore="Heure de fin" onChange={handleTimeChange} type="time" />
                                          </Form.Item>
                                   </Form>
                                   <Divider>Ou</Divider>
                                   <Form>
                                          <Form.Item>
                                                 <Checkbox onChange={handleChange}>Bannir définitivement</Checkbox>
                                          </Form.Item>
                                   </Form>
                            </div>
                     </Modal>
              </>
       );
}
