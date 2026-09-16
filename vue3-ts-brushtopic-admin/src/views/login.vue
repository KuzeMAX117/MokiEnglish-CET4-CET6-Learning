<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { apiGetCode } from '@/api/system'
import { useUserStore } from '@/stores/modules/user'
import type { LoginType } from '@/api/auth/type';

const userStore = useUserStore()

const codeImage = ref('')

const getCaptchaImage = async () => {
  apiGetCode().then((res) => {
    codeImage.value = URL.createObjectURL(new Blob([res as any], { type: 'image/png' }))
  })
}

const adminRef = ref<any>(null)

const formData = ref<LoginType>({
  username: 'admin',
  password: '123456',
  code: '',
  remember: false,
})

const formRule = ref({
  username: [
    { required: true, message: '请输入您的账号', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入您的密码', trigger: 'blur' }
  ],
  code: [
    { required: true, message: '请输入验证码', trigger: 'blur' }
  ]
})

const loginLoading = ref(false)

const login = () => {
  localStorage.clear();
  sessionStorage.clear();
  if (!adminRef.value) return
  if (adminRef.value) {
    adminRef.value.validate().then(async (valid: boolean) => {
      if (valid) {
        loginLoading.value = true
        await userStore.login(formData.value)
        loginLoading.value = false
        if (formData.value.remember) {
          window.localStorage.setItem("userPassword", JSON.stringify({
            username: formData.value.username,
            password: formData.value.password
          }))
        }
        clearStyle()
      }
    })
  }
}

const clearStyle = () => {
  formData.value = {
    username: 'admin',
    password: '123456',
    code: '',
    remember: false,
  }
  adminRef.value.resetFields()
}

const getRemember = () => {
  const item = window.localStorage.getItem("userPassword")
  if (item) {
    const userPassword = JSON.parse(item)
    formData.value.username = userPassword.username
    formData.value.password = userPassword.password
    formData.value.remember = true
  }
}

onMounted(() => {
  getCaptchaImage()
  getRemember()
})
</script>
<template>
  <div class="login-page">
    <div class="login-header">
      <div class="header-content">
        <div class="brand-logo">
          <span class="logo-glyph">T</span>
        </div>
        <span class="brand-name">Topic 管理后台</span>
      </div>
    </div>

    <div class="login-body">
      <div class="slogan-area">
        <h1 class="main-title">四六级智能学习</h1>
        <h2 class="sub-title">后台管理系统</h2>
        <div class="tagline">
          <span class="tag">题库管理</span>
          <span class="divider">·</span>
          <span class="tag">用户管理</span>
          <span class="divider">·</span>
          <span class="tag">数据监控</span>
        </div>
      </div>

      <div class="login-card">
        <div class="card-header">
          <h3>管理员登录</h3>
          <p>请输入您的账户信息</p>
        </div>

        <a-form :model="formData" ref="adminRef" :rules="formRule" layout="vertical" class="login-form">
          <a-form-item name="username">
            <div class="input-label">账号</div>
            <a-input v-model:value="formData.username" placeholder="请输入账号" size="large" class="login-input">
              <template #prefix><UserOutlined class="input-icon" /></template>
            </a-input>
          </a-form-item>
          <a-form-item name="password">
            <div class="input-label">密码</div>
            <a-input-password v-model:value="formData.password" placeholder="请输入密码" size="large" class="login-input">
              <template #prefix><LockOutlined class="input-icon" /></template>
            </a-input-password>
          </a-form-item>
          <a-form-item name="code">
            <div class="input-label">验证码</div>
            <div class="code-box">
              <a-input maxlength="4" v-model:value="formData.code" placeholder="请输入验证码" size="large" class="login-input code-input">
                <template #prefix><CheckCircleOutlined class="input-icon" /></template>
              </a-input>
              <img @click="getCaptchaImage" :src="codeImage" alt="验证码" class="login-code" />
            </div>
          </a-form-item>
          <a-form-item class="check-item">
            <a-checkbox v-model:checked="formData.remember">记住密码</a-checkbox>
          </a-form-item>
          <a-form-item>
            <a-button v-if="!loginLoading" type="primary" block size="large" class="submit-btn" @click="login()">
              登录
            </a-button>
            <a-spin v-else tip="正在登录中...."></a-spin>
          </a-form-item>
        </a-form>

        <div class="terms-text">
          管理后台仅限授权人员使用
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.login-page {
  min-height: 100vh;
  background: #f5f7fa;
  display: flex;
  flex-direction: column;
}

.login-header {
  background: #fff;
  border-bottom: 1px solid #e8eaed;
  padding: 16px 40px;

  .header-content {
    display: flex;
    align-items: center;
    gap: 12px;

    .brand-logo {
      width: 36px;
      height: 36px;
      border-radius: 8px;
      background: linear-gradient(135deg, #2ab5a0, #1e9e8a);
      display: flex;
      align-items: center;
      justify-content: center;

      .logo-glyph {
        color: #fff;
        font-weight: 700;
        font-size: 18px;
      }
    }

    .brand-name {
      font-size: 16px;
      font-weight: 600;
      color: #1a1a1a;
    }
  }
}

.login-body {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 80px;
  padding: 40px;
}

.slogan-area {
  text-align: right;

  .main-title {
    font-size: 42px;
    font-weight: 800;
    color: #1a1a1a;
    margin: 0 0 8px 0;
    line-height: 1.2;
  }

  .sub-title {
    font-size: 36px;
    font-weight: 800;
    color: #2ab5a0;
    margin: 0 0 24px 0;
    line-height: 1.2;
  }

  .tagline {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 12px;

    .tag {
      font-size: 14px;
      color: #666;
      background: #f0f7f5;
      padding: 6px 14px;
      border-radius: 20px;
    }

    .divider {
      color: #ccc;
    }
  }
}

.login-card {
  width: 420px;
  background: #fff;
  border-radius: 16px;
  padding: 40px;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.06);

  .card-header {
    margin-bottom: 32px;

    h3 {
      font-size: 24px;
      font-weight: 700;
      color: #1a1a1a;
      margin: 0 0 8px 0;
    }

    p {
      font-size: 14px;
      color: #666;
      margin: 0;
    }
  }
}

.login-form {
  :deep(.ant-form-item) {
    margin-bottom: 20px;
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
    background: #f5f7fa;
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
  background: #f5f7fa;
  border-color: transparent;

  &:hover,
  &:focus-within {
    background: #fff;
    border-color: #2ab5a0;
  }
}

.code-box {
  display: flex;
  gap: 12px;
  align-items: center;

  .code-input {
    flex: 1;
  }

  .login-code {
    cursor: pointer;
    height: 44px;
    border-radius: 8px;
    border: 1px solid #e0e0e0;
  }
}

.check-item {
  margin: 0 0 20px 0;
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

.terms-text {
  text-align: center;
  font-size: 12px;
  color: #999;
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid #f0f0f0;
}

@media (max-width: 900px) {
  .login-body {
    flex-direction: column;
    gap: 40px;
    padding: 32px 20px;
  }

  .slogan-area {
    text-align: center;

    .tagline {
      justify-content: center;
    }

    .main-title {
      font-size: 32px;
    }

    .sub-title {
      font-size: 28px;
    }
  }

  .login-card {
    width: 100%;
    max-width: 420px;
  }
}
</style>
