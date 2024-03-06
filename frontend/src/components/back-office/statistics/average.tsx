import { Card, Typography } from "antd";
const { Paragraph } = Typography;

export default function AverageDisplay({ average }) {
  return (
    <Card title="Statistique moyenne" bordered={false}>
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
