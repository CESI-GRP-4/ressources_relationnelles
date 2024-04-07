import User from "@/types/user";

export interface Category {
       id: number;
       title: string;
       description: string;
       icon: string; // icon from https://icon-sets.iconify.design/ exemple : ph:airplane
       color: string; // HEX
       isActive: boolean;
       createdBy: User; // Will probably never be used on the frontoffice because categories are created by the admin. But it can be useful for the backoffice.
       createdAt: string;
       updatedAt: string;
}