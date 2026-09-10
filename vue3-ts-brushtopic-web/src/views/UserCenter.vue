<template>
  <div class="user-center">
    
    <div class="profile-header">
      <div class="bg-glow-inner">
        <div class="glow g1"></div>
        <div class="glow g2"></div>
        <div class="grid-overlay"></div>
      </div>
      <div class="profile-inner">
        <div class="avatar-ring">
          <a-avatar
            v-if="userStore.userInfo?.avatar"
            :src="userStore.userInfo.avatar"
            :size="84"
            class="avatar"
          />
          <a-avatar v-else :size="84" class="avatar avatar-none">
            {{ (userStore.nickname || 'H').charAt(0) }}
          </a-avatar>
        </div>
        <div class="user-info-box">
          <div class="user-nickname neon-text">{{ userStore.nickname || '未设置昵称' }}</div>
          <div class="identity-capsule">
            <span class="dot"></span>
            <span class="role-text">{{ roleName }}</span>
          </div>
        </div>
      </div>
    </div>

    <div class="body-content">
      <div class="row">
        
        <div class="panel">
          <div class="panel-title">
            <div class="indicator" />
            学习管理
          </div>
          <div class="list-row" @click="router.push('/favorite')">
            <div class="row-left">
              <div class="icon-circle fav"><StarFilled /></div>
              <span class="label">我的收藏</span>
            </div>
            <RightOutlined class="arrow" />
          </div>
          <div class="list-row" @click="router.push('/feedback')">
            <div class="row-left">
              <div class="icon-circle feedback"><MessageOutlined /></div>
              <span class="label">反馈记录</span>
            </div>
            <RightOutlined class="arrow" />
          </div>
        </div>

        
        <div class="panel">
          <div class="panel-title">
            <div class="indicator" />
            账号管理
          </div>
          <div class="list-row" @click="openProfileModal">
            <div class="row-left">
              <div class="icon-circle profile"><EditOutlined /></div>
              <span class="label">修改资料</span>
            </div>
            <RightOutlined class="arrow" />
          </div>
          <div class="list-row" @click="openPasswordModal">
            <div class="row-left">
              <div class="icon-circle password"><LockOutlined /></div>
              <span class="label">修改密码</span>
            </div>
            <RightOutlined class="arrow" />
          </div>
          <div class="list-row" @click="openAvatarModal">
            <div class="row-left">
              <div class="icon-circle avatar-icon"><UserOutlined /></div>
              <span class="label">修改头像</span>
            </div>
            <RightOutlined class="arrow" />
          </div>
        </div>
      </div>

      <div class="logout-btn">
        <a-button danger block size="large" class="logout" @click="handleLogout">退出登录</a-button>
      </div>
    </div>

    
    <a-modal v-model:open="profileModal" title="修改资料" @ok="submitProfile" :confirm-loading="profileLoading">
      <a-form layout="vertical">
        <a-form-item label="昵称">
          <a-input v-model:value="profileForm.nickname" placeholder="请输入昵称" maxlength="12" />
        </a-form-item>
        <a-form-item label="邮箱">
          <a-input v-model:value="profileForm.email" placeholder="请输入 QQ 邮箱" />
        </a-form-item>
      </a-form>
    </a-modal>

    
    <a-modal v-model:open="passwordModal" title="修改密码" @ok="submitPassword" :confirm-loading="passwordLoading">
      <a-form layout="vertical">
        <a-form-item label="原密码">
          <a-input-password v-model:value="passwordForm.oldPassword" placeholder="请输入原密码" />
        </a-form-item>
        <a-form-item label="新密码">
          <a-input-password v-model:value="passwordForm.password" placeholder="请输入新密码" />
        </a-form-item>
        <a-form-item label="确认新密码">
          <a-input-password v-model:value="passwordForm.newPassword" placeholder="请再次输入新密码" />
        </a-form-item>
      </a-form>
    </a-modal>

    
    <a-modal v-model:open="avatarModal" title="修改头像" @ok="submitAvatar" :confirm-loading="avatarLoading">
      <div style="text-align: center">
        <a-avatar :size="96" :src="avatarForm.avatar" class="avatar-preview">
          {{ (userStore.nickname || 'H').charAt(0) }}
        </a-avatar>
        <div style="margin-top: 16px">
          <a-input v-model:value="avatarForm.avatar" placeholder="请输入图片 URL 地址" />
        </div>
      </div>
    </a-modal>
  </div>
