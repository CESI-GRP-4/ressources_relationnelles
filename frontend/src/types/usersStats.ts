export interface UserStats {
       totalUsers: number;
       usersByRole: {
              name: string;
              userCount: number;
       }[];
       bannedUsersCount: number;
       unverifiedEmailsCount: number;
}