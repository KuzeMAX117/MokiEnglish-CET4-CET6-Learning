<script setup>
import {
	ref,
	reactive,

} from 'vue'
import { apiLogin, apiSendEmail, apiResetPassword, apiRegister } from '@/api/auth'

const loginWay = ref(0)

const isRegister = ref(false)

const isForget = ref(false)

const loginForm = reactive({
	account: '',
	password: '',
	email: '',
})

const registerForm = reactive({
	account: '',
	nickname: '',
	password: '',
	code: ''
})

const email = ref(null)

const forgetForm = reactive({
	code: '',
	password: '',
	newPassword: ''
})

const getCode = async () => {
	
	if (!email.value) {
		return uni.showToast({
			title: '请输入QQ邮箱',
			icon: 'none'
		})
	}
	
	if (!/^[a-zA-Z0-9_-]+@qq.com$/.test(email.value)) {
		return uni.showToast({
			title: '请输入正确QQ邮箱',
			icon: 'none'
		})
	}
	
	await apiSendEmail(email.value)
	uni.showToast({
		title: '邮件已发送5分钟内有效',
		icon: 'success'
	})
}

const backLogin = () => {
	isRegister.value = false
	isForget.value = false
	
	registerForm.account = ''
	registerForm.nickname = ''
	registerForm.password = ''
	registerForm.code = ''
	forgetForm.code = ''
	forgetForm.password = ''
	forgetForm.newPassword = ''
	email.value = null
}

const handleLogin = async () => {
	if (loginWay.value === 0) {
		
		if (!loginForm.account || !loginForm.password) {
			return uni.showToast({
				title: '请输入账户名称和密码',
				icon: 'none'
			})
		}
	} else {
		
		if (!loginForm.email || !loginForm.password) {
			return uni.showToast({
				title: '请输入邮箱和密码',
				icon: 'none'
			})
		}
	}
	
	uni.showLoading({
		title: '登录中...',
		mask: true
	})
	
	const res = await apiLogin({
		loginType: loginWay.value,
		...loginForm
	})
	if (res.code === 201) {
		uni.showToast({
			title: '登录失败',
			icon: 'error'
		})
		return
	}
	
	const userInfo = JSON.parse(res.data.userInfo)
	localStorage.setItem('h5UserInfo', res.data.userInfo)
	
	localStorage.setItem(userInfo.account + 'token', res.data.token)
	
	localStorage.setItem("role", res.data.role)
	uni.hideLoading()
	uni.showToast({
		title: '登录成功',
		duration: 2000
	});
	
	uni.reLaunch({
		url: "/pages/index/index",
		success: () => { }
	})
}

const clearDefault = () => {
	loginForm.account = ''
	loginForm.email = ''
	loginForm.password = ''
	loginWay.value = loginWay.value === 0 ? 1 : 0
}

const showNewPassword = ref(false)
const showConfirmPassword = ref(false)
const showOldPassword = ref(false)

const handleForget = () => {
	isForget.value = true
	loginForm.account = ''
	loginForm.email = ''
	loginForm.password = ''
}

const handleForgetSubmit = async () => {
	
	if (!forgetForm.code || !forgetForm.password || !forgetForm.newPassword || email.value === '') {
		return uni.showToast({
			title: '请输入完整信息',
			icon: 'none'
		})
	}
	
	await apiResetPassword({
		...forgetForm,
		email: email.value
	})
	uni.showToast({
		title: '密码重置成功',
		icon: 'success'
	})
	backLogin()
}

