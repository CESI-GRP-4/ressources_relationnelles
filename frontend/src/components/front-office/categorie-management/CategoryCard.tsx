import { Button, Card, Typography } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import { useState } from "react";
import Link from "next/link";
const { Paragraph, Text } = Typography;
import { useWCAG } from '@/contexts/wcagContext';

export default function CategoryCard({ category }: { category: Category }) {
       const { wcagEnabled } = useWCAG();

       return (
              <>
                     <Card
                            hoverable
                            style={{ borderColor: (category.isActive && !wcagEnabled) ? category.color : undefined, minWidth: '300px', maxWidth: '300px' }}
                            className="m-2 !cursor-default h-fit"
                            actions={[
                                   <Link key="gotocat" href={`/categorie/${category.id}`}>
                                          <Button type="link" key={"ViewResources"}>
                                                 Voir les ressources liées
                                          </Button>
                                   </Link>

                            ]}
                     >
                            <div className="flex gap-5 flex-col">
                                   <div style={{ display: 'flex', alignItems: 'center' }}>
                                          <Icon icon={category.icon} style={{ fontSize: '24px', marginRight: '8px' }} />
                                          <Text strong>{category.title}</Text>
                                   </div>
                                   <Paragraph
                                          ellipsis={{ rows: 2, expandable: "collapsible", symbol: ((expanded: boolean) => expanded ? "Moins" : "Plus") }}>
                                          {category.description}
                                   </Paragraph>
                            </div>
                     </Card>
              </>
       );
}
