"use client"
import EditableTable from "@/components/back-office/user-management/usersManagementTable";
import { Typography } from "antd";
import PageSummary from "@/components/back-office/pageSummary";
export default function GestionUtilisateurs() {
       return (
              <div className="flex flex-col">
                     <PageSummary
                            title="Gestion des utilisateurs"
                            description="Vous pouvez rechercher, filtrer et éditer les informations des utilisateurs directement. Vous pouvez ajuster les colonnes visibles, effectuer des modifications rapides et appliquer des actions spécifiques comme bannir ou supprimer des utilisateurs. Pour une utilisation sur mobile optimale, il est recommandé de ne plus rendre les colonnes fixes."/>
                     <div className="mt-5">
                            <EditableTable />
                     </div>
              </div>
       );
}