</template>

<script setup lang="ts">
import { computed, reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { Modal, message } from 'ant-design-vue'
import {
  StarFilled,
  MessageOutlined,
  EditOutlined,
  LockOutlined,
  UserOutlined,
  RightOutlined,
} from '@ant-design/icons-vue'
import { useUserStore } from '@/stores/user'
import { apiUpdateNicknameAndEmail, apiUpdatePassword, apiSaveUserAvatar, apiLogout } from '@/api/auth'

const router = useRouter()
const userStore = useUserStore()

const roleName = computed(() => {
  const names: Record<number, string> = { 2: '管理员', 1: '高级会员', 0: '普通用户' }
  return names[userStore.role] || '普通用户'
})

const profileModal = ref(false)
const profileLoading = ref(false)
const profileForm = reactive({ nickname: '', email: '' })

const passwordModal = ref(false)
const passwordLoading = ref(false)
const passwordForm = reactive({ oldPassword: '', password: '', newPassword: '' })

const avatarModal = ref(false)
const avatarLoading = ref(false)
const avatarForm = reactive({ avatar: '' })

const openProfileModal = () => {
  profileForm.nickname = userStore.userInfo?.nickname || ''
  profileForm.email = userStore.userInfo?.email || ''
  profileModal.value = true
}

const submitProfile = async () => {
  if (!profileForm.nickname) {
    message.warning('请输入昵称')
    return
  }
  profileLoading.value = true
  try {
    await apiUpdateNicknameAndEmail({ nickname: profileForm.nickname, email: profileForm.email })
    userStore.setUserInfo({ ...userStore.userInfo, nickname: profileForm.nickname, email: profileForm.email })
    message.success('资料修改成功')
    profileModal.value = false
  } finally {
    profileLoading.value = false
  }
}

const openPasswordModal = () => {
  passwordForm.oldPassword = ''
  passwordForm.password = ''
  passwordForm.newPassword = ''
  passwordModal.value = true
}

const submitPassword = async () => {
  const { oldPassword, password, newPassword } = passwordForm
  if (!oldPassword || !password || !newPassword) {
    message.warning('请填写完整信息')
    return
  }
  if (password !== newPassword) {
    message.warning('两次输入的新密码不一致')
    return
  }
  passwordLoading.value = true
  try {
    await apiUpdatePassword({ oldPassword, password, newPassword })
    message.success('密码修改成功')
    passwordModal.value = false
  } finally {
    passwordLoading.value = false
  }
}

const openAvatarModal = () => {
  avatarForm.avatar = userStore.userInfo?.avatar || ''
  avatarModal.value = true
}

const submitAvatar = async () => {
  if (!avatarForm.avatar) {
    message.warning('请输入头像 URL')
    return
  }
  avatarLoading.value = true
  try {
    await apiSaveUserAvatar({ avatar: avatarForm.avatar })
    userStore.setUserInfo({ ...userStore.userInfo, avatar: avatarForm.avatar })
    message.success('头像修改成功')
    avatarModal.value = false
  } finally {
    avatarLoading.value = false
  }
}

const handleLogout = () => {
  Modal.confirm({
    title: '确认退出登录？',
    content: '退出后需要重新登录才能继续刷题',
    okText: '退出',
    cancelText: '取消',
    onOk: async () => {
      try {
        await apiLogout()
      } catch (e) {
        
      }
      userStore.clear()
      message.success('已退出登录')
      router.push('/login')
    },
  })
}
</script>

<style scoped lang="scss">
.user-center {
  max-width: 1000px;
  margin: 0 auto;
}

.profile-header {
  position: relative;
  border-radius: 18px;
  padding: 34px 40px;
  overflow: hidden;
  background: var(--primary-light);
  border: 1px solid var(--border);

  .bg-glow-inner {
    position: absolute;
    inset: 0;

    .glow {
      position: absolute;
      border-radius: 50%;
      filter: blur(70px);
      opacity: 0.45;
    }

    .g1 {
      width: 320px;
      height: 320px;
      top: -140px;
      right: 5%;
      background: radial-gradient(circle, var(--primary-light), transparent 70%);
    }

    .g2 {
      width: 260px;
      height: 260px;
      bottom: -130px;
      left: 15%;
      background: radial-gradient(circle, var(--primary-light), transparent 70%);
    }

    .grid-overlay {
      display: none;
    }
  }

  .profile-inner {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    gap: 24px;

    .avatar-ring {
      border-radius: 50%;
      padding: 3px;
      background: var(--primary);
      box-shadow: var(--shadow-card);
      display: inline-flex;

      .avatar {
        border: 2px solid var(--page-bg);
      }

      .avatar-none {
        background: var(--primary);
        font-size: calc(32px + var(--font-offset, 0px));
        font-weight: 700;
      }
    }

    .user-info-box {
      .user-nickname {
        font-size: calc(26px + var(--font-offset, 0px));
        font-weight: 800;
        letter-spacing: 0.5px;
      }

      .identity-capsule {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        margin-top: 8px;
        padding: 4px 14px;
        background: var(--primary-light);
        border: 1px solid var(--primary);
        border-radius: 14px;

        .dot {
          width: 7px;
          height: 7px;
          border-radius: 50%;
          background: var(--primary);
        }

        .role-text {
          font-size: calc(13px + var(--font-offset, 0px));
          color: var(--text-title);
        }
      }
    }
  }
}

.neon-text {
  color: var(--text-title);
}

.body-content {
  margin-top: 24px;

  .row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
  }

  .panel {
    background: var(--card-bg);
    border: 1px solid var(--border);
    border-radius: 14px;
    padding: 20px 24px;
    box-shadow: var(--shadow-card);

    .panel-title {
      display: flex;
      align-items: center;
      gap: 10px;
      font-size: calc(15px + var(--font-offset, 0px));
      font-weight: 600;
      color: var(--text-title);
      padding-bottom: 12px;
      border-bottom: 1px solid var(--border);
      margin-bottom: 8px;

      .indicator {
        width: 4px;
        height: 16px;
        border-radius: 2px;
        background: var(--primary);
      }
    }

    .list-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 0;
      cursor: pointer;
      transition: all 0.25s;

      &:hover {
        padding-left: 6px;

        .label {
          color: var(--primary);
        }

        .arrow {
          color: var(--primary);
        }
      }

      .row-left {
        display: flex;
        align-items: center;
        gap: 12px;

        .icon-circle {
          width: 36px;
          height: 36px;
          border-radius: 10px;
          background: var(--card-bg);
          border: 1px solid var(--border);
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: calc(16px + var(--font-offset, 0px));

          &.fav {
            color: var(--warning);
            background: var(--warning-light);
            border-color: var(--warning);
          }

          &.feedback {
            color: var(--primary);
            background: var(--primary-light);
            border-color: var(--primary);
          }

          &.profile {
            color: var(--primary);
            background: var(--primary-light);
            border-color: var(--primary);
          }

          &.password {
            color: var(--error);
            background: var(--error-light);
            border-color: var(--error);
          }

          &.avatar-icon {
            color: var(--primary);
            background: var(--primary-light);
            border-color: var(--primary);
          }
        }

        .label {
          font-size: calc(14px + var(--font-offset, 0px));
          color: var(--text-body);
          transition: all 0.25s;
        }
      }

      .arrow {
        color: var(--text-muted);
        transition: all 0.25s;
      }
    }
  }

  .logout-btn {
    margin-top: 24px;
    max-width: 400px;

    .logout {
      border-radius: 12px;
      height: 46px;
      font-weight: 600;
      background: var(--error-light);
      border-color: var(--error);
      color: var(--error);

      &:hover {
        background: var(--error);
        border-color: var(--error);
        color: #fff;
      }
    }
  }
}
</style>
