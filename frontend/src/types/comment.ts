import User from "@/types/user";

export interface Comment {
       id: number;
       user: User;
       comment: string;
       createAt: string;
       children: Comment[];
       ressourceId?: number;
}