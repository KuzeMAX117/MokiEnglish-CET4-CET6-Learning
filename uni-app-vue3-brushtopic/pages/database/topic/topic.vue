<script setup>
import {
	ref
} from 'vue'
import {
	onLoad
} from '@dcloudio/uni-app'
import { apiQuerySubjectDetail } from '@/api/topic/subject'
import { apiQueryTopicDetail, apiCountTopic, apiQueryTopicAnswer, apiCollectionTopic } from '@/api/topic/topic'
import { apiSendFeedback } from '@/api/system/feedback'

import FeedbackPopup from '@/components/feedbackPopup.vue'
onLoad(async (options) => {
	
	console.log(options.name);
	console.log(options.id);
	console.log(options.subjectId);
	currentTopicId.value = options.id
	currentSubjectId.value = options.subjectId
	
	uni.setNavigationBarTitle({
		title: options.name
	})
	
	uni.showLoading({
		title: '加载中...',
		mask: true
	})
	try {
		
		await Promise.all([
			getTopicList(options.subjectId),
			getTopicDetail(options.id),
			countTopic()
		])
	} catch (error) {
		console.error('加载失败:', error)
		uni.showToast({
			title: '加载失败，请重试',
			icon: 'none'
		})
	} finally {
		uni.hideLoading()
	}
})

const userInfo = ref(JSON.parse(uni.getStorageSync('h5UserInfo')))

const countTopic = async () => {
	await apiCountTopic({
		topicId: currentTopicId.value,
		subjectId: currentSubjectId.value,
		nickname: userInfo.value.nickname,
		avatar: userInfo.value.avatar,
	})
}

const subjcetDetail = ref({})

const currentIndex = ref(null)

const currentTopicId = ref(null)

const currentSubjectId = ref(null)

const total = ref(0)

const progressPercent = ref(0)

const getTopicList = async (subjectId) => {
	const res = await apiQuerySubjectDetail(subjectId)
	if (res.data) {
		if (res.data.topicNameVos) {
			subjcetDetail.value = res.data.topicNameVos
			total.value = res.data.topicNameVos.length
			
			currentIndex.value = res.data.topicNameVos.findIndex(item => item.id == currentTopicId.value)
			currentIndex.value = currentIndex.value + 1
			
			progressPercent.value = Math.floor((currentIndex.value / total.value) * 100)
		}
	}

}

const topicDetail = ref({})

const getTopicDetail = async (id) => {
	const res = await apiQueryTopicDetail(id)
	topicDetail.value = res.data
	isCollected.value = res.data.isCollected
}

const isTabs = ref(true)

const isShowAnswer = ref(false)

const answer = ref({
	answer: null,
	aiAnswer: null
})

const role = ref(uni.getStorageSync('role'))

const showAnswer = async () => {
	console.log('查看答案');

	
	if (topicDetail.value.isMember === 1 && role.value == 0) {
		uni.showToast({
			title: '该题目答案需要会员才能查看哦',
			icon: 'error',
			duration: 2000
		});
		return;
	}

	
	const res = await apiQueryTopicAnswer(currentTopicId.value);
	answer.value = res.data;

	
	markDownContent.value = isTabs.value ? res.data.answer : res.data.aiAnswer;

	
	isShowAnswer.value = true;
}

const markDownContent = ref()

const handleTabs = () => {
	isTabs.value = !isTabs.value
	if (isTabs.value) {
		markDownContent.value = answer.value.answer
	} else {
		markDownContent.value = answer.value.aiAnswer
	}
}

const showFeedback = ref(false)

const handleFeedbackSubmit = async (content) => {
	await apiSendFeedback({
		feedbackContent: "题目" + currentTopicId.value + ":" + content,
		status: 3
	})
	uni.showToast({
		title: '反馈成功可在我的反馈中查看',
		icon: 'none',
		duration: 2000
	})
}

const isCollected = ref(false)

const handleCollect = async () => {
	try {
		const res = await apiCollectionTopic(currentTopicId.value)
		if (res.code === 200) {
			isCollected.value = !isCollected.value
			uni.showToast({
				title: isCollected.value ? '收藏成功' : '取消收藏',
				icon: 'success'
			})
		}
	} catch (error) {
		uni.showToast({
			title: '操作失败，请重试',
			icon: 'none'
		})
	}
}

