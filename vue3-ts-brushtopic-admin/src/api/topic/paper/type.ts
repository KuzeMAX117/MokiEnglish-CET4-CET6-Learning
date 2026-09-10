import type { PageType } from "@/api/common";

export interface PaperQueryType extends PageType {
  level: number | null;
  status: number | null;
  examYear: number | null;
  title: string;
}

/** 选项 */
export interface PaperOptionType {
  label: string;
  content: string;
}

/** 编辑器题目项 */
export interface PaperTopicItemType {
  topicId?: number | null;
  topicName: string;
  options: PaperOptionType[];
  correctOption: string;
  answer: string;
  analysis: string;
  article?: string;
  questionType?: string;
  /** 解析/校验警告（前端标色用，不提交） */
  warning?: string;
}

/** 编辑器子板块 */
export interface PaperSubSectionType {
  /** 仅解析结果携带：所属大板块（编辑器填写时按此分发） */
  section?: string;
  subSection: string;
  article: string;
  topics: PaperTopicItemType[];
}

/** 详情接口返回的板块（含 section 字段） */
export interface PaperManageSectionType {
  section: string;
  subSection: string;
  topics: PaperTopicItemType[];
}

/** 编辑器详情 */
export interface PaperDetailType {
  id: number;
  level: number;
  examYear: number;
  examHalf: number;
  title: string;
  totalScore: number;
  status: number;
  sections: PaperManageSectionType[];
}

/** 列表行 */
export interface PaperListItemType {
  id: number;
  level: number;
  examYear: number;
  examHalf: number;
  title: string;
  totalScore: number;
  status: number;
  createTime: string;
  topicCount: number;
  sectionCounts: Record<string, number>;
}

/** 分段保存请求体 */
export interface PaperSectionSaveType {
  paperId: number;
  section: string;
  subSections: PaperSubSectionType[];
}

/** 解析结果（text/docx 共用，subSections 可能跨多个大板块） */
export interface PaperParseResultType {
  subSections: PaperSubSectionType[];
  warnings: string[];
}
