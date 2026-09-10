<template>
  <div class="login-page">
    
    <div class="bg-glow">
      <div class="glow-orb orb-1"></div>
      <div class="glow-orb orb-2"></div>
      <div class="glow-orb orb-3"></div>
      <div class="grid-overlay"></div>
    </div>

    <div class="login-card">
      
      <div class="brand-area">
        <div class="brand-logo">
          <span class="logo-glyph">C</span>
          <span class="logo-pulse"></span>
        </div>
        <h1 class="title neon-text">CET备考 · 四六级刷题引擎</h1>
        <p class="slogan">AI 陪你备考四六级，让学习更高效</p>
      </div>

      
      <template v-if="mode === 'login'">
        <div class="tab-switch">
          <div
            class="tab-item"
            :class="{ active: loginWay === 0 }"
            @click="loginWay = 0"
          >账户登录</div>
          <div
            class="tab-item"
            :class="{ active: loginWay === 1 }"
            @click="loginWay = 1"
          >邮箱登录</div>
        </div>
        <a-form layout="vertical" :model="loginForm" @finish="handleLogin">
          <a-form-item>
            <a-input
              v-model:value="loginForm.account"
              :placeholder="loginWay === 0 ? '请输入账户名称' : '请输入 QQ 邮箱'"
              size="large"
              allow-clear
              class="glass-input"
            >
              <template #prefix><UserOutlined class="input-icon" /></template>
            </a-input>
          </a-form-item>
          <a-form-item>
            <a-input-password
              v-model:value="loginForm.password"
              placeholder="请输入密码"
              size="large"
              class="glass-input"
              @press-enter="handleLogin"
            >
              <template #prefix><LockOutlined class="input-icon" /></template>
            </a-input-password>
          </a-form-item>
          <a-form-item>
            <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="neon-btn">
              开始备考
            </a-button>
          </a-form-item>
          <div class="action-row">
            <a class="link-btn" @click="mode = 'forget'">忘记密码</a>
            <a class="link-btn" @click="mode = 'register'">立即注册 →</a>
          </div>
        </a-form>
      </template>

      
      <template v-else-if="mode === 'register'">
        <div class="form-header">
          <h2>加入 CET备考</h2>
          <a class="link-btn" @click="mode = 'login'">← 返回登录</a>
        </div>
        <a-form layout="vertical" :model="registerForm" @finish="handleRegister">
          <a-form-item label="账户名称">
            <a-input v-model:value="registerForm.account" placeholder="创建你的专属账户 (注册后不可更改)" size="large" allow-clear class="glass-input" />
          </a-form-item>
          <a-form-item label="昵称">
            <a-input v-model:value="registerForm.nickname" placeholder="给自己起个独特的昵称" size="large" allow-clear class="glass-input" />
          </a-form-item>
          <a-form-item label="QQ 邮箱">
            <div class="input-group">
              <a-input
                v-model:value="registerForm.email"
                placeholder="请输入 QQ 邮箱"
                size="large"
                class="glass-input"
              />
              <a-button size="large" :loading="emailLoading" @click="getCode('register')" class="code-btn">
                发送验证码
              </a-button>
            </div>
          </a-form-item>
          <a-form-item label="邮箱验证码">
            <a-input v-model:value="registerForm.code" placeholder="请输入 6 位验证码" size="large" maxlength="6" class="glass-input" />
          </a-form-item>
          <a-form-item label="登录密码">
            <a-input-password v-model:value="registerForm.password" placeholder="请输入登录密码" size="large" class="glass-input" />
          </a-form-item>
          <a-form-item>
            <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="neon-btn">
              开启四六级备考之旅
            </a-button>
          </a-form-item>
        </a-form>
      </template>

      
      <template v-else>
        <div class="form-header">
          <h2>重置密码</h2>
          <a class="link-btn" @click="mode = 'login'">← 返回登录</a>
        </div>
        <a-form layout="vertical" :model="forgetForm" @finish="handleForget">
          <a-form-item label="QQ 邮箱">
            <div class="input-group">
              <a-input v-model:value="forgetForm.email" placeholder="请输入 QQ 邮箱" size="large" class="glass-input" />
              <a-button size="large" :loading="emailLoading" @click="getCode('forget')" class="code-btn">
                发送验证码
              </a-button>
            </div>
          </a-form-item>
          <a-form-item label="邮箱验证码">
            <a-input v-model:value="forgetForm.code" placeholder="请输入 6 位验证码" size="large" maxlength="6" class="glass-input" />
          </a-form-item>
          <a-form-item label="新密码">
            <a-input-password v-model:value="forgetForm.password" placeholder="请输入新密码" size="large" class="glass-input" />
          </a-form-item>
          <a-form-item label="确认新密码">
            <a-input-password v-model:value="forgetForm.newPassword" placeholder="请再次输入新密码" size="large" class="glass-input" />
          </a-form-item>
          <a-form-item>
            <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="neon-btn">
              确认修改
            </a-button>
          </a-form-item>
        </a-form>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { message } from 'ant-design-vue'