const showRight = ref()

const prevTopic = async () => {
	
	if (currentIndex.value <= 1) {
		uni.showToast({
			title: '已经是第一题了',
			icon: 'none'
		})
		return
	}
	
	uni.redirectTo({
		url: `/pages/database/topic/topic?id=${subjcetDetail.value[currentIndex.value - 2].id}&name=${subjcetDetail.value[currentIndex.value - 2].topicName}&subjectId=${currentSubjectId.value}`
	})

}

const nextTopic = () => {
	if (currentIndex.value >= subjcetDetail.value.length) {
		uni.showToast({
			title: '已经是最后一题了',
			icon: 'none'
		})
		return
	}
	uni.redirectTo({
		url: `/pages/database/topic/topic?id=${subjcetDetail.value[currentIndex.value].id}&name=${subjcetDetail.value[currentIndex.value].topicName}&subjectId=${currentSubjectId.value}`
	})
}

const goToTopic = (item) => {
	uni.redirectTo({
		url: `/pages/database/topic/topic?id=${item.id}&name=${item.topicName}&subjectId=${currentSubjectId.value}`
	})
}
</script>
<template>
	
	<uni-drawer ref="showRight" mode="right" width="260">
		<scroll-view class="scroll-view-box" scroll-y="true" style="height: 100vh;">
			<uni-list>
				<uni-list-item class="list-item" :class="{ 'active': item.id == currentTopicId }" showArrow
					v-for="item in subjcetDetail" clickable @click="goToTopic(item)">
					<template #header>
						<span class="title">{{ item.topicName }}</span>
					</template>
				</uni-list-item>
			</uni-list>
		</scroll-view>
	</uni-drawer>

	
	<FeedbackPopup v-model:show="showFeedback" @submit="handleFeedbackSubmit" />

	<view class="topic" v-if="topicDetail">
		<view class="topic-box">
			
			<view class="topic-top">
				
				<view class="top-box">
					<h2 class="topic-title">{{ topicDetail.topicName }}</h2>
				</view>
				
				<view class="top-center">
					<view class="tags-row">
						<view class="tag" v-for="(tag, index) in topicDetail.labelNames" :key="index">{{ tag }}</view>
					</view>
					<view class="star-box" @click="handleCollect">
						
						<uni-icons :type="isCollected ? 'star-filled' : 'star'" color="#1677ff" size="24"></uni-icons>
					</view>
				</view>
			</view>
			
			<view class="topic-divider" />
			<view class="topic-bottom">
				
				<view class="tab-box">
					<view :class="{ 'tab-one': true, 'active-tab-box': isTabs }" @click="handleTabs">
						精简答案
					</view>
					<view :class="{ 'tab-one': true, 'active-tab-box': !isTabs }" @click="handleTabs">
						AI答案
					</view>
				</view>
				
				<view class="topic-answer">
					
					<view v-if="!isShowAnswer">
						<view v-if="topicDetail.isMember === 0" class="show-btn" @click="showAnswer">
							点击查看答案
						</view>
						<view v-else class="show-btn vip-btn" @click="showAnswer">
							开通会员查看答案
						</view>
					</view>
					
					<view v-else class="answer-box">
						
						<zero-markdown-view v-if="markDownContent" :markdown="markDownContent"></zero-markdown-view>
						<uv-empty v-else text="系统正在完善题目答案哦～" icon="../../../static/images/empty.png"></uv-empty>
					</view>
				</view>
			</view>
			
			<view class="topic-operation">
				<view class="operation-top">
					<view class="list-box" @click="showRight.open()">
						<uni-icons type="list" color="#1677ff" size="20"></uni-icons>
						<span class="topic">{{ topicDetail.topicName }}</span>
						(<span class="topic-weight">{{ currentIndex }}</span>/{{
							total
						}})
					</view>
					<progress class="progress" :percent="progressPercent" activeColor="#1677ff" stroke-width="6" />
				</view>
				<view class="operation-bottom">
					<view class="game-controls">
						<view class="control-btn prev" @click="prevTopic">
							<view class="btn-circle">
								<uni-icons type="left" size="20" color="#999"></uni-icons>
							</view>
						</view>
						<view class="control-btn feedback">
							<view class="btn-circle" @click="showFeedback = true">
								<uni-icons type="info" size="20" color="#fff"></uni-icons>
							</view>
						</view>
						<view class="control-btn next" @click="nextTopic">
							<view class="btn-circle">
								<uni-icons type="right" size="20" color="#fff"></uni-icons>
							</view>
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
	<uv-empty v-else text="系统正在完善题目信息哦～" icon="../../../static/images/empty.png"></uv-empty>
