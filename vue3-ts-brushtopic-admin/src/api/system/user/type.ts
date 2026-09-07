import type { PageType } from "@/api/common";

export interface UserQueryType extends PageType {
  account: string;
  roleName: string;
  params: any;
}