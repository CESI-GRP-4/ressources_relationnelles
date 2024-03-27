import { Typography } from "antd";
import { ReactNode } from "react";
const { Title, Paragraph } = Typography;

export default function PageSummary({ title, description } : { title: string, description: ReactNode }) {
       return (
              <div className="flex flex-col">
                     <Title level={2}>{title}</Title>
                     <Paragraph>{description}</Paragraph>
              </div>
       )
};