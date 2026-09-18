import type { PageType } from "@/api/common";

export interface EssayQueryType extends PageType {
  keyword?: string;
}

export interface EssayRecordType {
  id: number;
  userId: number;
  content: string;
  score: number;
  examType: string;
  aiResult: string;
  createTime: string;
}
