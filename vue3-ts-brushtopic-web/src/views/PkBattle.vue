<template>
  <div class="pk-battle-page">
    <!-- Pre-match Phase (3 rounds) -->
    <div v-if="phase === 'prematch'" class="prematch-phase">
      <div class="round-header">
        <div class="round-info">
          <span class="round-badge">第 {{ currentRound }} / {{ totalRounds }} 轮</span>
          <span class="round-status">{{ roundStatus }}</span>
        </div>
        <div class="round-progress">
          <span v-for="i in totalRounds" :key="i" class="round-dot" 
            :class="{ active: i === currentRound, done: i < currentRound }"></span>
        </div>
      </div>

      <div class="battle-header">
        <div class="player player-a">
          <div class="player-avatar">
            <a-avatar :size="48" style="background: linear-gradient(135deg, #4257B2, #364899)">
              {{ (myInfo.nickname || '我').charAt(0) }}
            </a-avatar>
          </div>
          <div class="player-name">{{ myInfo.nickname || '我' }}</div>
          <div class="player-score">{{ scoreA }}</div>
        </div>

        <div class="vs-badge">VS</div>

        <div class="player player-b">
          <div class="player-avatar">
            <a-avatar :size="48" style="background: linear-gradient(135deg, #ff6b6b, #ee5a24)">
              {{ (opponentInfo.nickname || '对手').charAt(0) }}
            </a-avatar>
          </div>
          <div class="player-name">{{ opponentInfo.nickname || '对手' }}</div>
          <div class="player-score">{{ scoreB }}</div>
        </div>
      </div>

      <div class="progress-bar">
        <div class="progress-fill" :style="{ width: progressPercent + '%' }"></div>
        <div class="progress-text">第 {{ currentQuestion + 1 }} / {{ totalCount }} 题</div>
      </div>

      <div class="question-card">
        <div class="question-word">{{ currentWord }}</div>
        <div class="question-options">
          <div
            v-for="(option, index) in currentOptions"
            :key="index"
            class="option-item"
            :class="{
              selected: selectedAnswer === option.label,
              correct: showResult && option.label === correctOption,
              wrong: showResult && selectedAnswer === option.label && option.label !== correctOption
            }"
            @click="selectAnswer(option.label)"
          >
            <span class="option-label">{{ option.label }}</span>
            <span class="option-content">{{ option.content }}</span>
          </div>
        </div>
        <div class="timer">倒计时: {{ timer }}s</div>
      </div>
    </div>

    <!-- Round Complete -->
    <div v-else-if="phase === 'round-complete'" class="round-complete">
      <div class="round-result">
        <div class="round-icon">{{ roundWin ? '🎉' : roundDraw ? '🤝' : '😢' }}</div>
        <h2>{{ roundResultText }}</h2>
        <div class="round-score">
          <span class="my-score">{{ scoreA }}</span>
          <span class="vs">:</span>
          <span class="opponent-score">{{ scoreB }}</span>
        </div>
        <div class="round-stats">
          <div class="stat-item">
            <span class="stat-label">本轮正确</span>
            <span class="stat-value">{{ roundCorrect }}/{{ totalCount }}</span>
          </div>
          <div class="stat-item">
            <span class="stat-label">累计胜场</span>
            <span class="stat-value">{{ totalWins }}/{{ currentRound }}</span>
          </div>
        </div>
        <div v-if="currentRound < totalRounds" class="next-round">
          <p>下一轮即将开始...</p>
          <a-button type="primary" size="large" @click="startNextRound">开始第 {{ currentRound + 1 }} 轮</a-button>
        </div>
      </div>
    </div>

    <!-- Level Determination Complete -->
    <div v-else-if="phase === 'level-complete'" class="level-complete">
      <div class="level-reveal">
        <div class="level-icon">🎯</div>
        <h2>定级完成！</h2>
        <div class="level-badge">{{ levelName }}</div>
        <p>根据3轮PK表现，你的词汇等级已确定</p>
        <div class="level-detail">
          <div class="level-item">
            <span class="level-label">总胜场</span>
            <span class="level-value">{{ totalWins }}/{{ totalRounds }}</span>
          </div>
          <div class="level-item">
            <span class="level-label">正确率</span>
            <span class="level-value">{{ totalCorrectRate }}%</span>
          </div>
          <div class="level-item">
            <span class="level-label">等级</span>
            <span class="level-value">{{ levelName }}</span>
          </div>
        </div>
        <div class="level-actions">
          <a-button type="primary" size="large" @click="router.push('/pk')">开始正式PK</a-button>
          <a-button size="large" @click="router.push('/home')">返回首页</a-button>
        </div>
      </div>
    </div>

    <!-- Waiting Phase -->
    <div v-else class="waiting-phase">
      <div class="spinner"></div>
      <h3>等待对手...</h3>
      <p>正在匹配对手，请稍候</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { message } from 'ant-design-vue'
