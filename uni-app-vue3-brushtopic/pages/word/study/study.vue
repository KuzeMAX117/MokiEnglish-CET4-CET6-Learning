<template>
	<view class="study-page">
		<view class="top-bar">
			<view class="progress">
				<text class="progress-text">今日进度 {{ currentIndex + 1 }}/{{ words.length }}</text>
				<view class="progress-bar">
					<view class="progress-fill" :style="{ width: progressWidth }"></view>
				</view>
			</view>
			<text class="change-book" @click="goSelectBook">更换词书</text>
		</view>

		<view class="card-area" v-if="currentWord">
			<view class="word-card" @click="showDetail = true">
				<view class="word-main">
					<text class="word-text">{{ currentWord.word }}</text>
					<text class="phonetic">{{ currentWord.phonetic || ' ' }}</text>
				</view>
				<text class="tap-tip" v-if="!showDetail">点击卡片显示释义</text>
			</view>

			<view class="detail-panel" v-if="showDetail">
				<view class="detail-item">
					<text class="detail-label">释义</text>
					<text class="detail-content meaning">{{ currentWord.meaning || '暂无释义' }}</text>
				</view>
				<view class="detail-item" v-if="showSyllable && currentWord.syllableWord">
					<text class="detail-label">音节</text>
					<text class="detail-content syllable">{{ currentWord.syllableWord }}</text>
				</view>
				<view class="detail-item" v-if="currentWord.phrase">
					<text class="detail-label">组词</text>
					<text class="detail-content">{{ currentWord.phrase }}</text>
				</view>
				<view class="detail-item" v-if="showExample && currentWord.example">
					<text class="detail-label">例句</text>
					<text class="detail-content example" v-html="currentWord.example"></text>
					<text class="detail-content example-trans" v-if="currentWord.exampleTranslate">{{ currentWord.exampleTranslate }}</text>
				</view>
			</view>
		</view>

		<view class="empty-area" v-else-if="!loading">
			<uv-empty text="今日单词已学完" mode="car"></uv-empty>
			<button class="action-btn primary" @click="goSelectBook">更换词书</button>
		</view>

		<view class="action-area" v-if="currentWord">
			<button class="action-btn setting" @click="openSetting">设置</button>
			<button class="action-btn secondary" @click="handleResult(false)">不认识</button>
			<button class="action-btn primary" @click="handleResult(true)">认识</button>
		</view>

		<uni-popup ref="settingPopup" type="bottom">
			<view class="setting-popup">
				<view class="setting-title">显示设置</view>
				<view class="setting-item">
					<text>音节展示</text>
					<switch :checked="showSyllable" @change="showSyllable = $event.detail.value" color="#1677ff"></switch>
				</view>
				<view class="setting-item">
					<text>例句展示</text>
					<switch :checked="showExample" @change="showExample = $event.detail.value" color="#1677ff"></switch>
				</view>
				<button class="setting-close" @click="closeSetting">关闭</button>
			</view>
		</uni-popup>
	</view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { apiGetTodayWords, apiSubmitWordResult, apiGetWordSetting } from '@/api/word/index.js'

const words = ref([])
const currentIndex = ref(0)
const showDetail = ref(false)
const loading = ref(true)
const showSyllable = ref(false)
const showExample = ref(true)
const settingPopup = ref(null)

const currentWord = computed(() => {
	if (words.value.length === 0) return null
	return words.value[currentIndex.value]
})

const progressWidth = computed(() => {
	if (words.value.length === 0) return '0%'
	return ((currentIndex.value + 1) / words.value.length) * 100 + '%'
})

onMounted(() => {
	loadData()
})

const loadData = async () => {
	loading.value = true
	try {
		const [wordsRes, settingRes] = await Promise.all([
			apiGetTodayWords(),
			apiGetWordSetting()
		])
		if (!settingRes.data) {
			uni.reLaunch({ url: '/pages/word/book/book' })
			return
		}
		words.value = wordsRes.data || []
		currentIndex.value = 0
		showDetail.value = false
	} catch (e) {
		console.error('load today words error', e)
	} finally {
		loading.value = false
	}
}

const openSetting = () => {
	settingPopup.value.open()
}

const closeSetting = () => {
	settingPopup.value.close()
}