import { UserOutlined, LockOutlined } from '@ant-design/icons-vue'
import { apiLogin, apiRegister, apiSendEmail, apiResetPassword } from '@/api/auth'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const mode = ref<'login' | 'register' | 'forget'>('login')
const loginWay = ref(0)
const loading = ref(false)
const emailLoading = ref(false)

const loginForm = reactive({ account: '', email: '', password: '' })

const registerForm = reactive({
  account: '',
  nickname: '',
  password: '',
  code: '',
  email: '',
})

const forgetForm = reactive({ code: '', password: '', newPassword: '', email: '' })

const validateQQEmail = (email: string) => /^[a-zA-Z0-9_-]+@qq.com$/.test(email)

const getCode = async (type: 'register' | 'forget') => {
  const email = type === 'register' ? registerForm.email : forgetForm.email
  if (!email) {
    message.warning('请输入 QQ 邮箱')
    return
  }
  if (!validateQQEmail(email)) {
    message.warning('请输入正确 QQ 邮箱')
    return
  }
  emailLoading.value = true
  try {
    await apiSendEmail(email)
    message.success('邮件已发送，5 分钟内有效')
  } finally {
    emailLoading.value = false
  }
}

const handleLogin = async () => {
  const field = loginWay.value === 0 ? loginForm.account : loginForm.email
  if (!field) {
    message.warning(loginWay.value === 0 ? '请输入账户名称' : '请输入邮箱')
    return
  }
  if (!loginForm.password) {
    message.warning('请输入密码')
    return
  }
  loading.value = true
  try {
    const res = await apiLogin({
      loginType: loginWay.value,
      account: loginForm.account,
      email: loginForm.email,
      password: loginForm.password,
    })
    if (res.code === 201) {
      message.error('登录失败，请检查账户或密码')
      return
    }
    const userInfo = JSON.parse(res.data.userInfo)
    userStore.setLogin(res.data.token, userInfo, res.data.role)
    message.success('登录成功')
    const redirect = (route.query.redirect as string) || '/home'
    router.push(redirect)
  } finally {
    loading.value = false
  }
}

const handleRegister = async () => {
  if (!validateQQEmail(registerForm.email)) {
    message.warning('请输入正确 QQ 邮箱')
    return
  }
  if (!registerForm.account) {
    message.warning('请输入账户名称')
    return
  }
  if (!registerForm.code) {
    message.warning('请输入验证码')
    return
  }
  loading.value = true
  try {
    await apiRegister({ ...registerForm })
    message.success('注册成功，请登录')
    mode.value = 'login'
  } finally {
    loading.value = false
  }
}

