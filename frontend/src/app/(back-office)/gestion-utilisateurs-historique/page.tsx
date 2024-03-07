"use client"
import UserManagementHistoryTable from "@/components/back-office/user-management-history/usersManagementHistoryTable";
import { Typography } from "antd";
export default function GestionUtilisateursHistorique() {
       return (
              <div className="flex flex-col gap-5">
                     <Typography.Title level={2}>Historique des modifications</Typography.Title>
                     <Typography.Paragraph>Dans cette section, vous pouvez visualiser l'ensemble des modifications apportées aux utilisateurs.</Typography.Paragraph>
                     <UserManagementHistoryTable />
              </div>
       );
}