"use client"
import { useRef, useState } from 'react';
import { useUser } from '@/providers/userProvider';
import { Carousel, Menu, Typography, type MenuProps, Button, Spin } from 'antd';
import { CarouselRef } from 'antd/es/carousel';
import { LogoutOutlined } from '@ant-design/icons';

// Components
import LogInForm from '@/components/logInForm';
import SignUpForm from '@/components/signUpForm';
import useLogout from '@/utils/logout'; // Assurez-vous que useLogout retourne { logout, isLoading }
import ForgotPasswordLink from '@/components/forgotPasswordLink';

export default function Login() {
       const { Title } = Typography;
       const carouselRef = useRef<CarouselRef>(null);
       const { user } = useUser();
       const { logout, isLoading } = useLogout();

       // Si l'utilisateur est connecté, afficher uniquement le bouton de déconnexion.
       if (user) {
              return (
                     <div className='flex flex-col items-center w-fit'>
                            <Button
                                   danger
                                   size="large"
                                   onClick={() => logout()}
                                   icon={<LogoutOutlined />}
                                   loading={isLoading}>
                                   {'Se déconnecter'}
                            </Button>
                     </div>
              );
       }

       // Éléments de menu pour la connexion et l'inscription
       const items: MenuProps['items'] = [
              {
                     label: <Title level={3}>{`Se connecter`}</Title>,
                     key: 'logIn',
              },
              {
                     label: <Title level={3}>{`S'inscrire`}</Title>,
                     key: 'signUp',
              },
       ];

       const onMenuClick: MenuProps['onClick'] = (e) => {
              if (carouselRef.current) {
                     // Change la diapositive du carrousel en fonction de l'élément de menu cliqué
                     switch (e.key) {
                            case 'logIn':
                                   carouselRef.current.goTo(0);
                                   break;
                            case 'signUp':
                                   carouselRef.current.goTo(1);
                                   break;
                            default:
                                   carouselRef.current.goTo(0);
                                   break;
                     }
              }
       };

       // Retourne les formulaires de connexion et d'inscription lorsque l'utilisateur n'est pas connecté
       return (
              <div className='flex flex-col items-center w-fit'>
                     <Menu onClick={onMenuClick} defaultActiveFirst mode="horizontal" items={items} />
                     <Carousel
                            infinite={false}
                            ref={carouselRef}
                            dots={false}
                            style={{ width: 300 }}>
                            <div>
                                   <LogInForm />
                                   <ForgotPasswordLink />
                            </div>
                            <SignUpForm />
                     </Carousel>
              </div>
       );
}