const handleResult = async (known) => {
	if (!currentWord.value) return
	try {
		await apiSubmitWordResult({
			wordId: currentWord.value.id,
			known
		})
	} catch (e) {
		console.error('submit word result error', e)
	}

	showDetail.value = false
	if (currentIndex.value < words.value.length - 1) {
		currentIndex.value++
	} else {
		uni.showModal({
			title: '完成',
			content: '恭喜完成今日学习任务！',
			showCancel: false,
			success: () => {
				uni.reLaunch({ url: '/pages/word/book/book' })
			}
		})
	}
}

const goSelectBook = () => {
	uni.reLaunch({ url: '/pages/word/book/book' })
}
</script>

<style lang="scss" scoped>
.study-page {
	min-height: 100vh;
	background-color: #F3F4F6;
	padding: 30rpx;
	padding-bottom: 160rpx;
}

.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30rpx;

	.progress {
		flex: 1;

		.progress-text {
			font-size: 26rpx;
			color: #6B7280;
			display: block;
			margin-bottom: 12rpx;
		}

		.progress-bar {
			width: 80%;
			height: 12rpx;
			background: #E5E7EB;
			border-radius: 6rpx;
			overflow: hidden;

			.progress-fill {
				height: 100%;
				background: #1677ff;
				border-radius: 6rpx;
				transition: width 0.3s ease;
			}
		}
	}

	.change-book {
		font-size: 26rpx;
		color: #1677ff;
		padding: 12rpx 20rpx;
		background: #fff;
		border-radius: 30rpx;
		box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.04);
	}
}

.card-area {
	margin-bottom: 40rpx;
}

.word-card {
	background: #fff;
	border-radius: 24rpx;
	padding: 80rpx 40rpx;
	text-align: center;
	box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.06);
	margin-bottom: 24rpx;

	.word-main {
		margin-bottom: 24rpx;

		.word-text {
			font-size: 56rpx;
			font-weight: bold;
			color: #111827;
			display: block;
			margin-bottom: 16rpx;
			word-break: break-all;
		}

		.phonetic {
			font-size: 32rpx;
			color: #1677ff;
			display: block;
		}
	}

	.tap-tip {
		font-size: 24rpx;
		color: #9CA3AF;
	}
}

.detail-panel {
	background: #fff;
	border-radius: 24rpx;
	padding: 40rpx;
	box-shadow: 0 8rpx 32rpx rgba(0, 0, 0, 0.06);

	.detail-item {
		margin-bottom: 32rpx;

		&:last-child {
			margin-bottom: 0;
		}

		.detail-label {
			font-size: 26rpx;
			color: #1677ff;
			font-weight: 600;
			display: block;
			margin-bottom: 12rpx;
		}

		.detail-content {
			font-size: 30rpx;
			color: #374151;
			line-height: 1.6;
			display: block;

			&.meaning {
				font-size: 32rpx;
				font-weight: 500;
			}

			&.syllable {
				font-size: 40rpx;
				color: #1677ff;
				letter-spacing: 2rpx;
			}

			&.example {
				font-style: italic;
				margin-bottom: 8rpx;
			}

			&.example-trans {
				color: #6B7280;
				font-size: 28rpx;
			}
		}
	}
}

.empty-area {
	padding-top: 200rpx;
	text-align: center;

	.action-btn {
		margin-top: 60rpx;
	}
}

.action-area {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	padding: 30rpx;
	background: #fff;
	box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.05);
	display: flex;
	gap: 16rpx;
}

.action-btn {
	flex: 1;
	height: 88rpx;
	line-height: 88rpx;
	font-size: 28rpx;
	font-weight: 600;
	border-radius: 44rpx;
	border: none;
	padding: 0;

	&::after {
		border: none;
	}

	&.setting {
		background: #E5E7EB;
		color: #374151;
		flex: 0.8;
	}

	&.primary {
		background: #1677ff;
		color: #fff;
	}

	&.secondary {
		background: #F3F4F6;
		color: #374151;
	}
}

.setting-popup {
	background: #fff;
	border-radius: 24rpx 24rpx 0 0;
	padding: 40rpx;

	.setting-title {
		font-size: 34rpx;
		font-weight: bold;
		text-align: center;
		margin-bottom: 40rpx;
	}

	.setting-item {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 30rpx 0;
		border-bottom: 1rpx solid #F3F4F6;
		font-size: 30rpx;
		color: #111827;
	}

	.setting-close {
		margin-top: 40rpx;
		height: 88rpx;
		line-height: 88rpx;
		background: #1677ff;
		color: #fff;
		font-size: 32rpx;
		border-radius: 44rpx;
		border: none;

		&::after {
			border: none;
		}
	}
}
</style>
