<template>
	<view class="page-container">
		<view class="header-section" :style="{ background: themeConfig.bg }">
			<view class="user-info">
				<view class="greeting">
					<view class="time-row">
						<text class="time-text">{{ getTimeOfDay() }}好，</text>
						<view class="role-badge">{{ themeConfig.name }}</view>
					</view>
					<text class="nickname">{{ userInfo.nickname || userInfo.account || '同学' }}</text>
				</view>
			</view>
			<view class="stats-board">
				<view class="stats-item">
					<text class="label">今日已刷</text>
					<text class="value">{{ webHomeCount.todayTopicCount || 0 }}</text>
				</view>
				<view class="v-divider"></view>
				<view class="stats-item">
					<text class="label">今日次数</text>
					<text class="value">{{ webHomeCount.todayCount || 0 }}</text>
				</view>
				<view class="v-divider"></view>
				<view class="stats-item">
					<text class="label">累计数量</text>
					<view class="value-box">
						<text class="current" :style="{ color: themeConfig.accent }">{{ webHomeCount.totalTopicRecordCount || 0 }}</text>
						<text class="split">/</text>
						<text class="total">{{ webHomeCount.totalTopicCount || 0 }}</text>
					</view>
				</view>
			</view>
		</view>

		<view class="ranking-bar" @click="tapRanking">
			<view class="bar-left">
				<image class="medal-icon" src="../../static/images/zzjb.png" mode="aspectFit" />
				<view class="rank-text">
					<text class="main-rank">当前排名：第 {{ webHomeCount.rank || 0 }} 名</text>
					<text class="sub-rank">全站共 {{ webHomeCount.userCount || 0 }} 位活跃用户</text>
				</view>
			</view>
			<uni-icons type="right" size="14" color="#999"></uni-icons>
		</view>

		<view class="task-section">
			<view class="section-title">开始学习</view>
			<view class="task-grid">
				<view class="task-card primary" @click="navigateTo('/pages/database/database')">
					<view class="task-icon primary-icon">
						<uni-icons type="compose" size="20" color="#fff"></uni-icons>
					</view>
					<view class="task-content">
						<text class="task-name">真题刷题</text>
						<text class="task-desc">历年真题模拟练习</text>
					</view>
					<uni-icons type="right" size="14" color="#fff"></uni-icons>
				</view>
				<view class="task-card" @click="navigateTo('/pages/word/study/study')">
					<view class="task-icon vocab-icon">
						<uni-icons type="book" size="20" :color="themeConfig.accent"></uni-icons>
					</view>
					<view class="task-content">
						<text class="task-name">背单词</text>
						<text class="task-desc">CET核心词汇</text>
					</view>
					<uni-icons type="right" size="14" color="#999"></uni-icons>
				</view>
				<view class="task-card" @click="navigateTo('/pages/ai/ai')">
					<view class="task-icon ai-icon">
						<uni-icons type="chatbubble" size="20" :color="themeConfig.accent"></uni-icons>
					</view>
					<view class="task-content">
						<text class="task-name">AI 练习</text>
						<text class="task-desc">智能个性化学习</text>
					</view>
					<uni-icons type="right" size="14" color="#999"></uni-icons>
				</view>
			</view>
		</view>

		<view class="quick-section">
			<view class="section-title">更多功能</view>
			<view class="quick-grid">
				<view class="quick-item" @click="navigateTo('/pages/database/database?level=4')">
					<view class="quick-icon q1">
						<uni-icons type="compose" size="18" :color="themeConfig.accent"></uni-icons>
					</view>
					<text class="quick-text">四级真题</text>
				</view>
				<view class="quick-item" @click="navigateTo('/pages/database/database?level=6')">
					<view class="quick-icon q2">
						<uni-icons type="compose" size="18" :color="themeConfig.accent"></uni-icons>
					</view>
					<text class="quick-text">六级真题</text>
				</view>
				<view class="quick-item" @click="navigateTo('/pages/index/ranking/ranking')">
					<view class="quick-icon q3">
						<uni-icons type="star" size="18" :color="themeConfig.accent"></uni-icons>
					</view>
					<text class="quick-text">排行榜</text>
				</view>
				<view class="quick-item" @click="navigateTo('/pages/user/user')">
					<view class="quick-icon q4">
						<uni-icons type="person" size="18" :color="themeConfig.accent"></uni-icons>
					</view>
					<text class="quick-text">个人中心</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script setup>
	import { ref, computed, onMounted } from 'vue'
	import { getTimeOfDay } from '@/utils/time'
	import { apiQueryWebHomeCount } from '@/api/home/index'

	const webHomeCount = ref({})
	const userInfo = ref(JSON.parse(uni.getStorageSync('h5UserInfo') || '{}'))
	const role = ref(uni.getStorageSync('role') || 0)

	const initData = async () => {
		const resCount = await apiQueryWebHomeCount()
		if (resCount.code === 200) webHomeCount.value = resCount.data
	}

	onMounted(() => { initData() })

	const themeConfig = computed(() => {
		const configs = {
			2: { name: '管理员', accent: '#7585ff', bg: 'linear-gradient(135deg, #7585ff 0%, #75a7ff 100%)' },
			1: { name: '普通会员', accent: '#75caff', bg: 'linear-gradient(135deg, #75caff 0%, #75ecff 100%)' },
			0: { name: '普通用户', accent: '#75a7ff', bg: 'linear-gradient(135deg, #75a7ff 0%, #75ffef 100%)' }
		}
		return configs[role.value] || configs[0]
	})

	const navigateTo = (url) => { uni.navigateTo({ url }) }
	const tapRanking = () => { uni.navigateTo({ url: '/pages/index/ranking/ranking' }) }