const handleForget = async () => {
  const { code, password, newPassword, email } = forgetForm
  if (!code || !password || !newPassword || !email) {
    message.warning('请输入完整信息')
    return
  }
  if (password !== newPassword) {
    message.warning('两次输入的新密码不一致')
    return
  }
  loading.value = true
  try {
    await apiResetPassword({ code, password, newPassword, email })
    message.success('密码重置成功，请重新登录')
    mode.value = 'login'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped lang="scss">
.login-page {
  min-height: 100vh;
  background: var(--card-bg);
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  padding: 40px 20px;
}

.bg-glow {
  position: absolute;
  inset: 0;
  pointer-events: none;
  overflow: hidden;

  .glow-orb {
    position: absolute;
    border-radius: 50%;
    filter: blur(120px);
  }

  .orb-1 {
    width: 520px;
    height: 520px;
    top: -180px;
    left: 8%;
    background: radial-gradient(circle, rgba(66, 87, 178, 0.14), transparent 70%);
    animation: float 14s infinite ease-in-out;
  }

  .orb-2 {
    width: 460px;
    height: 460px;
    bottom: -160px;
    right: 6%;
    background: radial-gradient(circle, rgba(66, 87, 178, 0.08), transparent 70%);
    animation: float 18s infinite ease-in-out reverse;
  }

  .orb-3 {
    width: 380px;
    height: 380px;
    top: 30%;
    right: 30%;
    background: radial-gradient(circle, rgba(66, 87, 178, 0.06), transparent 70%);
    animation: float 22s infinite ease-in-out;
  }

  .grid-overlay {
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(66, 87, 178, 0.05) 1px, transparent 1px),
      linear-gradient(90deg, rgba(66, 87, 178, 0.05) 1px, transparent 1px);
    background-size: 44px 44px;
    mask-image: radial-gradient(circle at 50% 40%, #000 0%, transparent 70%);
  }
}

@keyframes float {
  0%,
  100% {
    transform: translateY(0) scale(1);
  }
  50% {
    transform: translateY(-40px) scale(1.08);
  }
}

.login-card {
  position: relative;
  z-index: 2;
  width: 460px;
  background: var(--page-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 40px 44px;
  box-shadow: var(--shadow-hover);
}

.brand-area {
  text-align: center;
  margin-bottom: 30px;

  .brand-logo {
    position: relative;
    width: 62px;
    height: 62px;
    border-radius: 16px;
    background: linear-gradient(135deg, #4257B2, #364899);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 16px;
    box-shadow: 0 8px 20px rgba(66, 87, 178, 0.28);

    .logo-glyph {
      color: #fff;
      font-weight: 800;
      font-size: calc(32px + var(--font-offset, 0px));
    }

    .logo-pulse {
      position: absolute;
      inset: -4px;
      border-radius: 18px;
      border: 1px solid rgba(66, 87, 178, 0.35);
      animation: pulse 2.4s infinite;
    }
  }

  .title {
    font-size: calc(24px + var(--font-offset, 0px));
    font-weight: 800;
    letter-spacing: 1px;
  }

  .slogan {
    margin-top: 8px;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    letter-spacing: 0.5px;
  }
}

@keyframes pulse {
  0%,
  100% {
    opacity: 0.6;
    transform: scale(1);
  }
  50% {
    opacity: 0.1;
    transform: scale(1.12);
  }
}

.neon-text {
  color: var(--primary);
}

.tab-switch {
  display: flex;
  padding: 4px;
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: var(--radius-md);
  margin-bottom: 22px;

  .tab-item {
    flex: 1;
    text-align: center;
    padding: 9px 0;
    font-size: calc(14px + var(--font-offset, 0px));
    color: var(--text-muted);
    border-radius: 9px;
    cursor: pointer;
    transition: all 0.25s;
    user-select: none;

    &.active {
      color: var(--primary);
      font-weight: 600;
      background: var(--page-bg);
      box-shadow: var(--shadow-card);
    }
  }
}

.glass-input {
  border-radius: 8px;

  :deep(.ant-input) {
    background: transparent;
  }

  :deep(.ant-input-prefix .input-icon) {
    color: var(--text-muted);
  }
}

:deep(.ant-input-affix-wrapper) {
  background: var(--card-bg);
  border-color: var(--border);
  border-radius: 8px;

  &:hover,
  &:focus-within {
    background: var(--page-bg);
    border-color: rgba(66, 87, 178, 0.5);
    box-shadow: 0 0 0 2px rgba(66, 87, 178, 0.12);
  }
}

.input-group {
  display: flex;
  gap: 10px;

  .glass-input {
    flex: 1;
  }
}

.code-btn {
  height: 40px;
  border-radius: 8px;
  background: var(--primary-light);
  border-color: rgba(66, 87, 178, 0.35);
  color: var(--primary);

  &:hover {
    background: rgba(66, 87, 178, 0.14);
    border-color: rgba(66, 87, 178, 0.55);
    color: var(--primary-hover);
  }
}

.neon-btn {
  height: 46px;
  border-radius: var(--radius-md);
  font-size: calc(16px + var(--font-offset, 0px));
  font-weight: 600;
  letter-spacing: 2px;
  border: none;
  background: var(--primary);
  box-shadow: 0 8px 20px rgba(66, 87, 178, 0.3);

  &:hover,
  &:focus {
    background: var(--primary-hover) !important;
    box-shadow: 0 10px 26px rgba(66, 87, 178, 0.4);
  }
}

.form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 22px;

  h2 {
    font-size: calc(20px + var(--font-offset, 0px));
    font-weight: 700;
    color: var(--text-title);
  }
}

.action-row {
  display: flex;
  justify-content: space-between;
  font-size: calc(14px + var(--font-offset, 0px));
}

.link-btn {
  color: var(--text-muted);
  transition: color 0.25s;

  &:hover {
    color: var(--primary);
  }
}

:deep(.ant-form-item-label > label) {
  color: var(--text-body) !important;
  font-size: calc(14px + var(--font-offset, 0px));
}

:deep(.ant-input) {
  color: var(--text-title);
}

:deep(.ant-input::placeholder) {
  color: var(--text-muted);
}
</style>
