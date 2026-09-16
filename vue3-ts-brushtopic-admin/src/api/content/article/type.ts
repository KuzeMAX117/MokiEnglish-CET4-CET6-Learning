import type { PageType } from "@/api/common";

export interface ArticleQueryType extends PageType {
  title: string | null;
  category: string | null;
  createBy: string | null;
  status: number | null;
}