const handleRegisterSubmit = async () => {
	if (!email.value) {
		return uni.showToast({
			title: '请输入QQ邮箱',
			icon: 'none'
		})
	}
	if (!/^[a-zA-Z0-9_-]+@qq.com$/.test(email.value)) {
		return uni.showToast({
			title: '请输入正确QQ邮箱',
			icon: 'none'
		})
	}
	if (!registerForm.account) {
		return uni.showToast({
			title: '请输入唯一账户名称',
			icon: 'none'
		})
	}
	if (!registerForm.code) {
		return uni.showToast({
			title: '请输入验证码',
			icon: 'none'
		})
	}
	
	await apiRegister({
		...registerForm,
		email: email.value
	})
	uni.showToast({
		title: '注册成功',
		icon: 'success'
	})
	backLogin()
}
</script>
<template>
	<view class="login-content">
		
		<view class="bg-animation">
			<view class="circle"></view>
			<view class="circle"></view>
		</view>

		
		<view class="content-box">
			
			<view class="logo-area">
				<image src="/static/images/logo.png" mode="aspectFit" class="logo-img"></image>
				<text class="slogan">AI陪你刷题，刷题不枯燥</text>
			</view>

			
			<view class="input-box">
				<uv-input class="input" v-if="loginWay === 0" shape="circle" placeholder="请输入账户名称"
					v-model="loginForm.account"></uv-input>
				<uv-input class="input" v-else shape="circle" placeholder="请输入QQ邮箱" v-model="loginForm.email"></uv-input>
				<uv-input class="input" :type="showOldPassword ? 'text' : 'password'" shape="circle" placeholder="请输入密码"
					v-model="loginForm.password">
					
					<template v-slot:suffix>
						<uni-icons :type="showOldPassword ? 'eye-filled' : 'eye-slash-filled'" size="20" color="#999"
							@click="showOldPassword = !showOldPassword"></uni-icons>
					</template>
				</uv-input>
				<button @click="handleLogin" class="login-btn" hover-class="btn-hover">开始刷题</button>
				<view class="action-row">
					<text @click="handleForget()">忘记密码</text>
					<text @click="clearDefault()">
						{{ loginWay === 0 ? 'QQ邮箱登录' : '账户登录' }}
					</text>
				</view>
			</view>

			
			<view class="register-form" v-if="isRegister">
				<view class="form-title">
					<text class="title">加入AI刷题</text>
					<text class="back" @click="backLogin">返回登录</text>
				</view>
				<view class="input-group">
					<uv-input class="input" maxlength="8" shape="circle" placeholder="创建你的专属账户 (注册后不可更改)"
						v-model="registerForm.account"></uv-input>
					<uv-input class="input" maxlength="8" shape="circle" placeholder="给自己起个独特的昵称"
						v-model="registerForm.nickname"></uv-input>
					<uv-input class="input" shape="circle" placeholder="请输入QQ邮箱" v-model="email">
						
						<template v-slot:suffix>
							<text @click="getCode()">
								发送验证码</text>
						</template>
					</uv-input>
					<uv-input class="input" shape="circle" placeholder="请输入验证码" v-model="registerForm.code" maxlength="6">
					</uv-input>
					<uv-input class="input" :type="showNewPassword ? 'text' : 'password'" shape="circle" placeholder="请输入登录密码"
						v-model="registerForm.password">
						
						<template v-slot:suffix>
							<uni-icons :type="showNewPassword ? 'eye-filled' : 'eye-slash-filled'" size="20" color="#999"
								@click="showNewPassword = !showNewPassword"></uni-icons>
						</template>
					</uv-input>
				</view>
				<button class="register-submit-btn" hover-class="btn-hover" @click="handleRegisterSubmit">开启AI刷题之旅</button>
			</view>

			
			<view class="forget-form" v-if="isForget">
				<view class="form-title">
					<text class="title">重置密码</text>
					<text class="back" @click="backLogin">返回登录</text>
				</view>
				<view class="input-group">
					<uv-input class="input" shape="circle" placeholder="请输入QQ邮箱" v-model="email">
						<template v-slot:suffix>
							<text @click="getCode()">
								发送验证码
							</text>
						</template>
					</uv-input>
					<uv-input class="input" shape="circle" placeholder="请输入验证码" v-model="forgetForm.code" maxlength="6">
					</uv-input>
					<uv-input class="input" :type="showNewPassword ? 'text' : 'password'" shape="circle" placeholder="请输入新密码"
						v-model="forgetForm.password">
						
						<template v-slot:suffix>
							<uni-icons :type="showNewPassword ? 'eye-filled' : 'eye-slash-filled'" size="20" color="#999"
								@click="showNewPassword = !showNewPassword"></uni-icons>
						</template>
					</uv-input>
					<uv-input class="input" :type="showConfirmPassword ? 'text' : 'password'" shape="circle" placeholder="请确认新密码"
						v-model="forgetForm.newPassword">
						
						<template v-slot:suffix>
							<uni-icons :type="showConfirmPassword ? 'eye-filled' : 'eye-slash-filled'" size="20" color="#999"
								@click="showConfirmPassword = !showConfirmPassword"></uni-icons>
						</template>
					</uv-input>
				</view>
				<button class="forget-submit-btn" hover-class="btn-hover" @click="handleForgetSubmit">确认修改</button>
			</view>
			
			<view class="register-box">
				<text>还没有刷题过？</text>
				<text class="register-btn" @click="isRegister = true">立即注册</text>
			</view>
		</view>
	</view>
</template>

