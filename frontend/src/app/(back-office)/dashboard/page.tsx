"use client"
import { Card, Avatar, Typography, Button } from "antd"
const { Meta } = Card;
import { useUser } from "@/providers/userProvider";
const { Text } = Typography;
import Link from "next/link";
import ConnectionsChart from "@/components/testChart";
import {PlusCircleOutlined} from "@ant-design/icons";

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
                     <Card title="Statistiques de connexions (semaine actuelle)" extra={<Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue"}} />} />} className="w-1/2 min-w-96 max-w-[600px] h-auto">
                            <div style={{ width: '100%', aspectRatio: '16 / 9' }}> {/* Removed fixed height */}
                                   <ConnectionsChart></ConnectionsChart>
                            </div>
                     </Card>

              </div>
       )
}