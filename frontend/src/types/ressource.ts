import User from "./user";
import { Category } from "./category";

export default interface Ressource {
       label: string;
       description: string;
       category: Category;
       isPublic: boolean;
       
       id: number;
       viewCount?: number;
       user?: User;
       creationDate?: Date;
       lastModificationDate?: Date;
       status?: "accepted" | "pending" | "rejected" | "blocked" | "disabled";
       // content: string;
       // comments: Comment[];
}