<style lang="scss" scoped>
.login-content {
	min-height: 100vh;
	background: linear-gradient(to bottom, #f0f7ff, #ffffff);
	position: relative;
	overflow: hidden;

	.bg-animation {
		position: absolute;
		width: 100%;
		height: 100%;
		z-index: 1;

		.circle {
			position: absolute;
			border-radius: 50%;
			background: linear-gradient(45deg, rgba(22, 119, 255, 0.1), rgba(22, 119, 255, 0.05));

			&:nth-child(1) {
				width: 300rpx;
				height: 300rpx;
				top: -100rpx;
				left: -100rpx;
				animation: float 8s infinite;
			}

			&:nth-child(2) {
				width: 200rpx;
				height: 200rpx;
				bottom: -50rpx;
				right: -50rpx;
				animation: float 6s infinite reverse;
			}
		}
	}

	.content-box {
		position: relative;
		z-index: 2;
		padding: 60rpx 40rpx;
		display: flex;
		flex-direction: column;
		justify-content: space-between; 
		height: calc(100vh - 140rpx); 

		.register-box {
			margin-top: auto;
			padding-bottom: 50rpx;
			text-align: center;

			text {
				font-size: 30rpx;
				color: #666;
			}

			.register-btn {
				color: #1677ff;
				margin-left: 10rpx;
				font-weight: 500;
			}
		}
	}

	.logo-area {
		text-align: center;
		padding-top: 300rpx;

		.logo-img {
			position: absolute;
			width: 600rpx;
			height: 600rpx;
			left: 50%;
			top: -80rpx; 
			transform: translateX(-50%);
			object-fit: cover;
			z-index: 0; 
		}

		.welcome {
			font-size: 46rpx;
			font-weight: bold;
			color: #1677ff;
			margin-bottom: 20rpx;
			display: block;
		}

		.slogan {
			font-size: 30rpx;
			color: #666;
		}
	}

	.input-box {
		margin-top: 60rpx;

		.input {
			height: 60rpx;
			background-color: #fff;
			margin-top: 15px;
		}

		.login-btn {
			background: #1677ff;
			color: #fff;
			height: 90rpx;
			line-height: 90rpx;
			border-radius: 45rpx;
			font-size: 32rpx;
			margin-top: 46rpx;
			box-shadow: 0 8rpx 20rpx rgba(22, 119, 255, 0.3);
			transition: all 0.3s;
		}

		.btn-hover {
			transform: translateY(2rpx);
			box-shadow: 0 4rpx 10rpx rgba(22, 119, 255, 0.2);
		}

		.action-row {
			display: flex;
			justify-content: space-between;
			margin-top: 30rpx;
			padding: 0 20rpx;

			text {
				color: #1677ff;
				font-size: 30rpx;
			}
		}
	}

	.other-login {
		margin-top: 100rpx;
		text-align: center;

		.divider {
			position: relative;
			margin-bottom: 40rpx;

			&::before,
			&::after {
				content: '';
				position: absolute;
				top: 50%;
				width: 20%;
				height: 1rpx;
				background: #e5e5e5;
			}

			&::before {
				left: 20%;
			}

			&::after {
				right: 20%;
			}

			text {
				color: #999;
				font-size: 24rpx;
				background: #f0f7ff;
				padding: 0 30rpx;
			}
		}

		.qq-login {
			display: inline-block;
			padding: 20rpx;
			border-radius: 50%;
			background: rgba(255, 255, 255, 0.8);
			box-shadow: 0 4rpx 20rpx rgba(0, 0, 0, 0.05);

			image {
				width: 60rpx;
				height: 60rpx;
			}
		}
	}
}

@keyframes float {

	0%,
	100% {
		transform: translateY(0);
	}

	50% {
		transform: translateY(-20rpx);
	}
}

.register-form {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100vh;
	background: linear-gradient(to bottom, #f0f7ff, #ffffff);
	z-index: 100;
	padding: 60rpx 40rpx;
	box-sizing: border-box;

	.form-title {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 60rpx;

		.title {
			font-size: 40rpx;
			font-weight: bold;
			color: #1677ff;
		}

		.back {
			color: #666;
			font-size: 28rpx;
		}
	}

	.input-group {

		.input {
			height: 60rpx;
			background-color: #fff;
			margin-bottom: 30rpx;
		}
	}

	.register-submit-btn {
		background: #1677ff;
		color: #fff;
		height: 90rpx;
		line-height: 90rpx;
		border-radius: 45rpx;
		font-size: 32rpx;
		margin-top: 60rpx;
		box-shadow: 0 8rpx 20rpx rgba(22, 119, 255, 0.3);
		transition: all 0.3s;

		&.btn-hover {
			transform: translateY(2rpx);
			box-shadow: 0 4rpx 10rpx rgba(22, 119, 255, 0.2);
		}
	}
}

.forget-form {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100vh;
	background: linear-gradient(to bottom, #f0f7ff, #ffffff);
	z-index: 100;
	padding: 60rpx 40rpx;
	box-sizing: border-box;

	.form-title {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 60rpx;

		.title {
			font-size: 40rpx;
			font-weight: bold;
			color: #1677ff;
		}

		.back {
			color: #666;
			font-size: 28rpx;
		}
	}

	.input-group {
		.input {
			height: 60rpx;
			background-color: #fff;
			margin-bottom: 30rpx;
		}
	}

	.forget-submit-btn {
		background: #1677ff;
		color: #fff;
		height: 90rpx;
		line-height: 90rpx;
		border-radius: 45rpx;
		font-size: 32rpx;
		margin-top: 60rpx;
		box-shadow: 0 8rpx 20rpx rgba(22, 119, 255, 0.3);
		transition: all 0.3s;

		&.btn-hover {
			transform: translateY(2rpx);
			box-shadow: 0 4rpx 10rpx rgba(22, 119, 255, 0.2);
		}
	}
}
</style>