import { Avatar, Button, Card, Typography } from "antd";
import Link from "next/link";
const { Meta } = Card;
import { useUser } from "@/providers/userProvider";
import { useState } from "react";
import { PlusCircleOutlined, UserOutlined } from "@ant-design/icons";
const { Text } = Typography;

export default function InformationUser() {
       const { user } = useUser();
       const [avatarError, setAvatarError] = useState(false); // État pour gérer l'erreur de chargement de l'avatar

       return (
              <div>
                     <Card
                            title="Informations du gestionnaire"
                            extra={<Link href="/profil"><Button type="text" aria-label='profil du gestionnaire' shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     >
                            <Meta
                                   avatar={user?.imgURL && !avatarError ? (
                                          <Avatar
                                                 alt="Avatar de l'utilisateur"
                                                 draggable={false}
                                                 size={40}
                                                 shape="square"
                                                 src={user.imgURL}
                                                 onError={() => {
                                                        setAvatarError(true);
                                                        return false;
                                                 }}
                                          />
                                   ) : (
                                          <Avatar
                                                 alt="Avatar par défault de l'utilisateur"
                                                 size={40}
                                                 shape="square"
                                                 draggable={false}
                                                 icon={<UserOutlined />}
                                          />
                                   )}
                                   title={`${user?.firstName} ${user?.lastName}`}
                                   description={<Text>{user?.role}</Text>}
                            />
                            <div className="mt-5 space-y-3 pr-7">
                                   <div className="flex flex-row gap-3">
                                          <Text type="secondary" className="whitespace-nowrap">Email</Text>
                                          <Typography.Link ellipsis copyable>{user?.email}</Typography.Link>
                                   </div>
                                   <div className="flex flex-row gap-3">
                                          <Text type="secondary" className="whitespace-nowrap">ID</Text>
                                          <Text ellipsis copyable>{user?.id}</Text>
                                   </div>
                            </div>
                     </Card>
              </div>
       )
}