"use client"
import { useUser } from "@/providers/userProvider";
import { PlusCircleOutlined } from "@ant-design/icons";
import PageSummary from '@/components/pageSummary';
import InformationUser from "@/components/back-office/informationUser";
import UserManagementHistory from '@/components/back-office/user-management-history/usersManagementHistory';
import ConnectionPreviewCard from '@/components/back-office/statistics/connections/connectionPreviewCard';
import CategoriesPreview from '@/components/back-office/categories-management/categoriesPreview';
import UsersStatsPreviewCard from "@/components/back-office/statistics/users/usersStatsPreviewCard";
import RessourceStatsPreviewCard from "@/components/back-office/statistics/ressources/ressourcesStatsPreviewCard";
import CommentsStatsPreviewCard from "@/components/back-office/statistics/comments/commentsStatsPreviewCard";
import RessourcePreviewCard from "@/components/back-office/statistics/connections/ressourcePreviewCard";
import CategoriesreviewCard from "@/components/back-office/statistics/categories/categoriesPreviewCard";
export default function AdminDashboard() {
       const { user } = useUser();

       return (
              <div className="flex flex-col">
                     <PageSummary title='Tableau de bord' description={<>
                            {`Bienvenue sur le tableau de bord d'administration de notre plateforme. Cette interface centrale vous permet de superviser et de gérer efficacement tous les aspects de la plateforme. Ici, vous pouvez accéder à des outils de gestion des ressources, des comptes utilisateurs, et des catégories, ainsi que visualiser les statistiques d'utilisation pour prendre des décisions éclairées. Utilisez ce tableau de bord pour assurer le bon fonctionnement de la plateforme, en mettant à jour ou en modifiant les contenus, et en répondant aux besoins des utilisateurs pour maintenir une communauté dynamique et engagée. Chacun des apercu disponible vous permet de d'avoir un récapitulatif de l'état de la plateforme, vous pouvez cliquer sur les boutons `}
                            <PlusCircleOutlined style={{ color: "blue" }} />
                            {" dans chaque carte pour accéder à toutes les fonctionnalités."}
                     </>} />

                     <div className="flex-wrap flex mt-5 gap-5">
                            <InformationUser />
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <UserManagementHistory isPreview />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <UsersStatsPreviewCard />}
                            {(user?.role && user?.role !== "Utilisateur") && <RessourceStatsPreviewCard />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <CategoriesPreview></CategoriesPreview>}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <ConnectionPreviewCard />}
                            {(user?.role && user?.role !== "Utilisateur") && <CommentsStatsPreviewCard />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <RessourcePreviewCard />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <CategoriesreviewCard />}



                     </div>
              </div>
       );
}
