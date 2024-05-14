import { Category } from "@/types/category";
import { Icon } from "@iconify/react/dist/iconify.js";
import { Select } from "antd";
import axios from "axios";
import { useState, useEffect } from "react";

interface OptionType {
       label: JSX.Element;
       value: number | null;
       description: string;
       icon: string;
}

interface SelectCategoryProps {
       disabled?: boolean;
       value?: number | null;
       onChange?: (value: number | null) => void;
}

export default function SelectCategory({ disabled, value, onChange }: SelectCategoryProps) {
       const [categories, setCategories] = useState<Category[]>([]);
       const [isLoading, setIsLoading] = useState<boolean>(false);

       const transformCategoriesToOptions = (categories: Category[]): OptionType[] => {
              return categories.map(category => ({
                     label: (
                            <div style={{ display: 'flex', alignItems: 'center' }}>
                                   <Icon icon={category.icon} style={{ marginRight: 8, fontSize: '1.2em' }} />
                                   {category.title}
                            </div>
                     ),
                     value: category.id,
                     description: category.description,
                     icon: category.icon
              }));
       };

       const options = transformCategoriesToOptions(categories);

       useEffect(() => {
              fetchCategories();
       }, []);

       const fetchCategories = async () => {
              setIsLoading(true);
              try {
                     const categoriesResponse = await axios.get(`${process.env.NEXT_PUBLIC_BACKEND_API_URL}/categories`);
                     setCategories(categoriesResponse.data.categories);
              } catch (error) {
                     console.error("Erreur lors de la récupération des catégories et des statuts:", error);
              } finally {
                     setIsLoading(false);
              }
       };

       return (
              <Select
                     showSearch
                     style={{ width: '100%' }}
                     placeholder="Sélectionnez une catégorie"
                     optionFilterProp="children"
                     filterOption={(input, option) =>
                            option ? option.description.toLowerCase().includes(input.toLowerCase()) : false
                     }
                     loading={isLoading}
                     options={options}
                     disabled={disabled}
                     value={value}
                     onChange={onChange}
                     allowClear
              />
       );
}
