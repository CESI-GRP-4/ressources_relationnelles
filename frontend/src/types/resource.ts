export default interface Resource {
    id: number;
    label: string;
    description: string;
    content: string;
    view_count: bigint;
    id_category: number;
    id_user: number;
    creation_date: Date;
  }