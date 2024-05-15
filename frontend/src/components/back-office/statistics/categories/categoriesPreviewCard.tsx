import { Button, Card } from "antd";
import Link from "next/link";
import CategoryDoughnutChart from "./categoriesChart";
import { PlusCircleOutlined } from "@ant-design/icons";

export default function CategoriesreviewCard() {
       return (
              <Card
                     title="Statistiques de catégories"
                     extra={<Link href="/statistiques/categories"><Button type="text" shape="circle" icon={<PlusCircleOutlined style={{ color: "blue" }} />} /></Link>}
                     className="w-1/2 min-w-96 max-w-[600px] h-auto">
                     <div style={{ width: '100%', aspectRatio: '16 / 9' }}>
                            <CategoryDoughnutChart isPreview></CategoryDoughnutChart>
                     </div>
              </Card>
       )
}