import { usePkWebSocket } from '@/utils/pkWebsocket'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const { connect, disconnect, sendMessage, onMessage } = usePkWebSocket()

const phase = ref<'waiting' | 'prematch' | 'round-complete' | 'level-complete'>('waiting')
const roomId = ref(route.query.roomId as string)

const totalRounds = ref(3)
const currentRound = ref(1)
const roundStatus = ref('进行中')

const questions = ref<any[]>([])
const currentQuestion = ref(0)
const totalCount = ref(15)
const scoreA = ref(0)
const scoreB = ref(0)
const selectedAnswer = ref('')
const showResult = ref(false)
const correctOption = ref('')
const pkFinished = ref(false)
const timer = ref(15)
let timerInterval: ReturnType<typeof setInterval> | null = null

const roundCorrect = ref(0)
const totalWins = ref(0)
const totalCorrect = ref(0)
const totalQuestions = ref(0)

const levelName = ref('Lv1 初学者')

const myInfo = ref({ nickname: userStore.nickname || '我', avatar: '' })
const opponentInfo = ref({ nickname: '对手', avatar: '' })

const myScore = computed(() => scoreA.value)
const opponentScore = computed(() => scoreB.value)

const isUserA = ref(true)

const progressPercent = computed(() => {
  return (currentQuestion.value / totalCount.value) * 100
})

const currentWord = computed(() => {
  return questions.value[currentQuestion.value]?.word || ''
})

const currentOptions = computed(() => {
  if (questions.value[currentQuestion.value]) {
    try {
      return JSON.parse(questions.value[currentQuestion.value].options || '[]')
    } catch {
      return []
    }
  }
  return []
})

const roundWin = computed(() => scoreA.value > scoreB.value)
const roundDraw = computed(() => scoreA.value === scoreB.value)

const roundResultText = computed(() => {
  if (roundWin.value) return '本轮获胜！'
  if (roundDraw.value) return '本轮平局'
  return '本轮惜败'
})

const totalCorrectRate = computed(() => {
  return totalQuestions.value > 0 ? Math.round(totalCorrect.value * 100 / totalQuestions.value) : 0
})

