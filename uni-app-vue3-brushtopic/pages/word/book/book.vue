<template>
	<view class="book-page">
		<view class="header">
			<text class="title">选择词书</text>
			<text class="sub-title">选择适合你的词书，开始高效背单词</text>
		</view>

		<view class="book-list">
			<view
				class="book-card"
				v-for="book in books"
				:key="book.id"
				:class="{ active: selectedBookId === book.id }"
				@click="selectedBookId = book.id"
			>
				<view class="book-info">
					<text class="book-name">{{ book.name }}</text>
					<text class="book-count">共 {{ book.totalCount || 0 }} 词</text>
				</view>
				<view class="check-icon" v-if="selectedBookId === book.id">
					<uni-icons type="checkbox-filled" size="24" color="#1677ff"></uni-icons>
				</view>
			</view>
		</view>

		<view class="setting-section">
			<text class="setting-title">每日背诵量</text>
			<view class="count-display">
				<text class="count-value">{{ dailyCount }}</text>
				<text class="count-unit">个/天</text>
			</view>
			<slider
				class="count-slider"
				:value="dailyCount"
				@change="handleSliderChange"
				:min="10"
				:max="100"
				:step="5"
				:activeColor="#1677ff"
				:block-size="20"
			/>
			<view class="count-range">
				<text>10</text>
				<text>100</text>
			</view>
		</view>

		<view class="footer">
			<button class="start-btn" @click="confirmSelect">开始背单词</button>
		</view>
	</view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { apiGetBooks, apiSelectBook, apiGetWordSetting } from '@/api/word/index.js'

const books = ref([])
const selectedBookId = ref(null)
const dailyCount = ref(20)

onMounted(() => {
	loadData()
})

const loadData = async () => {
	try {
		const [booksRes, settingRes] = await Promise.all([
			apiGetBooks(),
			apiGetWordSetting()
		])
		books.value = booksRes.data || []
		if (settingRes.data) {
			selectedBookId.value = settingRes.data.bookId
			dailyCount.value = settingRes.data.dailyCount
		} else if (books.value.length > 0) {
			selectedBookId.value = books.value[0].id
		}
	} catch (e) {
		console.error('load word books error', e)
	}
}

const handleSliderChange = (e) => {
	dailyCount.value = e.detail.value
}

const confirmSelect = async () => {
	if (!selectedBookId.value) {
		uni.showToast({ title: '请选择词书', icon: 'none' })
		return
	}
	try {
		uni.showLoading({ title: '保存中' })
		await apiSelectBook({
			bookId: selectedBookId.value,
			dailyCount: dailyCount.value
		})
		uni.hideLoading()
		uni.reLaunch({ url: '/pages/word/study/study' })
	} catch (e) {
		uni.hideLoading()
		uni.showToast({ title: '保存失败', icon: 'none' })
	}
}
</script>

<style lang="scss" scoped>
.book-page {
	min-height: 100vh;
	background-color: #F3F4F6;
	padding-bottom: 160rpx;
}

.header {
	padding: 60rpx 40rpx 40rpx;
	background: linear-gradient(135deg, #1677ff 0%, #40a9ff 100%);

	.title {
		font-size: 48rpx;
		font-weight: bold;
		color: #fff;
		display: block;
	}

	.sub-title {
		font-size: 28rpx;
		color: rgba(255, 255, 255, 0.8);
		margin-top: 12rpx;
		display: block;
	}
}

.book-list {
	padding: 30rpx;

	.book-card {
		background: #fff;
		border-radius: 20rpx;
		padding: 32rpx;
		margin-bottom: 24rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);
		border: 2rpx solid transparent;

		&.active {
			border-color: #1677ff;
			background: #f0f7ff;
		}

		.book-info {
			.book-name {
				font-size: 34rpx;
				font-weight: 600;
				color: #111827;
				display: block;
			}

			.book-count {
				font-size: 26rpx;
				color: #6B7280;
				margin-top: 8rpx;
				display: block;
			}
		}
	}
}

.setting-section {
	margin: 0 30rpx;
	background: #fff;
	border-radius: 20rpx;
	padding: 40rpx;
	box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.04);

	.setting-title {
		font-size: 32rpx;
		font-weight: 600;
		color: #111827;
		display: block;
		margin-bottom: 30rpx;
	}

	.count-display {
		display: flex;
		align-items: baseline;
		justify-content: center;
		margin-bottom: 30rpx;

		.count-value {
			font-size: 72rpx;
			font-weight: bold;
			color: #1677ff;
		}

		.count-unit {
			font-size: 28rpx;
			color: #6B7280;
			margin-left: 12rpx;
		}
	}

	.count-slider {
		margin: 0;
	}

	.count-range {
		display: flex;
		justify-content: space-between;
		font-size: 24rpx;
		color: #9CA3AF;
		margin-top: 12rpx;
	}
}

.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	padding: 30rpx;
	background: #fff;
	box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.05);

	.start-btn {
		width: 100%;
		height: 88rpx;
		line-height: 88rpx;
		background: #1677ff;
		color: #fff;
		font-size: 32rpx;
		font-weight: 600;
		border-radius: 44rpx;
		border: none;

		&::after {
			border: none;
		}
	}
}
</style>
