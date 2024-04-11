"use client"
import { useUser } from "@/providers/userProvider";
import { PlusCircleOutlined } from "@ant-design/icons";
import PageSummary from '@/components/pageSummary';
import InformationUser from "@/components/back-office/informationUser";
import UserManagementHistory from '@/components/back-office/user-management-history/usersManagementHistory';
import ConnectionPreviewCard from '@/components/back-office/statistics/connections/connectionPreviewCard';
import CategoriesPreview from '@/components/back-office/categories-management/categoriesPreview';
import UsersStatsPreviewCard from "@/components/back-office/statistics/users/usersStatsPreviewCard";
export default function AdminDashboard() {
       const { user } = useUser();

       return (
              <div className="flex flex-col">
                     <PageSummary title='Tableau de bord' description={<>
                            {"Bienvenue sur le tableau de bord d'administration. Vous pouvez visualiser un apercu de chaque fonctionnalité disponible. Pour plus de détails, veuillez naviguer vers les pages correspondantes en cliquant sur les boutons "}
                            <PlusCircleOutlined style={{ color: "blue" }} />
                            {" dans chaque carte."}
                     </>} />

                     <div className="flex-wrap flex mt-5 gap-5">
                            <InformationUser />
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <UserManagementHistory isPreview />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <UsersStatsPreviewCard />}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <CategoriesPreview></CategoriesPreview>}
                            {(user?.role === 'Administrateur' || user?.role === 'SuperAdministrateur') && <ConnectionPreviewCard />}
                     </div>
              </div>
       );
}
