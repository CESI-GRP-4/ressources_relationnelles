import { Button, Card } from "antd";
import Link from "next/link";
import RessourceChart from "@/components/back-office/statistics/ressources/ressourcesChart";
import { PlusCircleOutlined } from "@ant-design/icons";

export default function RessourcePreviewCard() {
       return (
              <Card
                     title="Statistiques de ressource (10 plus consultées)"
                     extra={<Link href="/statistiques/ressources"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     className="w-1/2 min-w-96 max-w-[600px] h-auto">

                     <div style={{ width: '100%', aspectRatio: '16 / 9' }}>
                            <RessourceChart isPreview></RessourceChart>
                     </div>
              </Card>
       )
}