</script>

<style lang="scss" scoped>
	.page-container {
		min-height: 100vh;
		background-color: #f7f8fa;
		padding-bottom: 50rpx;
	}

	.header-section {
		height: 280rpx;
		padding: 70rpx 40rpx 0;
		position: relative;
		border-radius: 0 0 8rpx 8rpx;

		.user-info {
			.greeting {
				.time-row {
					display: flex;
					align-items: center;
					margin-bottom: 6rpx;
					.time-text { font-size: 26rpx; color: rgba(255, 255, 255, 0.85); }
					.role-badge {
						margin-left: 12rpx;
						padding: 2rpx 14rpx;
						background: rgba(255, 255, 255, 0.15);
						border-radius: 4rpx;
						font-size: 18rpx;
						color: #fff;
					}
				}
				.nickname { font-size: 44rpx; font-weight: bold; color: #fff; }
			}
		}
	}

	.stats-board {
		position: absolute;
		bottom: -50rpx;
		left: 30rpx;
		right: 30rpx;
		background: #fff;
		border-radius: 8rpx;
		display: flex;
		padding: 34rpx 0;
		z-index: 10;

		.stats-item {
			flex: 1;
			display: flex;
			flex-direction: column;
			align-items: center;
			.label { font-size: 22rpx; color: #999; margin-bottom: 8rpx; }
			.value { font-size: 36rpx; font-weight: bold; color: #333; line-height: 1; }
			.value-box {
				display: flex;
				align-items: baseline;
				line-height: 1;
				.current { font-size: 36rpx; font-weight: bold; }
				.split { font-size: 22rpx; color: #cbd5e1; margin: 0 4rpx; }
				.total { font-size: 22rpx; color: #999; font-weight: 500; }
			}
		}

		.v-divider { width: 1px; height: 32rpx; background: #f0f0f0; align-self: center; }
	}

	.ranking-bar {
		margin: 90rpx 30rpx 40rpx;
		background: #fff;
		padding: 26rpx 30rpx;
		border-radius: 8rpx;
		display: flex;
		justify-content: space-between;
		align-items: center;

		.bar-left {
			display: flex;
			align-items: center;
			.medal-icon { width: 44rpx; height: 44rpx; margin-right: 20rpx; }
			.rank-text {
				display: flex;
				flex-direction: column;
				.main-rank { font-size: 26rpx; color: #333; font-weight: 500; }
				.sub-rank { font-size: 20rpx; color: #bbb; margin-top: 2rpx; }
			}
		}
	}

	.section-title {
		font-size: 32rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 20rpx;
	}

	.task-section {
		padding: 0 30rpx;
		margin-bottom: 40rpx;

		.task-grid {
			display: flex;
			flex-direction: column;
			gap: 16rpx;
		}

		.task-card {
			display: flex;
			align-items: center;
			background: #fff;
			border-radius: 8rpx;
			padding: 28rpx;

			&.primary {
				background: linear-gradient(135deg, #75a7ff, #7585ff);
				.task-icon.primary-icon { background: rgba(255, 255, 255, 0.2); }
				.task-name { color: #fff; }
				.task-desc { color: rgba(255, 255, 255, 0.8); }
			}

			.task-icon {
				width: 76rpx;
				height: 76rpx;
				border-radius: 12rpx;
				display: flex;
				align-items: center;
				justify-content: center;
				margin-right: 24rpx;
				flex-shrink: 0;
				&.primary-icon { background: rgba(255, 255, 255, 0.2); }
				&.vocab-icon { background: rgba(117, 236, 255, 0.15); }
				&.ai-icon { background: rgba(117, 167, 255, 0.15); }
			}

			.task-content {
				flex: 1;
				.task-name { font-size: 30rpx; font-weight: bold; color: #333; display: block; }
				.task-desc { font-size: 24rpx; color: #999; display: block; margin-top: 4rpx; }
			}
		}
	}

	.quick-section {
		padding: 0 30rpx;

		.quick-grid {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			gap: 16rpx;

			.quick-item {
				display: flex;
				flex-direction: column;
				align-items: center;
				background: #fff;
				border-radius: 8rpx;
				padding: 28rpx 10rpx;

				.quick-icon {
					width: 68rpx;
					height: 68rpx;
					border-radius: 12rpx;
					display: flex;
					align-items: center;
					justify-content: center;
					margin-bottom: 12rpx;
					&.q1 { background: rgba(117, 236, 255, 0.15); }
					&.q2 { background: rgba(117, 202, 255, 0.15); }
					&.q3 { background: rgba(117, 255, 239, 0.15); }
					&.q4 { background: rgba(117, 167, 255, 0.15); }
				}

				.quick-text { font-size: 24rpx; color: #666; text-align: center; }
			}
		}
	}
</style>
