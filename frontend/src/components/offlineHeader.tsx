"use client"

import { Layout, Menu, Tooltip, Button } from "antd"
import { usePathname } from "next/navigation";
import Link from "next/link";
const { Header: AntdHeader } = Layout;
import Image from 'next/image';
import logo from "/public/logo.png"

export default function OfflineHeader() {
       const pathname = usePathname();
       const selectedKey = pathname.split('/')[1];

       // Définir les éléments du menu en fonction du rôle de l'utilisateur
       const headerItems = [
              {
                     label: <Link href={"/connexion"}><Button type="primary">{`Se connecter / S'inscrire`}</Button></Link>,
                     key: 'connexion',
              },
              // Ajouter le tableau de bord uniquement si l'utilisateur est un modérateur ou plus
       ];

       return (
              <AntdHeader style={{
                     padding: 0,
                     position: 'sticky',
                     top: 0,
                     display: 'flex',
                     alignItems: 'center',
                     justifyContent: 'space-between', // Utilisez cette propriété pour aligner les éléments à gauche et à droite
                     zIndex: 5,
                     background: 'white'
              }}>
                     <div style={
                            {
                                   borderBottomWidth: 1,
                                   borderBottomStyle: 'solid',
                                   borderBottomColor: 'rgba(5, 5, 5, 0.06)',
                            }
                     }
                            className="w-fit h-full flex flex-row items-center">
                            <Link href={'/'} className="flex flex-row items-center" >
                                   <Tooltip title="(Re)Sources Relationnelles - Ministère des solidarités et de la santé ">
                                          <Image
                                                 draggable={false}
                                                 className='rounded-none pl-8 py-2'
                                                 src={logo}
                                                 alt="Logo du ministère des solidarités et de la santé"
                                                 width={95}
                                                 height={110}
                                          />
                                   </Tooltip>
                                   <span className="ml-5 text-lg font-semibold text-gray-800 hover:text-blue-600 transition-colors duration-500">{`Bienvenue sur (Re)Sources Relationnelles`}</span>
                            </Link>
                     </div>
                     <Menu
                            mode="horizontal"
                            items={headerItems}
                            selectedKeys={[selectedKey]}
                            className="flex flex-row justify-end"
                            style={{ minWidth: 0, flex: "auto" }}
                            theme="light"
                     />
              </AntdHeader>
       );
}
