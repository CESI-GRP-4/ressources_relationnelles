import { Button, Card } from "antd";
import Link from "next/link";
import ConnectionsChart from "@/components/back-office/statistics/connections/connectionChart";
import { PlusCircleOutlined } from "@ant-design/icons";

export default function ConnectionPreviewCard() {
       return (
              <Card
                     title="Statistiques de connexions (semaine actuelle)"
                     extra={<Link href="/statistiques/connexions"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     className="w-1/2 min-w-96 max-w-[600px] h-auto">

                     <div style={{ width: '100%', aspectRatio: '16 / 9' }}>
                            <ConnectionsChart isPreview></ConnectionsChart>
                     </div>
              </Card>
       )
}