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
      <div class="login-center">
        <div class="title">
          <h1>易题后台管理系统</h1>
        </div>
        <div class="form-member">
          <a-form :model="formData" ref="adminRef" :rules="formRule" layout="vertical">
            <a-form-item label="账户" name="username">
              <a-input v-model:value="formData.username" placeholder="请输入手机号或者邮箱" size="large">
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
              <a-checkbox v-model:checked="formData.remember" class="check">记住密码</a-checkbox>
            </a-form-item>
            <a-form-item>
              <a-button v-if="!loginLoading" type="primary" block size="large" @click="login()">登录</a-button>
              <a-spin v-else tip="正在登录并加载数据中...."></a-spin>
            </a-form-item>
          </a-form>
        </div>
      </div>
      <div class="login-bottom">
        <p>©易题后台管理系统 2025 如有侵权请联系QQ：3655161743</p>
        <p>赣ICP备2024033867号</p>
      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.login-body {
  width: 100%;
  height: 100vh;
  background-color: $base-background;
  display: flex;
  align-items: center;
  justify-content: center;

  .login-box {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: relative;

    .login-center {
      background-color: $base-login-background;
      text-align: center;
      padding: 40px;
      width: 420px;
      box-shadow: 0px 0px 12px 0px rgba(0, 0, 0, .1);
      border-radius: 12px;

      ::v-deep(.check-item) {
        display: flex;
        justify-content: flex-start;
        margin: 8px;
        padding: 0;
      }

      .title {
        margin-bottom: 30px;
        h1 {
          font-size: 22px;
          color: $base-personal-color;
        }
      }

      .code-box {
        display: flex;
        align-items: center;

        .login-code {
          margin-left: 12px;
          cursor: pointer;
          height: 40px;
          border-radius: 6px;
          border: 1px solid #d9d9d9;
        }
      }
    }

    .login-bottom {
      position: absolute;
      bottom: 2%;
      text-align: center;
      font-size: 14px;
      color: #b3b3b3;

      p {
        line-height: 1.5em;
      }
    }

    .check {
      color: #b0adb5;
    }
  }
}

@media (max-width: 792px) {
  .login-box {
    .login-center {
      width: 90%;
      padding: 20px;
    }
  }
}
</style>
