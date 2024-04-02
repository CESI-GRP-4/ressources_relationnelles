import { Card, Typography } from "antd";
const { Paragraph } = Typography;
import AverageConnection from "@/types/averageConnection";
export default function AverageDisplay({ average }: { average: AverageConnection }) {
  return (
    <Card title="Statistique moyenne" bordered={false} className='w-fit'>
      {average ? (
        <Paragraph>
          Le jour avec le plus de connexions en moyenne est le <strong>{average.day}</strong> avec <strong>{average.value}</strong> connexions.
        </Paragraph>
      ) : (
        <Paragraph>Aucune donnée disponible.</Paragraph>
      )}
    </Card>
  );
}
  