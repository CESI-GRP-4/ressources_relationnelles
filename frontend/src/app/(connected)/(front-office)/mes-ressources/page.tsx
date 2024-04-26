"use client"
import { Card, Input, Tabs, message, Checkbox, Form, Button, Select } from 'antd';
import type { TabsProps } from 'antd';
import { useState, useEffect } from 'react';
import Ressource from '@/types/ressource';
import PageSummary from '@/components/pageSummary';
import axios, { AxiosError, AxiosResponse } from 'axios';
import ListOfRessourcesAccordion from '@/components/front-office/ressource-management/listOfRessourcesAccordion';
import { Category } from '@/types/category';
const { Option } = Select;

export default function MyRessources() {
       const [acceptedRessources, setAcceptedRessources] = useState<Ressource[]>([]);
       const [pendingRessources, setPendingRessources] = useState<Ressource[]>([]);
       const [rejectedRessources, setRejectedRessources] = useState<Ressource[]>([]);
       const [blockedRessources, setBlockedRessources] = useState<Ressource[]>([]);

       const [filteredRessources, setFilteredRessources] = useState<Ressource[][]>([[], [], [], []]);

       const [loading, setLoading] = useState(true);
       const [form] = Form.useForm();
       const [categories, setCategories] = useState<Category[]>([]);
       const [filterActive, setFilterActive] = useState(false);

       useEffect(() => {
              fetchPendingRessources();
              fetchCategories();
       }, []);

       const applyFilter = (values: FormValues) => {
              // Filter resources for each category based on matching any provided form value.
              console.log(values.isPublic)
              console.log(acceptedRessources)
              const filterResources = (resources: Ressource[]) => {
                     return resources.filter(resource => {
                            return (values.label && resource.label.includes(values.label)) ||
                                   (values.description && resource.description.includes(values.description)) ||
                                   (values.idCategory && resource.category.id === Number(values.idCategory)) || // Convert string to number
                                   (values.isPublic !== undefined && resource.isPublic == values.isPublic);
                     });
              };

              setFilteredRessources([
                     filterResources(acceptedRessources),
                     filterResources(pendingRessources),
                     filterResources(rejectedRessources),
                     filterResources(blockedRessources)
              ]);
              setFilterActive(true);
       };


       const resetFilter = () => {
              form.resetFields();
              setFilteredRessources([acceptedRessources, pendingRessources, rejectedRessources, blockedRessources]);
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

       const fetchPendingRessources = async () => {
              try {
                     setLoading(true);
                     const response: AxiosResponse<{ ressources: Ressource[] }> = await axios(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/myRessources`, {
                            method: "GET",
                            withCredentials: true
                     });
                     const fetchedRessources = response.data.ressources;

                     // Initialize temporary arrays to store sorted resources
                     const tempAccepted: Ressource[] = [];
                     const tempPending: Ressource[] = [];
                     const tempRejected: Ressource[] = [];
                     const tempBlocked: Ressource[] = [];

                     fetchedRessources.forEach((ressource) => {
                            switch (ressource.status) {
                                   case 'accepted':
                                          tempAccepted.push(ressource);
                                          break;
                                   case 'pending':
                                          tempPending.push(ressource);
                                          break;
                                   case 'rejected':
                                          tempRejected.push(ressource);
                                          break;
                                   case 'blocked':
                                          tempBlocked.push(ressource);
                                          break;
                                   // No case for 'disabled' as it's not clear where they should go, or if they should be ignored
                            }
                     });

                     // Update state for each category
                     setAcceptedRessources(tempAccepted);
                     setPendingRessources(tempPending);
                     setRejectedRessources(tempRejected);
                     setBlockedRessources(tempBlocked);
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError;

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                   case 401:
                                          message.error("Vous n'êtes pas autorisé");
                                          break;
                                   default:
                                          message.error("Erreur lors de la récupération des ressources");
                            }
                     } else {
                            message.error("Erreur lors de la récupération des ressources");
                     }
              } finally {
                     setLoading(false);
              }
       };

       interface FormValues {
              label?: string;
              description?: string;
              idCategory?: string;
              isPublic?: boolean;
       }

       const items: TabsProps['items'] = [
              {
                     key: 'acceptedRessources',
                     label: 'Ressources acceptées',
                     children: <ListOfRessourcesAccordion ressources={filterActive ? filteredRessources[0] : acceptedRessources} refreshRessources={fetchPendingRessources} />,
              },
              {
                     key: 'pendingRessources',
                     label: 'Ressources en attente',
                     children: <ListOfRessourcesAccordion ressources={filterActive ? filteredRessources[1] : pendingRessources} refreshRessources={fetchPendingRessources} />,
              },
              {
                     key: 'rejectedRessources',
                     label: 'Ressources refusées',
                     children: <ListOfRessourcesAccordion ressources={filterActive ? filteredRessources[2] : rejectedRessources} refreshRessources={fetchPendingRessources} />,
              },
              {
                     key: 'blockedRessources',
                     label: 'Ressources bloquées',
                     children: <ListOfRessourcesAccordion ressources={filterActive ? filteredRessources[3] : blockedRessources} refreshRessources={fetchPendingRessources} />,
              },
       ];

       return (
              <div>
                     <PageSummary title={'Mes ressources'} description={undefined}></PageSummary>
                     <div className="flex flex-row justify-center gap-3">
                            <Tabs className='w-full' defaultActiveKey="1" items={items} />
                            <Card title="Filtres">
                                   <Form
                                          onValuesChange={(_, allValues) => {
                                                 if (Object.values(allValues).some(value => value !== undefined)) {
                                                        applyFilter(allValues);
                                                 }
                                          }}
                                          form={form}
                                          name="filterRessourceListForm"
                                          autoComplete="off"
                                          layout='vertical'
                                   >
                                          <Form.Item label="Titre" name="label">
                                                 <Input />
                                          </Form.Item>

                                          <Form.Item label="Description" name="description">
                                                 <Input.TextArea />
                                          </Form.Item>

                                          <Form.Item
                                                 label="Catégorie"
                                                 name="idCategory"
                                          >
                                                 <Select
                                                        showSearch
                                                        optionFilterProp="label"
                                                        filterOption={(input, option) =>
                                                               (option?.label as string).toLowerCase().indexOf(input.toLowerCase()) >= 0
                                                        }
                                                 >
                                                        {(categories).map((category) => (
                                                               <Option key={category.id} value={category.id} label={category.title}>
                                                                      {category.title}
                                                               </Option>
                                                        ))}
                                                 </Select>
                                          </Form.Item>

                                          <Form.Item
                                                 label="Ressource publique"
                                                 name="isPublic"
                                                 valuePropName="checked" // Pour gérer la valeur cochée
                                                 initialValue={false} // Valeur par défaut cochée
                                          >
                                                 <Checkbox />
                                          </Form.Item>

                                          <Form.Item
                                          >
                                                 {filterActive ? (
                                                        <Button
                                                               className='mt-10'
                                                               onClick={() => {
                                                                      form.resetFields();
                                                                      setFilterActive(false);
                                                                      setFilteredRessources([acceptedRessources, pendingRessources, rejectedRessources, blockedRessources]);
                                                               }}
                                                               type="primary" htmlType="button">Réinitialiser les filtres</Button>
                                                 ) : (
                                                        <Button
                                                               className='mt-10'

                                                               onClick={() => {
                                                                      form.submit(); // Make sure to submit the form, triggering the onValuesChange
                                                                      setFilterActive(true);
                                                               }}
                                                               type="primary" htmlType="submit">Appliquer les filtres</Button>


                                                 )}
                                          </Form.Item>
                                   </Form>
                            </Card>
                     </div>
              </div>
       );
}