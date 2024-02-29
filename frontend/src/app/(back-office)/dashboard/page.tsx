"use client"
import { Card, Avatar, Typography } from "antd"
const { Meta } = Card;
import { useUser } from "@/providers/userProvider";
const { Text } = Typography;
import Link from "next/link";
import History from "@/components/back-office/user-management/history";
export default function AdminDashboard() {
       const { user } = useUser();

       return (
              <div className="flex-wrap flex gap-5">
                     <div>
                            <Card title="Informations du gestionnaire" extra={<Link href="/profile">Plus</Link>} style={{ width: 300 }}>
                                   <Meta
                                          avatar={<Avatar src={user?.imgURL} />}
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
                     
                     <div>
                            <History></History>
                     </div>
              </div>
       )
}