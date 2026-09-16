import type { PageType } from "@/api/common";

export interface WordBookQueryType extends PageType {
  name: string | null;
  type: number | null;
}
