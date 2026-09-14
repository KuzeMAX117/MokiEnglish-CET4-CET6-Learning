import { ref } from 'vue'
import { useUserStore } from '@/stores/user'

export interface PkMessage {
  type: string
  [key: string]: any
}

export function usePkWebSocket() {
  const userStore = useUserStore()
  const ws = ref<WebSocket | null>(null)
  const connected = ref(false)
  const messages = ref<PkMessage[]>([])

  const connect = (roomId?: string) => {
    const token = userStore.token
    if (!token) return

    const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:'
    const host = window.location.host
    let url = `${protocol}//${host}/ws/pk/${token}`
    if (roomId) {
      url += `?roomId=${roomId}`
    }

    ws.value = new WebSocket(url)

    ws.value.onopen = () => {
      connected.value = true
      if (roomId) {
        sendMessage({ type: 'JOIN_ROOM', roomId })
      }
    }

    ws.value.onmessage = (event) => {
      try {
        const msg: PkMessage = JSON.parse(event.data)
        messages.value.push(msg)
      } catch (e) {
        console.error('解析WebSocket消息失败', e)
      }
    }

    ws.value.onclose = () => {
      connected.value = false
    }

    ws.value.onerror = (error) => {
      console.error('WebSocket错误', error)
      connected.value = false
    }
  }

  const disconnect = () => {
    if (ws.value) {
      ws.value.close()
      ws.value = null
      connected.value = false
    }
  }

  const sendMessage = (msg: PkMessage) => {
    if (ws.value && ws.value.readyState === WebSocket.OPEN) {
      ws.value.send(JSON.stringify(msg))
    }
  }

  const onMessage = (callback: (msg: PkMessage) => void) => {
    const unwatch = ref<any>(null)
    unwatch.value = setInterval(() => {
      while (messages.value.length > 0) {
        const msg = messages.value.shift()
        if (msg) callback(msg)
      }
    }, 100)
    return () => clearInterval(unwatch.value)
  }

  return {
    connected,
    connect,
    disconnect,
    sendMessage,
    onMessage
  }
}
