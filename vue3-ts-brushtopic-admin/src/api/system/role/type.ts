import type { PageType } from "@/api/common";

export interface RoleQueryType extends PageType {
  name: string;
}

export interface RoleType {
  name: string;
  identify: number | null;
  id: number | null;
  remark: string;
  roleKey: string;
}

export interface RoleDtoType extends RoleType {
  menuIds: number[] | null;
}