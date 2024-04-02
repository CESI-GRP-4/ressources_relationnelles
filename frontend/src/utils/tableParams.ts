export interface tableSettings {
       perPage: number;
       page: number;
       total?: number;
       lastPage?: number;
       sortBy?: string;
       sortDirection?: "asc" | "desc";
       searchColumn?: string;
       searchValue?: string;
}