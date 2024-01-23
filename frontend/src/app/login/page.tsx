// login/page.tsx
"use client"

import { useRef } from 'react';
import { useUser } from '@/providers/userProvider';
import { Carousel, Menu, Typography, type MenuProps } from 'antd';
import { CarouselRef } from 'antd/es/carousel';

// Components
import LogInForm from '@/components/logInForm';
import SignUpForm from '@/components/signUpForm';
import LogoutButton from '@/components/logout';

export default function Login() {
       const { Title } = Typography;
       const carouselRef = useRef<CarouselRef>(null);
       const { user } = useUser();

       // * If user is logged in, return only the LogoutButton.
       // ! However, this should never happen since the login page is only accessible when the user is not logged in. (Must be handled by the middleware)
       if (user) {
              return (
                     <div className='flex flex-col items-center w-fit'>
                            <LogoutButton />
                     </div>
              );
       }

       // Menu items for login and sign-up
       const items: MenuProps['items'] = [
              {
                     label: <Title level={2}>Se connecter</Title>,
                     key: 'logIn',
              },
              {
                     label: <Title level={2}>{`S'inscrire`}</Title>,
                     key: 'signUp',
              },
       ];

       const onMenuClick: MenuProps['onClick'] = (e) => {
              if (carouselRef.current) {
                     // Change the carousel slide depending on the menu item clicked
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

       // Return the login and sign-up forms when the user is not logged in
       return (
              <div className='flex flex-col items-center w-fit'>
                     <Menu onClick={onMenuClick} defaultActiveFirst mode="horizontal" items={items} />
                     <Carousel
                            infinite={false}  // * https://github.com/ant-design/ant-design/issues/25289
                            ref={carouselRef}
                            dots={false}
                            style={{ width: 300 }}>
                            <LogInForm />
                            <SignUpForm />
                     </Carousel>
              </div>
       );
}