onMounted(() => {
  connect(roomId.value)

  const stopWatch = onMessage((msg) => {
    if (msg.type === 'MATCH_SUCCESS') {
      totalCount.value = msg.totalCount || 15
      totalRounds.value = msg.warmupCount || 3
      isUserA.value = userStore.userInfo?.id === msg.userA
      
      if (!isUserA.value) {
        opponentInfo.value = { nickname: myInfo.value.nickname, avatar: myInfo.value.avatar }
        myInfo.value = { nickname: '对手', avatar: '' }
      }
    } else if (msg.type === 'BATTLE_QUESTIONS') {
      questions.value = msg.questions || []
      currentQuestion.value = 0
      scoreA.value = 0
      scoreB.value = 0
      roundCorrect.value = 0
      pkFinished.value = false
      phase.value = 'prematch'
      startTimer()
    } else if (msg.type === 'SCORE_UPDATE') {
      scoreA.value = parseInt(msg.scoreA) || 0
      scoreB.value = parseInt(msg.scoreB) || 0
      currentQuestion.value = parseInt(msg.currentQuestion) || 0
      showResult.value = true
      correctOption.value = msg.correctOption || ''
      
      if (msg.correct) {
        roundCorrect.value++
      }
      
      setTimeout(() => {
        showResult.value = false
        selectedAnswer.value = ''
        if (currentQuestion.value < totalCount.value) {
          startTimer()
        }
      }, 1500)
    } else if (msg.type === 'ROUND_END') {
      pkFinished.value = true
      scoreA.value = parseInt(msg.scoreA) || 0
      scoreB.value = parseInt(msg.scoreB) || 0
      
      totalCorrect.value += roundCorrect.value
      totalQuestions.value += totalCount.value
      
      if (msg.winner === 'A') {
        totalWins.value++
      }
      
      if (timerInterval) clearInterval(timerInterval)
      
      setTimeout(() => {
        phase.value = 'round-complete'
      }, 1500)
    } else if (msg.type === 'LEVEL_DETERMINED') {
      levelName.value = msg.levelName || 'Lv1 初学者'
      phase.value = 'level-complete'
    }
  })
})

onUnmounted(() => {
  disconnect()
  if (timerInterval) clearInterval(timerInterval)
})

const startTimer = () => {
  timer.value = 15
  if (timerInterval) clearInterval(timerInterval)
  timerInterval = setInterval(() => {
    timer.value--
    if (timer.value <= 0) {
      if (timerInterval) clearInterval(timerInterval)
      submitAnswer('')
    }
  }, 1000)
}

const selectAnswer = (label: string) => {
  if (showResult.value || pkFinished.value) return
  submitAnswer(label)
}

const submitAnswer = async (answer: string) => {
  if (timerInterval) clearInterval(timerInterval)
  selectedAnswer.value = answer

  try {
    await sendMessage({
      type: 'SUBMIT_ANSWER',
      roomId: roomId.value,
      questionIndex: currentQuestion.value,
      answer: answer,
    })
  } catch (e: any) {
    message.error(e.message || '提交失败')
  }
}

const startNextRound = async () => {
  currentRound.value++
  roundStatus.value = '进行中'
  
  try {
    await sendMessage({
      type: 'START_ROUND',
      roomId: roomId.value,
      round: currentRound.value,
    })
  } catch (e: any) {
    message.error(e.message || '开始下一轮失败')
  }
}
</script>

<style scoped lang="scss">
.pk-battle-page {
  display: flex;
  flex-direction: column;
  gap: 24px;
  max-width: 600px;
  margin: 0 auto;
}

.prematch-phase, .round-complete, .level-complete, .waiting-phase {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.round-header {
  text-align: center;
  padding: 20px;
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  box-shadow: var(--shadow-card);

  .round-info {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
  }

  .round-badge {
    padding: 6px 16px;
    border-radius: var(--radius-md);
    background: var(--primary);
    color: #fff;
    font-size: calc(14px + var(--font-offset, 0px));
    font-weight: 600;
  }

  .round-status {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
  }
}

.round-progress {
  display: flex;
  justify-content: center;
  gap: 8px;
}

.round-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--border);
  transition: all 0.3s;

  &.active {
    background: var(--primary);
  }

  &.done {
    background: var(--success);
  }
}

.battle-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 20px;
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  box-shadow: var(--shadow-card);

  .player {
    text-align: center;
    flex: 1;

    .player-avatar {
      margin-bottom: 8px;
    }

    .player-name {
      font-size: calc(14px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      margin-bottom: 4px;
    }

    .player-score {
      font-size: calc(28px + var(--font-offset, 0px));
      font-weight: 800;
      color: var(--primary);
    }
  }

  .vs-badge {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background: linear-gradient(135deg, #ff6b6b, #ee5a24);
    color: #fff;
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 800;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
}

.progress-bar {
  height: 32px;
  border-radius: 16px;
  background: var(--border);
  position: relative;
  overflow: hidden;

  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, var(--primary), var(--primary-hover));
    border-radius: 16px;
    transition: width 0.3s ease;
  }

  .progress-text {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: calc(13px + var(--font-offset, 0px));
    font-weight: 600;
    color: var(--text-title);
  }
}

