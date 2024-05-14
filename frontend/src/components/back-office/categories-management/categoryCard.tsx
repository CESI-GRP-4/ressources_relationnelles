import { Button, Card, Typography } from "antd";
import { Icon } from '@iconify/react';
import { Category } from "@/types/category";
import Link from "next/link";
import { useState } from "react";
import ModifyCategoryModal from "@/components/back-office/categories-management/modifyCategoryModal";
import { useWCAG } from '@/contexts/wcagContext';

const { Paragraph } = Typography;

export default function CategoryCard({ category, refreshCategories }: { category: Category, refreshCategories: Function }) {
       const [isModalVisible, setIsModalVisible] = useState(false);
       const showModal = () => setIsModalVisible(true);
       const { wcagEnabled } = useWCAG();

       return (
              <>
                     <Card
                            hoverable
                            style={{ borderColor: (category.isActive && !wcagEnabled) ? category.color : undefined, minWidth: '300px', maxWidth: '300px' }}

                            className="m-2 !cursor-default h-fit"
                            actions={[
                                   <Button key={"Modify"} type="link" onClick={showModal}>Modifier</Button> // This is the trigger
                            ]}
                     >
                            <Card.Meta
                                   title={
                                          category.isActive ? (
                                                 <Link href={`/categorie/${category.id}`} style={{ display: 'flex', alignItems: 'center' }} className="text-inherit hover:text-blue">
                                                        <Icon icon={category.icon} style={{ fontSize: '24px', marginRight: '8px' }} />
                                                        <span>{category.title}</span>
                                                 </Link>
                                          ) : (
                                                 <span style={{ display: 'flex', alignItems: 'center' }}>
                                                        <Icon icon={category.icon} style={{ fontSize: '24px', marginRight: '8px' }} />
                                                        <span>{category.title}</span>
                                                 </span>
                                          )
                                   }
                                   description={
                                          <Paragraph
                                                 ellipsis={{ rows: 2, expandable: "collapsible", symbol: ((expanded: boolean) => expanded ? "Moins" : "Plus") }}>
                                                 {category.description}
                                          </Paragraph>
                                   }
                            />
                     </Card >
                     <ModifyCategoryModal category={category} visible={isModalVisible} setVisible={setIsModalVisible} refreshCategories={refreshCategories} />
              </>
       );
}
