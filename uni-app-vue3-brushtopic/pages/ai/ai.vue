<script setup>
	import {
		ref,
		reactive,
		watch,
		nextTick
	} from 'vue';
	import {
		v4 as uuidv4
	} from 'uuid'; 
	import {
		apiGetManageList,
		apiGetHistoryDetail
	} from '@/api/ai'

	
	const role = ref(uni.getStorageSync('role'))
	
	const userInfo = ref(JSON.parse(uni.getStorageSync('h5UserInfo')))
	
	const token = ref(localStorage.getItem(userInfo.value.account + 'token'))

	
	const aiModeValue = ref(localStorage.getItem('aiMode') || 'system')

	
	const aiMode = reactive([{
		label: '系统模式',
		value: 'system',
		desc: role.value === 1 ? 'AI从系统题库和会员自定义题库中随机提取题目，AI会校验你的回答' : 'AI从系统题库中随机提取题目，AI会校验你的回答'
	}, {
		label: '模型模式',
		value: 'model',
		desc: '完全使用AI生成的题目，AI会校验你的回答'
	}, {
		label: '混合模式',
		value: 'mix',
		desc: 'AI随机混合系统题库和AI生成题目，AI会校验你的回答'
	}, ])

	
	const placeholder = ref(role.value === 1 ? '请输入系统中和会员自定义的正确的题目专题，AI将自动生成题目' : '请输入系统中的正确的题目专题，AI将自动生成题目')
	
	const initPlaceholder = () => {
		if (aiModeValue.value === 'system') {
			placeholder.value = '请输入题目专题，AI将自动生成题目'
		} else if (aiModeValue.value === 'model' || aiModeValue.value === 'mix') {
			placeholder.value = '请输入给AI你想刷的题目类型，AI将自动生成题目'
		}
	}
	
	watch(() => aiModeValue.value, () => {
		initPlaceholder()
	})

	
	const chatLoading = ref(false)
	
	const activeIndex = ref([])
	
	const isSelectHistory = ref(false)

	
	const aiId = ref(0)
	
	const currentRecordId = ref(uuidv4())
	
	const messageList = reactive([{
		prompt: "我是" + userInfo.value.nickname || userInfo.value.account,
		chatId: currentRecordId.value, 
		model: aiModeValue.value,
			content: '你好，我是AI 1.0，你的学习AI助手！',
		memoryId: aiId.value
	}])

	
	const historyList = ref([])
	
	const historyParams = ref({
		pageNum: 1,
		pageSize: 999,
		title: null
	})
	
	const showLeft = ref(null)
	
	const handleGetHistoryList = () => {
		if (!isReply.value) {
			uni.showToast({
				title: '当前正在回复中',
				icon: 'none'
			})
			return
		}
		showLeft.value.open()
		getHistoryList()
	}
	
	const getHistoryList = async () => {
		const res = await apiGetManageList(historyParams.value)
		historyList.value = res.data
	}
	
	const currentTitle = ref('')
	
	const getHistoryContent = async (id, index, historyIndex, title) => {
		uni.showLoading({
			title: '加载中...'
		})
		currentTitle.value = title
		showLeft.value.close()
		chatLoading.value = true
		
		restoreDefaultRecord()
		
		activeIndex.value = []
		
		activeIndex.value[historyIndex] = index
		
		const res = await apiGetHistoryDetail(id)
		isSelectHistory.value = true
		aiModeValue.value = res.data[0].mode
		
		const content = res.data.map((item) => {
			return {
				prompt: item.title,
				chatId: item.chatId,
				content: item.content
			}
		})
		
		messageList.push(...content)
		
		currentRecordId.value = res.data[0].chatId
		
		localStorage.removeItem('chatId')
		
		aiId.value = res.data.length;
		console.log(res.data.length);

		console.log(aiId.value);

		chatLoading.value = false
		uni.hideLoading()
		await scrollToBottom()
	}
	
	const restoreDefaultRecord = () => {
		
		messageList.splice(0, messageList.length)
		
		messageList.push({
			prompt: "我是" + userInfo.value.nickname || userInfo.value.account,
			chatId: currentRecordId.value, 
			model: aiModeValue.value,
		content: '你好，我是AI 1.0，你的学习AI助手！',
			memoryId: aiId.value
		})
	}

	
	const contentRef = ref(null)
	
	const scrollTop = ref(0)

	
	const scrollToBottom = async () => {
		await nextTick()
		const query = uni.createSelectorQuery()
		query.selectAll('.box').boundingClientRect(data => {
			if (data) {
				
				const totalHeight = data.reduce((sum, item) => sum + item.height, 0)
				scrollTop.value = totalHeight + 500 
			}
		}).exec()
	}

	
	const copyContent = (content) => {
		
		const plainText = content.replace(/```[\s\S]*?```/g, '')
			.replace(/\*\*/g, '')
			.replace(/\*/g, '')
			.replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
			.trim()

		uni.setClipboardData({
			data: plainText,
			success: () => {
				uni.showToast({
					title: '复制成功',
					icon: 'success',
					duration: 1500
				})
			},
			fail: () => {
				uni.showToast({
					title: '复制失败',
					icon: 'error',
					duration: 1500
				})
			}
		})
	}

	
	const isPaused = ref(false)
	
	let currentController
	
	const isReply = ref(true)
	
	const pauseReply = () => {
		if (currentController) {
			
			currentController.abort()
			currentController = null
			isPaused.value = false
			isReply.value = true
		}
	}

	
	const prompt = ref('')
	
	const sendPrompt = async () => {
		isReply.value = false
		isSelectHistory.value = true
		if (prompt.value) {
			if (aiId.value === 0) {
				
				localStorage.setItem('chatId', currentRecordId.value)
			}
			aiId.value++
			
			messageList.push({
				prompt: prompt.value,
				memoryId: aiId.value,
				chatId: localStorage.getItem('chatId') || currentRecordId.value, 
				model: aiModeValue.value,
				content: '',
				nickname: userInfo.value.nickname,
			})
			prompt.value = ''
			await scrollToBottom()

			
			const currentRecord = messageList[messageList.length - 1]
			try {
				
				currentController = new AbortController()
				
				fetch(`http://localhost:9993/api/ai/model/chat`, {
					method: "POST",
					
					
					headers: {
						"Content-Type": "application/json",
						"Authorization": token.value,
					},
					
					signal: currentController.signal,
					body: JSON.stringify({
						...currentRecord
					}),
				}).then(response => {
					
					if (!response.ok) {
						uni.showToast({
							title: "AI回复出现点问题请稍后再试！",
							icon: "none",
							duration: 2000
						})
					}
					
					return response.body;
				}).then(async body => {
					if (!body) {
						uni.showToast({
							title: "AI回复出现点问题请稍后再试！",
							icon: "none",
							duration: 2000
						})
						return
					}
					
					const reader = body.getReader();
					
					const decoder = new TextDecoder('utf-8')
					
					while (true) {
						try {
							if (reader) {
								const {
									value,
									done
								} = await reader.read()
								if (done) {
									uni.showToast({
										title: "回复成功",
										icon: "success",
										duration: 2000
									})
									
									isReply.value = true
									
									if (aiId.value === 1) {
										
										getHistoryList()
										activeIndex.value[0] = 0
									}
									break
								}
								await nextTick(() => {
									
									currentRecord.content += decoder.decode(value)
								})
								await scrollToBottom()
							}
						} catch (readError) {
							if (readError.name === 'AbortError') {
								uni.showToast({
									title: "已暂停回复",
									icon: "none",
									duration: 2000
								})
								isReply.value = true
							} else {
								uni.showToast({
									title: "回复失败" + readError,
									icon: "none",
									duration: 2000
								})
							}
							break
						}
					}
				})
			} catch (error) {
				console.log(error);
				if (error.name === 'AbortError') {
					uni.showToast({
						title: "已暂停回复",
						icon: "none",
						duration: 2000
					})
				} else {
					uni.showToast({
						title: "发送失败" + error,
						icon: "none",
						duration: 2000
					})
				}
			}
		}
	}

	
	const createReply = () => {
		if (!isReply.value) {
			uni.showToast({
				title: '当前正在回复中',
				icon: 'none'
			})
			return
		}
		
		if (aiId.value === 0) {
			uni.showToast({
				title: '已是最新对话',
				icon: 'none',
				duration: 1500
			})
			return
		}
		uni.showToast({
			title: '创建对话成功',
			icon: 'success',
			duration: 1500
		})
		setTimeout(() => {
			
			uni.reLaunch({
				url: '/pages/ai/ai'
			})
		}, 100)
	}

	
	const handleAiModeChange = (mode) => {
		if (isSelectHistory.value) {
			
			uni.showModal({
				title: '切换对话模式',
				content: '当前已经开启对话，切换对话模式将会开启新的对话！',
				success: (res) => {
					if (res.confirm) {
						uni.showToast({
							title: '创建成功',
							icon: 'success',
							duration: 1500
						})
						setTimeout(() => {
							
							uni.reLaunch({
								url: '/pages/ai/ai'
							})
						}, 100)
						
						uni.setStorageSync('aiMode', mode)
					}
				}
			})
		} else {
			
			aiModeValue.value = mode
		}
	}

	
	const isSpeaking = ref(false)
	
	let currentAudio;
	
	const loadingTextArr = [
		"正在召唤AI发声中...",
		"AI正在努力变声，请稍等~",
		"语音合成中，马上就能听到啦！",
		"AI正在认真朗读你的内容...",
		"别着急，精彩马上开始！"
	];
	
	const loadingText = ref(loadingTextArr[Math.floor(Math.random() * loadingTextArr.length)]);
	
	const readAloudLoading = ref(false)
	
	const readAloud = (content) => {
		content = plainText(content)
		
		if (currentAudio) {
			currentAudio.pause();
			currentAudio.currentTime = 0;
			currentAudio = null;
		}
		readAloudLoading.value = true
		
		isSpeaking.value = true

		
		fetch(`http://localhost:9993/api/ai/model/tts`, {
				method: "post",
				
				
				headers: {
					"Content-Type": "application/json",
					"Authorization": token.value,

				},
				body: JSON.stringify({
					text: content
				}),
			})
			.then(res => {
				if (!res.ok) {
					throw new Error('语音合成请求失败');
				}
				return res.blob()
			})
			.then((blob) => {
				readAloudLoading.value = false
				
				const url = URL.createObjectURL(blob);
				
				const audio = new Audio(url);
				currentAudio = audio
				
				audio.play();
				
				audio.onended = () => {
					isSpeaking.value = false;

					currentAudio = null;
					URL.revokeObjectURL(url);
				};
			}).catch(() => {
				console.warn('后端语音合成失败，切换到浏览器原生语音:');
				readAloudLoading.value = false;
				
				readAloudWeb(content);
			})
	}

	
	const readAloudWeb = (content) => {
		content = plainText(content)
		const utterance = new SpeechSynthesisUtterance(content);
		utterance.lang = 'zh-CN'; 
		utterance.rate = 1.4; 
		utterance.pitch = 2.5; 
		utterance.volume = 1; 

		
		window.speechSynthesis.speak(utterance);

		
		isSpeaking.value = true;

		
		utterance.onend = () => {
			isSpeaking.value = false;
		};
	}

	
	const plainText = (content) => {
		
		const plainText = content
			
			.replace(/#{1,6}\s/g, '')
			
			.replace(/\*\*|__|\*|_/g, '')
			
			.replace(/$|$|$|$|!\[/g, '')
			
			.replace(/`/g, '')
			// 移除代码块标记（```)
			.split('```').filter((_, index) => index % 2 === 0).join('')
			
			.replace(/^\s*>/gm, '')
			
			.replace(/^\s*[-*+]\s/gm, '')
			
			.replace(/^\s*\d+\.\s/gm, '')
			
			.replace(/\n+/g, ' ')
			
			.replace(/\s+/g, ' ').trim();

		return plainText;
	};

	
	const cancelReadAloud = () => {
		isSpeaking.value = false;
		window.speechSynthesis.cancel();

		if (currentAudio) {
			currentAudio.pause();
			currentAudio.currentTime = 0;
			currentAudio = null;
		}
	}
</script>
<template>
	<view class="ai-box">
		
		<view class="ai-history">
			<view class="left-icon" @click="handleGetHistoryList">
				<uni-icons type="bars" size="24" color="#1677ff"></uni-icons>
			</view>
			<view class="title" v-if="aiId === 0">新对话</view>
			<view class="title" v-else>{{ currentTitle }}</view>
			<view class="right-icon" @click="createReply">
				<uni-icons type="plusempty" color="#1677ff" size="25"></uni-icons>
			</view>
		</view>

		
		<uni-drawer ref="showLeft" :mask-click="true">
			<view class="drawer-content">
				<view class="drawer-title">历史记录</view>
				<scroll-view scroll-y class="history-list">
					<view v-for="(history, historyIndex) in historyList" :key="index" class="history-group">
						<view class="history-date">{{ history.date }}</view>
						<view
							:style="{ 'background-color': activeIndex[historyIndex] === index ? '#f2f3f4' : '', 'pointer-events': isReply ? 'auto' : 'none' }"
							@click="getHistoryContent(record.id, index, historyIndex, record.title)"
							v-for="(record, index) in history.aiHistoryVos" :key="item" class="history-item">
							{{ record.title }}
						</view>
					</view>
				</scroll-view>
			</view>
		</uni-drawer>

		
		<view class="ai-content">
			<scroll-view ref="contentRef" :duration="3000" :scroll-top="scrollTop" v-if="!chatLoading" scroll-y="true"
				class="scroll-Y" :scroll-with-animation="true" :scroll-anchoring="true" @scrolltoupper="upper">
				
				<div v-for="(item, index) in messageList" class="box" :key="index">
					
					<div class="prompt-box">
						<div class="user-message">
							<div class="message-content" :class="{ 'prompt': true, 'first-prompt': index === 0 }">
								<zero-markdown-view class="markdown-content"
									:markdown="item.prompt"></zero-markdown-view>
							</div>
							<template v-if="userInfo.avatar">
								<img class="avatar" :src="userInfo.avatar" />
							</template>
							<template v-else>
								<a-avatar class="avatar" :style="{ backgroundColor: '#1677ff', fontSize: '20px' }">
									{{ userInfo.account?.charAt(0)?.toUpperCase() }}
								</a-avatar>
							</template>
						</div>
						<div class="message-actions">
							<view class="action-icon" @click="readAloud(item.prompt)" v-if="!isSpeaking"
								v-show="!readAloudLoading">
								<uv-icon name="volume" size="20" color="#666"></uv-icon>
							</view>
							<uv-loading-icon :text="loadingText" color="#1677ff"
								v-if="readAloudLoading"></uv-loading-icon>
							<view class="action-icon" v-show="!readAloudLoading" @click="cancelReadAloud"
								v-if="isSpeaking">
								<uv-icon name="volume-off" size="20" color="#666"></uv-icon>
							</view>
							<view class="action-icon" @click="copyContent(item.prompt)">
								<uv-icon name="file-text" size="21" color="#666"></uv-icon>
							</view>
						</div>
					</div>
					
					<div class="content-avatar">
						<img class="avatar" src="../../static/images/128.png" alt="">
						<view v-if="!item.content">
							<uv-loading-icon color="#1677ff"></uv-loading-icon>
						</view>
						<div class="message-wrapper" v-else>
							<zero-markdown-view class="markdown-content" :markdown="item.content"></zero-markdown-view>
							<div class="message-actions" v-if="aiId !== 0">
								<view class="action-icon" @click="readAloud(item.content)" v-if="!isSpeaking"
									v-show="!readAloudLoading">
									<uni-icons type="sound" size="20" color="#666"></uni-icons>
								</view>
								<uv-loading-icon :text="loadingText" color="#1677ff"
									v-if="readAloudLoading"></uv-loading-icon>
								<view class="action-icon" v-show="!readAloudLoading" @click="cancelReadAloud"
									v-if="isSpeaking">
									<uv-icon name="volume-off" size="20" color="#666"></uv-icon>
								</view>
								<view class="action-icon" @click="copyContent(item.content)">
									<uv-icon name="file-text" size="21" color="#666"></uv-icon>
								</view>
							</div>
						</div>
					</div>
				</div>
			</scroll-view>
		</view>

		
		<view class="ai-search">
			<uv-textarea adjustPosition v-model="prompt" height="25" :placeholder="placeholder"></uv-textarea>
			<view class="button-group">
				<view class="mode-buttons">
					<view v-for="item in aiMode" :key="item.value" class="mode-btn"
						:class="{ active: aiModeValue === item.value }" @click="handleAiModeChange(item.value)">
						{{ item.label }}
					</view>
				</view>
				<view class="send-btn">
					<template v-if="!isReply">
						<uv-icon name="pause-circle" class="pause-icon" size="24" color="#ff4d4f"
							@click="pauseReply"></uv-icon>
					</template>
					<template v-else>
						<uni-icons type="paperplane-filled" size="24" color="#1677ff" class="send-icon"
							:class="{ 'disabled': !prompt }" @click="prompt && sendPrompt()"></uni-icons>
					</template>
				</view>
			</view>
		</view>
	</view>
</template>
<style lang="scss" scoped>
	.ai-box {
		display: flex;
		flex-direction: column;
		align-items: center;
		margin: 10rpx;
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background-color: #fff;

		.drawer-content {
			padding: 20rpx;
			height: 100%;

			.drawer-title {
				font-size: 32rpx;
				font-weight: bold;
				padding: 20rpx 0;
				border-bottom: 1px solid #eee;
			}

			.history-list {
				height: calc(100% - 150rpx);
				padding: 20rpx 0;
			}

			.history-group {
				margin: 20rpx 0;

				.history-date {
					font-size: 24rpx;
					color: #999;
					margin-bottom: 10rpx;
				}

				.history-item {
					font-size: 28rpx;
					color: #333;
					padding: 20rpx;
					border-radius: 8rpx;
					margin-bottom: 10rpx;
					white-space: nowrap;
					overflow: hidden;
					text-overflow: ellipsis;

					&:active {
						opacity: 0.8;
					}
				}

			}
		}

		.ai-history {
			width: 98%;
			height: calc(100vh - 95vh);
			display: flex;
			align-items: center;
			justify-content: space-between;
			border-radius: 0 0 5rpx 5rpx;
			color: #2c313c;
			font-size: 35rpx;
			background-color: #fff;

			.title {
				width: 400rpx; 
				text-align: center;
				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;
			}
		}

		.ai-content {
			width: 95%;
			padding: 3rpx;
			height: calc(100vh - 23.5vh); 
			background-color: #f6f7fb;
			width: 100%;

			.scroll-Y {
				height: 100%;
				scroll-behavior: smooth;

				.prompt-box {
					display: flex;
					flex-direction: column;

					.message-actions {
						display: flex;
						justify-content: flex-end;
						gap: 16px;
						margin-right: 40px;
						transition: opacity 0.3s;

						.action-icon {
							margin-top: 5px;
							font-size: 16px;
							color: #666;
							cursor: pointer;

							&:hover {
								color: #1677ff;
							}
						}
					}

					.user-message {
						display: flex;
						justify-content: flex-end;
						align-items: flex-start;
						gap: 2px;

						.message-content {
							max-width: calc(100% - 100px);
							background-color: #eff6ff;

							.prompt {
								margin: 10px 0 5px 0 !important;
							}

							.first-prompt {
								margin-top: 0 !important;
							}
						}

						.avatar {
							margin-top: 10px;
							width: 31px;
							height: 31px;
							border-radius: 50%;
							object-fit: cover;
							margin-right: 5px;
						}
					}
				}

				.content-avatar {
					font-size: 16px !important;
					display: flex;
					margin-top: 20px;
					margin-bottom: 10px;

					.avatar {
						margin-top: 60rpx;
						width: 31px;
						height: 31px;
						border-radius: 50%;
						object-fit: cover;
						margin-right: 5px;
					}

					.message-wrapper {
						flex: 1;
						max-width: calc(100% - 50px); 

						:deep(.markdown-content) {
							overflow-x: auto; 
							word-wrap: break-word; 
							white-space: pre-wrap; 
							max-width: 100%; 
						}

						.message-actions {
							display: flex;
							gap: 16px;
							padding: 8px 0;
							transition: opacity 0.3s;

							.action-icon {
								font-size: 16px;
								color: #666;
								cursor: pointer;

								&:hover {
									color: #1677ff;
								}
							}
						}

						&:hover {
							.message-actions {
								opacity: 1;
							}
						}
					}
				}
			}

			.item {
				width: 100%;
				margin-top: 10rpx;
				height: 300rpx;
				background-color: pink;
			}
		}

		.ai-search {
			height: 10vh;
			background-color: #fff;
			width: 96%;
			padding: 20rpx 30rpx;
			box-shadow: 0 -4rpx 16rpx rgba(0, 0, 0, 0.05);

			:deep(.uv-textarea) {
				background-color: #f5f5f5;
				border-radius: 16rpx;

				.uv-textarea__field {
					font-size: 28rpx;
					line-height: 40rpx;
					color: #333;
				}

				.uv-textarea__placeholder {
					color: #999;
					font-size: 28rpx;
				}
			}

			.button-group {
				display: flex;
				justify-content: space-between;
				align-items: center;

				.mode-buttons {
					display: flex;
					gap: 16rpx;

					.mode-btn {
						font-size: 24rpx;
						padding: 8rpx 16rpx;
						border-radius: 8rpx;
						background-color: #f5f5f5;
						color: #666;
						transition: all 0.3s;

						&.active {
							background-color: #e6f4ff;
							color: #1677ff;
						}

						&:active {
							opacity: 0.8;
						}
					}
				}

				.send-btn {
					padding: 12rpx;
					border-radius: 8rpx;

					&:active {
						opacity: 0.8;
					}

					.pause-icon {
						font-size: 25px;
						color: #ff4d4f;
						cursor: pointer;

						&:hover {
							color: #ff7875;
						}
					}

					.send-icon {
						font-size: 25px;
						color: #1677ff;
						cursor: pointer;

						&.disabled {
							color: #d6dee8;
							cursor: not-allowed;
						}

						&:not(.disabled):hover {
							color: #4096ff;
						}

						&:hover {
							color: #4096ff;
						}

					}

				}
			}
		}

	}
</style>