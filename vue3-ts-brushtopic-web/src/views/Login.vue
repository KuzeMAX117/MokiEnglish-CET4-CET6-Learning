<template>
  <div class="login-page">
    <div class="login-main">
      <div class="login-left">
        <div class="left-content">
          <span class="line1">DONE</span>
          <span class="line2">IS BETTER THAN</span>
          <span class="line3">PERFECT</span>
        </div>
      </div>

      <div class="login-right">
        <div class="login-card">
          <div class="brand-area">
            <div class="brand-logo">
              <span class="logo-glyph">T</span>
            </div>
            <p class="brand-name">Topic</p>
            <h1 class="headline">四六级智能学习平台</h1>
            <p class="subtitle">作文批改 · 单词记忆 · 智能翻译，一站式备考助手</p>
          </div>

          <template v-if="mode === 'login'">
            <a-form layout="vertical" :model="loginForm" @finish="handleLogin" class="login-form">
              <a-form-item>
                <div class="tab-switch">
                  <div class="tab-item" :class="{ active: loginWay === 0 }" @click="loginWay = 0">账户登录</div>
                  <div class="tab-item" :class="{ active: loginWay === 1 }" @click="loginWay = 1">邮箱登录</div>
                </div>
              </a-form-item>
              <a-form-item>
                <div class="input-label">账号</div>
                <a-input
                  v-model:value="loginForm.account"
                  :placeholder="loginWay === 0 ? '请输入账户名称' : '请输入 QQ 邮箱'"
                  size="large"
                  allow-clear
                  class="login-input"
                >
                  <template #prefix><UserOutlined class="input-icon" /></template>
                </a-input>
              </a-form-item>
              <a-form-item>
                <div class="input-label">密码</div>
                <a-input-password
                  v-model:value="loginForm.password"
                  placeholder="请输入密码"
                  size="large"
                  class="login-input"
                  @press-enter="handleLogin"
                >
                  <template #prefix><LockOutlined class="input-icon" /></template>
                </a-input-password>
              </a-form-item>
              <a-form-item>
                <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="submit-btn">
                  登录
                </a-button>
              </a-form-item>
              <div class="action-row">
                <a class="link-btn" @click="mode = 'forget'">忘记密码</a>
                <a class="link-btn" @click="mode = 'register'">立即注册</a>
              </div>
            </a-form>
          </template>

          <template v-else-if="mode === 'register'">
            <div class="form-header">
              <h2>创建账户</h2>
              <a class="link-btn back-link" @click="mode = 'login'">已有账户？立即登录</a>
            </div>
            <a-form layout="vertical" :model="registerForm" @finish="handleRegister" class="login-form">
              <a-form-item>
                <div class="input-label">账户名称</div>
                <a-input v-model:value="registerForm.account" placeholder="创建你的专属账户 (注册后不可更改)" size="large" allow-clear class="login-input" />
              </a-form-item>
              <a-form-item>
                <div class="input-label">昵称</div>
                <a-input v-model:value="registerForm.nickname" placeholder="给自己起个独特的昵称" size="large" allow-clear class="login-input" />
              </a-form-item>
              <a-form-item>
                <div class="input-label">QQ 邮箱</div>
                <a-input v-model:value="registerForm.email" placeholder="请输入 QQ 邮箱" size="large" class="login-input" />
              </a-form-item>
              <a-form-item>
                <div class="input-label">邮箱验证码</div>
                <div class="input-group">
                  <a-input v-model:value="registerForm.code" placeholder="请输入 6 位验证码" size="large" maxlength="6" class="login-input code-input" />
                  <a-button size="large" :loading="emailLoading" @click="getCode('register')" class="code-btn">发送验证码</a-button>
                </div>
              </a-form-item>
              <a-form-item>
                <div class="input-label">登录密码</div>
                <a-input-password v-model:value="registerForm.password" placeholder="请输入登录密码" size="large" class="login-input" />
              </a-form-item>
              <a-form-item>
                <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="submit-btn">注册</a-button>
              </a-form-item>
            </a-form>
          </template>

          <template v-else>
            <div class="form-header">
              <h2>重置密码</h2>
              <a class="link-btn back-link" @click="mode = 'login'">← 返回登录</a>
            </div>
            <a-form layout="vertical" :model="forgetForm" @finish="handleForget" class="login-form">
              <a-form-item>
                <div class="input-label">QQ 邮箱</div>
                <a-input v-model:value="forgetForm.email" placeholder="请输入 QQ 邮箱" size="large" class="login-input" />
              </a-form-item>
              <a-form-item>
                <div class="input-label">邮箱验证码</div>
                <div class="input-group">
                  <a-input v-model:value="forgetForm.code" placeholder="请输入 6 位验证码" size="large" maxlength="6" class="login-input code-input" />
                  <a-button size="large" :loading="emailLoading" @click="getCode('forget')" class="code-btn">发送验证码</a-button>
                </div>
              </a-form-item>
              <a-form-item>
                <div class="input-label">新密码</div>
                <a-input-password v-model:value="forgetForm.password" placeholder="请输入新密码" size="large" class="login-input" />
              </a-form-item>
              <a-form-item>
                <div class="input-label">确认新密码</div>
                <a-input-password v-model:value="forgetForm.newPassword" placeholder="请再次输入新密码" size="large" class="login-input" />
              </a-form-item>
              <a-form-item>
                <a-button type="primary" html-type="submit" size="large" block :loading="loading" class="submit-btn">确认修改</a-button>
              </a-form-item>
            </a-form>
          </template>

          <div class="terms-text">
            登录即表示您同意我们的<a>服务条款</a>和<a>隐私政策</a>
          </div>
        </div>
      </div>
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
  background: #e8f5f0;
  display: flex;
}

