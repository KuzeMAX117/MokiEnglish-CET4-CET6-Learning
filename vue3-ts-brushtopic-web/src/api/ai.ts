import request from '@/utils/request'
import type { ApiResult, TranslationCorrectPayload, TranslationCorrectionResult, EssayCorrectPayload, EssayCorrectionResult } from '@/types'

const prefix = '/ai/model/'

/** AI 翻译多维度智能批改 */
export const apiCorrectTranslation = (data: TranslationCorrectPayload) =>
  request.post<any, ApiResult<TranslationCorrectionResult>>(prefix + 'translate/correct', data)

/** AI 作文智能批改 */
export const apiCorrectEssay = (data: EssayCorrectPayload) =>
  request.post<any, ApiResult<EssayCorrectionResult>>(prefix + 'essay/correct', data)
