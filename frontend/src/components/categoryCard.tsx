import { Card, Tooltip, Typography } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import Link from "next/link";
const { Text, Paragraph, Title } = Typography;

export default function CategoryCard({ category }: { category: Category }) {
       // Format dates for display
       // const formattedCreatedAt = moment(category.createdAt).format('MMM D, YYYY');
       // const formattedUpdatedAt = moment(category.updatedAt).format('MMM D, YYYY');
       // Prepare createdBy information, assuming a simple string is enough for this example

       return (
              <Link href={`/categories/${category.title}`}>
                     <Card
                            hoverable={category.isActive}
                            style={{ borderColor: category.color }}
                     >
                            <Card.Meta
                                   title={
                                          <div style={{ display: 'flex', alignItems: 'center' }}>
                                                 <Icon icon={category.icon} style={{ fontSize: '24px', marginRight: '8px' }} />
                                                 <span>{category.title}</span>
                                          </div>
                                   }
                                   description={
                                          <Paragraph
                                                 disabled={!category.isActive}
                                                 ellipsis={{ rows: 3, expandable: true, symbol: 'plus' }}>
                                                 {category.description}
                                          </Paragraph>}
                            />
                     </Card>
              </Link>
       );
}
