import { Typography } from "antd";
import { ReactNode } from "react";
const { Title, Paragraph } = Typography;

export default function PageSummary({ title, description } : { title: string, description: ReactNode }) {
       return (
              <div className="flex flex-col md:w-[500px] w-[200px]">
                     <Title level={2}>{title}</Title>
                     <Paragraph>{description}</Paragraph>
              </div>
       )
};