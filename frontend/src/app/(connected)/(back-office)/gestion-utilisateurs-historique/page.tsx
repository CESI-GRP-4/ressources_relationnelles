"use client"
import UserManagementHistory from "@/components/back-office/user-management-history/usersManagementHistory";
import PageSummary from "@/components/pageSummary";
export default function GestionUtilisateursHistorique() {
       return (
              <div className="flex flex-col gap-5">
                     <PageSummary
                            title="Historique des modifications"
                            description="Dans cette section, vous pouvez visualiser l'ensemble des modifications apportées aux utilisateurs."/>
                     <UserManagementHistory />
              </div>
       );
}