// login/page.tsx
"use client"

import LogInForm from '@/components/logInForm';
import SignUpForm from '@/components/signUpForm';

import { useRef } from 'react';
import { Carousel, Menu, Typography, type MenuProps } from 'antd';
import { CarouselRef } from 'antd/es/carousel';

export default function Login() {
       const { Title } = Typography;
       const carouselRef = useRef<CarouselRef>(null);

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
                     // change the carousel slide depending on the menu item clicked
                     // * 1: logIn, 2: signUp

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

       return (
              <div className='flex flex-col items-center w-fit'>
                     <Menu onClick={onMenuClick} defaultActiveFirst mode="horizontal" items={items} />
                            <Carousel
                            infinite={false} // * https://github.com/ant-design/ant-design/issues/25289
                            ref={carouselRef}
                            dots={false}
                            style={{ width: 300 }}>
                                   <LogInForm />
                                   <SignUpForm />
                            </Carousel>
              </div>
       )
}