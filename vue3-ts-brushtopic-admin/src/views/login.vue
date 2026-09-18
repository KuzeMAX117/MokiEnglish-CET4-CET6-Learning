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
    <div class="login-card">
      <div class="login-header">
        <div class="login-logo">T</div>
        <h1 class="login-title">后台管理系统</h1>
        <p class="login-desc">四六级智能学习平台</p>
      </div>

      <a-form :model="formData" ref="adminRef" :rules="formRule" layout="vertical" class="login-form">
        <a-form-item label="账号" name="username">
          <a-input v-model:value="formData.username" placeholder="请输入账号" size="large">
            <template #prefix>
              <UserOutlined />
            </template>
          </a-input>
        </a-form-item>

        <a-form-item label="密码" name="password">
          <a-input-password v-model:value="formData.password" placeholder="请输入密码" size="large">
            <template #prefix>
              <LockOutlined />
            </template>
          </a-input-password>
        </a-form-item>

        <a-form-item label="验证码" name="code">
          <div class="code-row">
            <a-input maxlength="4" v-model:value="formData.code" placeholder="请输入验证码" size="large" class="code-input">
              <template #prefix>
                <CheckCircleOutlined />
              </template>
            </a-input>
            <img @click="getCaptchaImage" :src="codeImage" alt="验证码" class="code-img" />
          </div>
        </a-form-item>

        <div class="login-options">
          <a-checkbox v-model:checked="formData.remember">记住密码</a-checkbox>
        </div>

        <a-form-item>
          <a-button v-if="!loginLoading" type="primary" block size="large" @click="login()" class="login-btn">登 录</a-button>
          <a-spin v-else tip="正在登录..." class="login-spin"></a-spin>
        </a-form-item>
      </a-form>

      <div class="login-footer">管理后台仅限授权人员使用</div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.login-page {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #2ab5a0 0%, #1a9e8a 50%, #168573 100%);
}

.login-card {
  width: 420px;
  padding: 48px 40px 36px;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
}

.login-header {
  text-align: center;
  margin-bottom: 36px;
}

.login-logo {
  width: 56px;
  height: 56px;
  margin: 0 auto 16px;
  line-height: 56px;
  font-size: 28px;
  font-weight: 700;
  color: #fff;
  background: linear-gradient(135deg, #2ab5a0, #1a9e8a);
  border-radius: 14px;
}

.login-title {
  font-size: 22px;
  font-weight: 600;
  color: #1a1a2e;
  margin-bottom: 4px;
}

.login-desc {
  font-size: 14px;
  color: #999;
}

.login-form {
  ::v-deep(.ant-form-item-label) {
    padding-bottom: 4px;

    label {
      font-size: 14px;
      color: #333;
    }
  }
}

.code-row {
  display: flex;
  align-items: center;
  gap: 12px;

  .code-input {
    flex: 1;
  }

  .code-img {
    height: 40px;
    border-radius: 6px;
    border: 1px solid #d9d9d9;
    cursor: pointer;
    flex-shrink: 0;
  }
}

.login-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.login-btn {
  height: 44px;
  font-size: 16px;
  font-weight: 500;
  border-radius: 8px;
  background: linear-gradient(135deg, #2ab5a0, #1a9e8a);
  border-color: #2ab5a0;

  &:hover {
    background: linear-gradient(135deg, #25a491, #17917d);
    border-color: #25a491;
  }
}

.login-spin {
  display: flex;
  justify-content: center;
}

.login-footer {
  text-align: center;
  font-size: 12px;
  color: #bbb;
  margin-top: 8px;
}

@media (max-width: 480px) {
  .login-card {
    width: calc(100% - 32px);
    padding: 36px 24px 28px;
    margin: 0 16px;
  }
}
</style>
