import type { PageType } from "@/api/common";

export interface EssayQueryType extends PageType {
  title: string | null;
  category: string | null;
  difficulty: number | null;
  createBy: string | null;
  status: number | null;
}
