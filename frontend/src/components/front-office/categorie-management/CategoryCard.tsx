import { Button, Card, Typography } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import { useState } from "react";
import axios from 'axios';
import Link from "next/link";
const { Paragraph } = Typography;

export default function CategoryCard({ category }: { category: Category }) {
       const [resources, setResources] = useState<any[]>([]);
       const [isLoading, setIsLoading] = useState<boolean>(false);

       return (
              <>
                     <Card
                            hoverable
                            style={{ borderColor: category.isActive ? category.color : undefined, minWidth: '300px', maxWidth: '300px' }}
                            className="m-2 !cursor-default h-fit"
                            actions={[
                                   <Link key="gotocat" href={`/category/${category.id}`}>
                                          <Button type="link" key={"ViewResources"}>
                                                 Voir les ressources liées
                                          </Button>
                                   </Link>

                            ]}
                     >
                            <div style={{ display: 'flex', alignItems: 'center' }}>
                                   <Icon icon={category.icon} style={{ fontSize: '24px', marginRight: '8px' }} />
                                   <span>{category.title}</span>
                            </div>
                            <Paragraph
                                   ellipsis={{ rows: 2, expandable: "collapsible", symbol: ((expanded: boolean) => expanded ? "Moins" : "Plus") }}>
                                   {category.description}
                            </Paragraph>
                     </Card>
              </>
       );
}