.question-card {
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  padding: 32px;
  box-shadow: var(--shadow-card);

  .question-word {
    text-align: center;
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    margin-bottom: 24px;
  }

  .question-options {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .option-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px 20px;
    border-radius: var(--radius-md);
    border: 2px solid var(--border);
    cursor: pointer;
    transition: all 0.2s;

    &:hover:not(.selected):not(.correct):not(.wrong) {
      border-color: var(--primary);
      background: var(--primary-light);
    }

    &.selected {
      border-color: var(--primary);
      background: var(--primary-light);
    }

    &.correct {
      border-color: var(--success);
      background: rgba(40, 167, 69, 0.1);
    }

    &.wrong {
      border-color: #ff4d4f;
      background: rgba(255, 77, 79, 0.1);
    }

    .option-label {
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: var(--border);
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      flex-shrink: 0;
    }

    .option-content {
      font-size: calc(15px + var(--font-offset, 0px));
      color: var(--text-title);
    }
  }

  .timer {
    text-align: center;
    margin-top: 20px;
    font-size: calc(16px + var(--font-offset, 0px));
    color: var(--text-muted);
    font-weight: 600;
  }
}

.round-complete {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
}

.round-result {
  text-align: center;
  padding: 48px;
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  box-shadow: var(--shadow-card);
  animation: fadeIn 0.5s ease;

  .round-icon {
    font-size: 64px;
    margin-bottom: 16px;
  }

  h2 {
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    margin: 0 0 16px;
  }

  .round-score {
    font-size: calc(48px + var(--font-offset, 0px));
    font-weight: 800;
    margin-bottom: 24px;

    .my-score { color: var(--primary); }
    .vs { color: var(--text-muted); margin: 0 12px; }
    .opponent-score { color: var(--text-muted); }
  }
}

.round-stats {
  display: flex;
  justify-content: center;
  gap: 32px;
  margin-bottom: 24px;
}

.stat-item {
  text-align: center;

  .stat-label {
    display: block;
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-bottom: 4px;
  }

  .stat-value {
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--primary);
  }
}

.next-round {
  p {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin: 0 0 16px;
  }
}

.level-complete {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
}

.level-reveal {
  text-align: center;
  padding: 48px;
  border-radius: var(--radius-lg);
  background: var(--page-bg);
  border: 1px solid var(--border);
  box-shadow: var(--shadow-card);
  animation: fadeIn 0.5s ease;

  .level-icon {
    font-size: 64px;
    margin-bottom: 16px;
  }

  h2 {
    font-size: calc(28px + var(--font-offset, 0px));
    font-weight: 800;
    color: var(--text-title);
    margin: 0 0 16px;
  }

  .level-badge {
    display: inline-block;
    padding: 12px 32px;
    border-radius: var(--radius-md);
    background: linear-gradient(135deg, var(--primary), var(--primary-hover));
    color: #fff;
    font-size: calc(20px + var(--font-offset, 0px));
    font-weight: 700;
    margin-bottom: 16px;
  }

  p {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin: 0 0 24px;
  }
}

.level-detail {
  display: flex;
  justify-content: center;
  gap: 32px;
  margin-bottom: 32px;
}

.level-item {
  text-align: center;

  .level-label {
    display: block;
    font-size: calc(12px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin-bottom: 4px;
  }

  .level-value {
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--primary);
  }
}

.level-actions {
  display: flex;
  gap: 16px;
  justify-content: center;
}

.waiting-phase {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 400px;
  text-align: center;

  .spinner {
    width: 48px;
    height: 48px;
    border: 4px solid var(--border);
    border-top-color: var(--primary);
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 16px;
  }

  h3 {
    font-size: calc(18px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
    margin: 0 0 8px;
  }

  p {
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    margin: 0;
  }
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

@keyframes fadeIn {
  from { opacity: 0; transform: scale(0.9); }
  to { opacity: 1; transform: scale(1); }
}
</style>
