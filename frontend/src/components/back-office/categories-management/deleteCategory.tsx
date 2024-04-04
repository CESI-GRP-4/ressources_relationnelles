import { Category } from "@/types/category";
import { Button, Tooltip, Popconfirm, message } from "antd";
import axios,{AxiosError} from "axios";
export default function DeleteCategory({category, refreshCategories} : {category: Category, refreshCategories: Function}){
       const deleteCategory = async () => {
              try {
                     const response = await axios({
                            method: 'DELETE',
                            baseURL: process.env.NEXT_PUBLIC_BACKEND_API_URL,
                            url: '/deleteCategory/' + category.id,
                            responseType: 'json',
                            timeout: 10000,
                            withCredentials: true,
                     });
                     if (response.status === 200) {
                            message.success("Catégorie supprimée avec succès")
                            console.log(response.data)
                            refreshCategories();
                     }
              } catch (error) {
                     console.error(error);
                     const axiosError = error as AxiosError

                     if (axiosError.response) {
                            switch (axiosError.response.status) {
                                   case 403:
                                          message.error("Vous n'êtes pas autorisé à supprimer cette catégorie")
                                          break;
                                   case 404:
                                          message.error("Catégorie introuvable")
                                          break;
                                   default:
                                          message.error("Erreur lors de la suppression de la catégorie")
                            }
                     } else {
                            message.error("Erreur lors de la suppression de la catégorie")
                     }
              }
       }
       
       return (
              <Popconfirm
                     title="Êtes-vous sûr de vouloir supprimer cette catégorie?"
                     onConfirm={deleteCategory}
                     okText="Oui"
                     cancelText="Non"
              >
                     <Tooltip title="Supprimer">
                            <Button type="primary" danger>Supprimer</Button>
                     </Tooltip>
              </Popconfirm>
       )

}