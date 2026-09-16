import type { PageType } from "@/api/common";

export interface TranslationQueryType extends PageType {
  title: string | null;
  category: string | null;
  difficulty: number | null;
  sourceLang: string | null;
  targetLang: string | null;
  createBy: string | null;
  status: number | null;
}
