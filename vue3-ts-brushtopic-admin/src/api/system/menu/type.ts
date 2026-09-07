

export interface MenuQueryType {
  menuName: string;
}

export interface MenuType {
  menuName: string;
  icon: string;
  route: string;
  sorted: number | null;
  parentId: number;
  id: number | null;
}