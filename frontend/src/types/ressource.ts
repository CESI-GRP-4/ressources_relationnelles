import User from "./user";
import { Category } from "./category";
import { Comment } from "./comment";
export default interface Ressource {
       label: string;
       description: string;
       category: Category;
       isPublic: boolean;
       comments: Comment[];
       id: number;
       viewCount?: number;
       user?: User;
       creationDate?: Date;
       lastModificationDate?: Date;
       status: "accepted" | "pending" | "rejected" | "blocked" | "disabled";
       staffComment: string;
       // content: string;
       // comments: Comment[];
       isFavorite?: boolean;
       isBookmark?: boolean;
}