</template>
<style lang="scss" scoped>
.title {
	font-size: 25rpx;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 1;
	
	overflow: hidden;
}

:deep(.list-item.active) {
	.uni-list-item {
		background-color: rgba(22, 119, 255, 0.1);
	}

	.title {
		color: #1677ff;
		font-weight: bold;
	}
}

.topic-box {

	.topic-divider {
		height: 28rpx;
		background-color: #fafafa;
		margin-top: 10rpx;
	}

	.topic-top {
		padding: 22rpx;

		.topic-title {
			font-size: 40rpx;
		}

		.top-center {
			display: flex;
			margin-top: 18rpx;
			align-items: center;
			justify-content: space-between;

			.tags-row {
				display: flex;
				justify-content: space-between;
				align-items: center;
				gap: 12rpx;

				.tag {
					padding: 6rpx 20rpx;
					background: rgba(22, 119, 255, 0.08);
					color: #1677ff;
					font-size: 24rpx;
					border-radius: 24rpx;
					font-weight: 500;
				}
			}

			.star-box {
				display: flex;
				cursor: pointer;
				transition: transform 0.2s;

				&:active {
					transform: scale(0.9);
				}
			}
		}
	}

	.topic-bottom {
		padding: 28rpx;

		.tab-box {
			font-size: 31rpx;
			display: flex;
			justify-content: space-evenly;
		}

		.active-tab-box {
			padding-bottom: 8rpx;
			color: #1677ff;
			border-bottom: 1px solid #1677ff;
		}

		.topic-answer {
			.show-btn {
				margin: 70rpx auto;
				color: #fff;
				border-radius: 40rpx;
				text-align: center;
				line-height: 80rpx;
				width: 280rpx;
				height: 80rpx;
				background-color: #1677ff;

				&.vip-btn {
					background: linear-gradient(to right, #FFD700, #FFA500);
					box-shadow: 0 4rpx 8rpx rgba(255, 215, 0, 0.3);
				}
			}

			.answer-box {
				
				padding-bottom: 200rpx;
			}
		}
	}

	.topic-operation {
		border-top: 1px solid #ebebeb;
		position: fixed;
		left: 0;
		bottom: 0;
		right: 0;
		height: 200rpx;
		background-color: #fff;
		box-sizing: border-box;
		padding: 20rpx;

		.operation-top {
			display: flex;
			align-items: center;
			justify-content: space-between;
			height: 40rpx;

			.list-box {
				width: 60%;
				display: flex;
				align-items: center;
				color: #1677ff;

				.topic {
					font-size: 16px;
					padding-left: 5rpx;
					display: -webkit-box;
					-webkit-box-orient: vertical;
					-webkit-line-clamp: 1;
					
					overflow: hidden;
				}

				.topic-weight {
					font-weight: bold;
				}
			}

			.progress {
				padding-left: 3rpx;
				width: 39%;
			}
		}

		.operation-bottom {
			margin-top: 30rpx;

			.game-controls {
				display: flex;
				justify-content: space-between;
				align-items: center;
				width: 100%;

				.control-btn {
					display: flex;
					flex-direction: column;
					align-items: center;

					.btn-circle {
						width: 80rpx;
						height: 80rpx;
						border-radius: 50%;
						display: flex;
						align-items: center;
						justify-content: center;
						background-color: #1677ff;
						box-shadow: 0 4rpx 8rpx rgba(0, 0, 0, 0.15);
						transition: all 0.2s;

						&:active {
							transform: scale(0.9);
							box-shadow: 0 2rpx 4rpx rgba(0, 0, 0, 0.1);
						}
					}

					&.feedback {
						.btn-circle {
							background-color: rgba(22, 119, 255, 0.8);
							box-shadow: 0 4rpx 8rpx rgba(22, 119, 255, 0.25);
						}
					}

					&.prev {
						.btn-circle {
							background-color: #f5f5f5;
						}

						.btn-text {
							color: #999;
						}
					}
				}
			}
		}
	}
}
</style>