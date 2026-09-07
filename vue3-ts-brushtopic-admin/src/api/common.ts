
export interface CommonResultType<T> {
  code: number | string;
  message: string;
  data: T;
}

export interface PageType {
  pageNum: number | null;
  pageSize: number | null;
}

export interface PageResultType<T> {
  total: number;
  rows: T[];
}