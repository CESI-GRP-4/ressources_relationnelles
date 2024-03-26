import { Layout, Menu, Avatar, Spin } from "antd"
import { FileDoneOutlined, FolderOpenOutlined, StarOutlined, PlusCircleOutlined, UserOutlined, LogoutOutlined, DashboardOutlined } from '@ant-design/icons';
import { useUser } from "@/providers/userProvider";
import { useState, useEffect } from "react";
import useLogout from "@/utils/logout";
import { usePathname } from "next/navigation";
import Link from "next/link";
const { Header: AntdHeader } = Layout;

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
                     key: 'create-resource',
              },
              {
                     icon: <FileDoneOutlined />,
                     label: <Link href={"/mes-ressources"}>{`Mes ressources`}</Link>,
                     key: 'my-resources',
              },
              {
                     label: <Link href={"/mes-favoris"}>{`Mes favoris`}</Link>,
                     icon: <StarOutlined />,
                     key: 'my-favorites',
              },
              // Ajouter le tableau de bord uniquement si l'utilisateur est un modérateur ou plus
              ...(user && (user.role === "Moderateur" || user.role === "Administrateur" || user.role === "SuperAdministrateur") ? [
                     {
                            label: <Link href={"/dashboard"}>{`Dashboard`}</Link>,
                            icon: <DashboardOutlined />,
                            key: "dashboard",
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
       ].filter(item => item.key !== "dashboard" || (user && (user.role === "Moderateur" || user.role === "Administrateur" || user.role === "SuperAdministrateur")));

       const items = user && (user.role === "Moderateur" || user.role === "Administrateur" || user.role === "SuperAdministrateur") ?
              [headerItems[headerItems.length - 2], headerItems[headerItems.length - 1]] :
              [headerItems[headerItems.length - 0], headerItems[headerItems.length - 1]];

       return (
              <AntdHeader className="site-layout-background" style={{
                     padding: 0,
                     position: 'sticky',
                     top: 0,
                     display: 'flex',
                     alignItems: 'center',
                     zIndex: 5,
              }}>
                     <Menu
                            mode="horizontal"
                            items={headerItems.slice(0, -2)} // Tous les éléments sauf les deux derniers
                            theme="light"
                            selectedKeys={[selectedKey]}
                            className='flex-auto'
                            style={{ minWidth: 0, flex: "auto" }}
                     />
                     <Menu
                            mode="horizontal"
                            items={items} // Les deux derniers éléments
                            selectedKeys={[selectedKey]}
                            className="flex flex-row justify-end"
                            style={{ minWidth: 0, flex: "auto" }}
                            theme="light"
                     />
              </AntdHeader>
       );
}
