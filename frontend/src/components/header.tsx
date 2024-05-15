
import { Layout, Menu, Avatar, Spin, Tooltip } from "antd"
import { FileDoneOutlined, FolderOpenOutlined, StarOutlined, PlusCircleOutlined, UserOutlined, LogoutOutlined, DashboardOutlined, BookOutlined } from '@ant-design/icons';
import { useUser } from "@/providers/userProvider";
import { useState, useEffect } from "react";
import useLogout from "@/utils/logout";
import { usePathname } from "next/navigation";
import Link from "next/link";
const { Header: AntdHeader } = Layout;
import Image from 'next/image';
import logo from "/public/logo.png"

export default function Header({ collapsed, setCollapsed }: { collapsed: Boolean, setCollapsed: (collapsed: boolean) => void }) {
       const { user } = useUser();
       const [avatarSrc, setAvatarSrc] = useState<string | undefined | null>(user?.imgURL);
       const { logout, isLoading } = useLogout();
       const pathname = usePathname();
       const selectedKey = pathname.split('/')[1];

       useEffect(() => {
              setAvatarSrc(user?.imgURL);
       }, [user?.imgURL]);

       const handleImgError = () => {
              setAvatarSrc(undefined);
              return true; // Returning true tells the Avatar component not to retry loading the image
       };

       // Définir les éléments du menu en fonction du rôle de l'utilisateur
       const headerItems = [
              {
                     icon: <FolderOpenOutlined />,
                     label: <Link href={"/categories"}>{`Catégories`}</Link>,
                     style: { marginLeft: '30px' }, // TODO: When the menu is collapsed, we shouldnt have this margin
                     key: 'categories',
              },
              {
                     icon: <PlusCircleOutlined />,
                     label: <Link href={"/creer-ressource"}>{`Créer une ressource`}</Link>,
                     key: 'creer-ressource',
              },
              {
                     icon: <FileDoneOutlined />,
                     label: <Link href={"/mes-ressources"}>{`Mes ressources`}</Link>,
                     key: 'mes-ressources',
              },
              {
                     label: <Link href={"/mes-favoris"}>{`Mes favoris`}</Link>,
                     icon: <StarOutlined />,
                     key: 'mes-favoris',
              },
              {
                     label: <Link href={"/a-regarder-plus-tard"}>{`A regarder plus tard`}</Link>,
                     icon: <BookOutlined />,
                     key: 'a-regarder-plus-tard',
              },
              // Ajouter le tableau de bord uniquement si l'utilisateur est un modérateur ou plus
              ...(user && (user.role === "Moderateur" || user.role === "Administrateur" || user.role === "SuperAdministrateur") ? [
                     {
                            label: <Link href={"/tableau-de-bord"}>{`Tableau de bord`}</Link>,
                            icon: <DashboardOutlined />,
                            key: "tableau-de-bord",
                            style: { marginLeft: '15px' },
                     }
              ] : []),
              {
                     label: (<>
                            {avatarSrc ? (
                                   <Avatar
                                          draggable={false}
                                          alt="Avatar de l'utilisateur"
                                          size={40}
                                          shape="square"
                                          src={avatarSrc}
                                          onError={handleImgError}
                                   />
                            ) : (
                                   <Avatar
                                          size={40}
                                          alt="Avatar par défaut de l'utilisateur"
                                          shape="square"
                                          draggable={false}
                                          icon={<UserOutlined />}
                                   />
                            )}
                     </>),

                     key: 'User',
                     children: [
                            {

                                   label: <Link href={"/profil"}>{`Mon profil`}</Link>,
                                   key: 'profil',
                            },
                            {

                                   icon: (isLoading ? <Spin size="small" /> : <LogoutOutlined />),
                                   disabled: isLoading,
                                   danger: true,

                                   label: <span onClick={() => { if (!isLoading) logout() }}>Se déconnecter</span>,
                                   key: 'logout',
                            }
                     ]
              }
       ].filter(item => item.key !== "tableau-de-bord" || (user && (user.role === "Moderateur" || user.role === "Administrateur" || user.role === "SuperAdministrateur")));

       // Assuming headerItems structure remains consistent in order and content
       const mainItems = headerItems.filter(item => !['User', 'tableau-de-bord'].includes(item.key));
       const userItems = headerItems.filter(item => item.key === 'User');
       const dashboardItem = headerItems.find(item => item.key === 'tableau-de-bord');

       let dashboardItems = [];
       if (user && user.role && ["Moderateur", "Administrateur", "SuperAdministrateur"].includes(user.role)) {
              if (dashboardItem) { // Also check if dashboardItem is found
                     dashboardItems.push(dashboardItem);
              }
       }

       const items = [...dashboardItems, ...userItems]; // Merge dashboard items and user items

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
                     {collapsed && (
                            <Link href={"/"} style={
                                   {
                                          borderBottomWidth: 1,
                                          borderBottomStyle: 'solid',
                                          borderBottomColor: 'rgba(5, 5, 5, 0.06)',
                                   }
                            }
                                   className="w-fit h-full">
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
                            </Link>)}
                     <Menu
                            mode="horizontal"
                            items={mainItems} // Use mainItems for the main menu
                            theme="light"
                            selectedKeys={[selectedKey]}
                            className='flex-auto'
                            style={{ minWidth: 0, flex: "auto" }}
                     />

                     <Menu
                            mode="horizontal"
                            items={items} // Use items for the user and possibly dashboard
                            selectedKeys={[selectedKey]}
                            className="flex flex-row justify-end"
                            style={{ minWidth: 0, flex: "auto" }}
                            theme="light"
                     />
              </AntdHeader>
       );
}
