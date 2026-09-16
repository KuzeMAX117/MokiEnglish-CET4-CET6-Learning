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
  <div class="login-body">
    <div class="login-box">
      <div class="login-left">
        <div class="left-content">
          <h1 class="brand-title">ENGLISH CET4-6</h1>
          <h2 class="main-title">方便的<span class="highlight">刷题</span>和<span class="highlight">备考</span></h2>
          <div class="features">
            <div class="feature-item">
              <div class="feature-name">作文批改</div>
              <div class="feature-desc">智能评分与范文学习</div>
            </div>
            <div class="feature-item">
              <div class="feature-name">单词记忆</div>
              <div class="feature-desc">高效背诵与巩固练习</div>
            </div>
          </div>
        </div>
        <div class="illustration">
          <div class="illust-box">
            <span class="illust-icon">📖</span>
            <span class="illust-text">Study</span>
          </div>
        </div>
      </div>

      <div class="login-right">
        <div class="login-form-wrapper">
          <div class="form-header">
            <div class="logo">
              <span class="logo-icon">📖</span>
              <span class="logo-text">CET4-6</span>
            </div>
          </div>

          <div class="form-member">
            <a-form :model="formData" ref="adminRef" :rules="formRule" layout="vertical">
              <a-form-item name="username">
                <a-input v-model:value="formData.username" placeholder="请输入账号" size="large">
                  <template #prefix>
                    <UserOutlined />
                  </template>
                </a-input>
              </a-form-item>
              <a-form-item name="password">
                <a-input-password v-model:value="formData.password" placeholder="请输入密码" size="large">
                  <template #prefix>
                    <LockOutlined />
                  </template>
                </a-input-password>
              </a-form-item>
              <a-form-item name="code">
                <div class="code-box">
                  <a-input maxlength="4" v-model:value="formData.code" placeholder="验证码" size="large" style="flex: 1;">
                    <template #prefix>
                      <CheckCircleOutlined />
                    </template>
                  </a-input>
                  <img @click="getCaptchaImage" :src="codeImage" alt="验证码" class="login-code" />
                </div>
              </a-form-item>
              <a-form-item class="check-item">
                <a-checkbox v-model:checked="formData.remember">记住密码</a-checkbox>
              </a-form-item>
              <a-form-item>
                <a-button v-if="!loginLoading" type="primary" block size="large" class="login-btn" @click="login()">
                  登 录
                </a-button>
                <a-spin v-else tip="正在登录中...."></a-spin>
              </a-form-item>
            </a-form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.login-body {
  width: 100%;
  height: 100vh;
  background-color: var(--base-background);

  .login-box {
    width: 100%;
    height: 100%;
    display: flex;

    .login-left {
      width: 55%;
      background: url('../assets/images/login-bg.png') center/cover no-repeat;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 60px 80px;
      position: relative;
      overflow: hidden;

      .left-content {
        position: relative;
        z-index: 2;

        .brand-title {
          font-size: 14px;
          font-weight: 500;
          color: var(--dashboard-primary);
          margin: 0 0 16px 0;
          letter-spacing: 2px;
        }

        .main-title {
          font-size: 36px;
          font-weight: 700;
          color: var(--dashboard-primary);
          margin: 0 0 40px 0;
          line-height: 1.4;

          .highlight {
            color: var(--dashboard-accent);
          }
        }

        .features {
          .feature-item {
            margin-bottom: 24px;

            .feature-name {
              font-size: 16px;
              font-weight: 600;
              color: var(--dashboard-primary);
              margin-bottom: 4px;
            }

            .feature-desc {
              font-size: 14px;
              color: #666;
            }
          }
        }
      }

      .illustration {
        position: absolute;
        right: 60px;
        bottom: 60px;
        z-index: 1;

        .illust-box {
          width: 200px;
          height: 200px;
          background: rgba(255, 255, 255, 0.6);
          border-radius: 24px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          gap: 12px;

          .illust-icon {
            font-size: 64px;
          }

          .illust-text {
            font-size: 18px;
            font-weight: 600;
            color: var(--dashboard-primary);
          }
        }
      }
    }

    .login-right {
      width: 45%;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #fff;
      padding: 40px;

      .login-form-wrapper {
        max-width: 360px;
        width: 100%;

        .form-header {
          margin-bottom: 40px;

          .logo {
            display: flex;
            align-items: center;
            gap: 10px;

            .logo-icon {
              font-size: 24px;
            }

            .logo-text {
              font-size: 18px;
              font-weight: 600;
              color: var(--dashboard-primary);
            }
          }
        }

        .form-member {
          ::v-deep(.ant-form-item) {
            margin-bottom: 20px;
          }

          ::v-deep(.ant-input-affix-wrapper) {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            padding: 10px 14px;

            &:hover, &:focus {
              border-color: var(--dashboard-primary);
              box-shadow: none;
            }
          }

          .check-item {
            margin: 0 0 20px 0;
          }

          .code-box {
            display: flex;
            align-items: center;
            gap: 12px;

            .login-code {
              cursor: pointer;
              height: 44px;
              border-radius: 8px;
              border: 1px solid #e0e0e0;
            }
          }

          .login-btn {
            height: 44px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            background-color: var(--dashboard-primary);
            border-color: var(--dashboard-primary);

            &:hover {
              background-color: var(--dashboard-secondary);
              border-color: var(--dashboard-secondary);
            }
          }
        }
      }
    }
  }
}

@media (max-width: 992px) {
  .login-body .login-box {
    flex-direction: column;

    .login-left {
      width: 100%;
      padding: 40px 20px;
      min-height: auto;

      .illustration {
        display: none;
      }
    }

    .login-right {
      width: 100%;
      padding: 40px 20px;
    }
  }
}
</style>
