import { Category } from "@/types/category";
import Ressource from "@/types/ressource";
import { Card, Form, Select, Checkbox, Button, Input, message } from "antd";
import axios, { AxiosError } from "axios";
import { useEffect, useState } from "react";
const { Option } = Select;

export default function FilterRessources({ acceptedRessources, pendingRessources, rejectedRessources, blockedRessources, setFilteredRessources, hideIsPublicFilter, hideCategoryFilter }: {
       acceptedRessources?: Ressource[],
       pendingRessources?: Ressource[],
       rejectedRessources?: Ressource[],
       blockedRessources?: Ressource[],
       setFilteredRessources: (ressources: Ressource[][]) => void,
       hideCategoryFilter?: boolean,
       hideIsPublicFilter?: boolean


}) {
       const [form] = Form.useForm();
       const [categories, setCategories] = useState<Category[]>([]);
       const [filterActive, setFilterActive] = useState(false);

       interface FormValues {
              label?: string;
              description?: string;
              idCategory?: string;
              isPublic?: boolean;
       }

       useEffect(() => {
              fetchCategories();
              setFilteredRessources([
                     acceptedRessources ?? [],
                     pendingRessources ?? [],
                     rejectedRessources ?? [],
                     blockedRessources ?? []
              ]);
              // eslint-disable-next-line react-hooks/exhaustive-deps
       }, [acceptedRessources, pendingRessources, rejectedRessources, blockedRessources]);

       const applyFilter = () => {
              // Filter resources for each category based on matching any provided form value.
              const values = form.getFieldsValue();

              const filterResources = (resources: Ressource[]) => {
                     return resources.filter(resource => {
                            return (values.label && resource.label.includes(values.label)) ||
                                   (values.description && resource.description.includes(values.description)) ||
                                   (values.idCategory && resource.category.id === Number(values.idCategory)) || // Convert string to number
                                   (values.isPublic !== undefined && resource.isPublic == values.isPublic);
                     });
              };

              setFilteredRessources([
                     filterResources(acceptedRessources ?? []),
                     filterResources(pendingRessources ?? []),
                     filterResources(rejectedRessources ?? []),
                     filterResources(blockedRessources ?? [])
              ]);
              setFilterActive(true);
       };

       const resetFilter = () => {
              form.resetFields();
              setFilteredRessources([
                     acceptedRessources ?? [],
                     pendingRessources ?? [],
                     rejectedRessources ?? [],
                     blockedRessources ?? []
              ]);
              setFilterActive(false);
       };

       const fetchCategories = async () => {
              try {
                     const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération de la ressource");
                            }
                     } else {
                            message.error("Erreur lors de la mise à jour de la ressource");
                     }
              }
       };

       return (
              <Card title="Filtres" size="small" className="h-fit">
                     <Form
                            form={form}
                            layout='inline'
                            onValuesChange={() => {
                                   if (filterActive) applyFilter()
                            }
                            }
                     >
                            <div className="m-1">
                                   <Form.Item label="Titre" name="label" >
                                          <Input />
                                   </Form.Item>
                            </div>

                            <div className="m-1">
                                   <Form.Item label="Description" name="description">
                                          <Input.TextArea rows={1} />
                                   </Form.Item>
                            </div>

                            {hideCategoryFilter ? null : ( // Hide category filter if specified
                                   <div className="m-1">

                                          <Form.Item className="w-52" label="Catégorie" name="idCategory">
                                                 <Select
                                                        className="w-fit"
                                                        showSearch
                                                        optionFilterProp="label"
                                                        filterOption={(input, option) =>
                                                               (option?.label as string).toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                        }
                                                 >
                                                        {categories.map((category) => (
                                                               <Option key={category.id} value={category.id} label={category.title}>
                                                                      {category.title}
                                                               </Option>
                                                        ))}
                                                 </Select>
                                          </Form.Item>
                                   </div>

                            )}

                            {hideIsPublicFilter ? null : ( // Hide isPublic filter if specified
                                   <div className="m-1">

                                          <Form.Item label="Ressource publique" name="isPublic" valuePropName="checked">
                                                 <Checkbox />
                                          </Form.Item>
                                   </div>

                            )}
                            <div className="m-1">

                                   <Form.Item>
                                          {filterActive ? (
                                                 <Button onClick={resetFilter} >Réinitialiser les filtres</Button>
                                          ) : (
                                                 <Button onClick={applyFilter} type="primary">Appliquer les filtres</Button>
                                          )}
                                   </Form.Item>
                            </div>

                     </Form>
              </Card>
       );
}