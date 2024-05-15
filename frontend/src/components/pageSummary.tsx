import { Typography } from "antd";
import { ReactNode } from "react";
const { Title, Paragraph } = Typography;

export default function PageSummary({ title, description } : { title: ReactNode, description: ReactNode }) {
       return (
              <div className="flex flex-col md:min-w-96 min-w-32">
                     <Title level={2}>{title}</Title>
                     <Paragraph>{description}</Paragraph>
              </div>
       )
};