.login-main {
  flex: 1;
  display: flex;
  min-height: 0;
}

.login-left {
  flex: 1;
  background: linear-gradient(135deg, #2ab5a0, #1e9e8a);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 60px;
  position: relative;
  overflow: hidden;

  &::before {
    content: '';
    position: absolute;
    inset: 0;
    background-image:
      linear-gradient(rgba(255, 255, 255, 0.08) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255, 255, 255, 0.08) 1px, transparent 1px);
    background-size: 48px 48px;
    mask-image: radial-gradient(circle at 50% 50%, #000 0%, transparent 70%);
  }
}

.left-content {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  gap: 12px;

  .line1,
  .line2,
  .line3 {
    font-weight: 900;
    text-transform: uppercase;
    line-height: 1;
    color: rgba(255, 255, 255, 0.2);
    letter-spacing: 6px;
  }

  .line1 {
    font-size: 120px;
  }

  .line2 {
    font-size: 64px;
  }

  .line3 {
    font-size: 120px;
  }
}

.login-right {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px;
  background: #fff;
}

.login-card {
  width: 100%;
  max-width: 400px;
}

.brand-area {
  text-align: center;
  margin-bottom: 32px;

  .brand-logo {
    width: 52px;
    height: 52px;
    border-radius: 12px;
    background: linear-gradient(135deg, #2ab5a0, #1e9e8a);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 12px;

    .logo-glyph {
      color: #fff;
      font-weight: 700;
      font-size: 24px;
    }
  }

  .brand-name {
    font-size: 14px;
    color: #666;
    margin-bottom: 16px;
  }

  .headline {
    font-size: 26px;
    font-weight: 700;
    color: #1a1a1a;
    margin-bottom: 8px;
    line-height: 1.3;
  }

  .subtitle {
    font-size: 13px;
    color: #666;
    line-height: 1.5;
  }
}

.login-form {
  :deep(.ant-form-item) {
    margin-bottom: 18px;
  }
}

.tab-switch {
  display: flex;
  background: #f0f7f5;
  border-radius: 8px;
  padding: 4px;

  .tab-item {
    flex: 1;
    text-align: center;
    padding: 10px 0;
    font-size: 14px;
    color: #666;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.25s;
    user-select: none;

    &.active {
      color: #1e9e8a;
      font-weight: 600;
      background: #fff;
      box-shadow: 0 1px 3px rgba(0, 128, 100, 0.1);
    }
  }
}

.input-label {
  font-size: 14px;
  font-weight: 500;
  color: #333;
  margin-bottom: 8px;
}

.login-input {
  border-radius: 8px;

  :deep(.ant-input) {
    background: #f0f7f5;
    border-color: transparent;

    &:hover,
    &:focus {
      background: #fff;
      border-color: #2ab5a0;
    }
  }

  :deep(.ant-input-prefix .input-icon) {
    color: #999;
  }
}

:deep(.ant-input-affix-wrapper) {
  border-radius: 8px;
  background: #f0f7f5;
  border-color: transparent;

  &:hover,
  &:focus-within {
    background: #fff;
    border-color: #2ab5a0;
  }
}

.input-group {
  display: flex;
  gap: 12px;

  .code-input {
    flex: 1;
  }
}

.code-btn {
  height: 40px;
  border-radius: 8px;
  background: #f0f7f5;
  border-color: #d4ebe5;
  color: #1e9e8a;
  white-space: nowrap;

  &:hover {
    background: #e0f2ed;
    border-color: #2ab5a0;
    color: #168a78;
  }
}

.submit-btn {
  height: 48px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 600;
  background: linear-gradient(135deg, #2ab5a0, #1e9e8a);
  border-color: #2ab5a0;

  &:hover,
  &:focus {
    background: linear-gradient(135deg, #23a693, #178f7d) !important;
    border-color: #23a693 !important;
  }
}

.action-row {
  display: flex;
  justify-content: space-between;
  font-size: 14px;
}

.link-btn {
  color: #666;
  cursor: pointer;
  transition: color 0.25s;

  &:hover {
    color: #2ab5a0;
  }
}

.back-link {
  font-size: 14px;
}

.form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;

  h2 {
    font-size: 22px;
    font-weight: 700;
    color: #1a1a1a;
  }
}

.terms-text {
  text-align: center;
  font-size: 12px;
  color: #999;
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid #f0f0f0;

  a {
    color: #666;
    text-decoration: underline;

    &:hover {
      color: #2ab5a0;
    }
  }
}

@media (max-width: 900px) {
  .login-main {
    flex-direction: column;
  }

  .login-left {
    padding: 48px 32px;
    min-height: 240px;
  }

  .left-content {
    .line1, .line3 {
      font-size: 64px;
    }
    .line2 {
      font-size: 36px;
    }
  }

  .login-right {
    width: 100%;
    padding: 32px 24px;
  }
}

@media (max-width: 480px) {
  .left-content {
    .line1, .line3 {
      font-size: 48px;
    }
    .line2 {
      font-size: 24px;
    }
  }
}
</style>
