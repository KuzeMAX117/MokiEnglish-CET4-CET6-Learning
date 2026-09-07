
export interface LoginType {
  username: string,
  password: string,
  code: string,
  remember: boolean
}

export interface UserResponse {
  account: string,
  avatar: string,
  identity: number | null,
  id: number | null,
  menuList: MenuType[],
  nickname: string | null,
}

export interface LoginResultType {
  token: string;
  code: number | string;
  message: string;
}

export interface MenuType {
  children?: MenuType[];
  key: string;
  icon: string;
  label: string;
}

