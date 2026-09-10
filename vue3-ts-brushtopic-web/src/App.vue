<template>
  <a-config-provider :locale="zhCN" :theme="themeConfig">
    <router-view />
  </a-config-provider>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import zhCN from 'ant-design-vue/es/locale/zh_CN'
import { theme as antdTheme } from 'ant-design-vue'
import { useThemeStore } from '@/stores/theme'

const themeStore = useThemeStore()
themeStore.init()

const FONT_FAMILY =
  "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Noto Sans', sans-serif"

// 三套 antd 主题 token，与 global.css 中 html[data-theme] 的 CSS 变量保持一致。
// antd 组件（按钮、弹窗等）不走 CSS 变量，必须在这里同步切换才能跟随外观设置。
const antdThemes = {
  day: {
    algorithm: antdTheme.defaultAlgorithm,
    token: {
      colorPrimary: '#4257B2',
      colorInfo: '#4257B2',
      colorLink: '#4257B2',
      colorSuccess: '#28A745',
      colorWarning: '#F0AD4E',
      colorError: '#DC3545',
      colorBgBase: '#ffffff',
      colorBgContainer: '#ffffff',
      colorBgElevated: '#ffffff',
      colorBgLayout: '#F7F8FA',
      colorFillAlter: '#F7F8FA',
      colorBorder: '#E8EAED',
      colorBorderSecondary: '#E8EAED',
      colorText: '#1A1A1A',
      colorTextSecondary: '#444444',
      colorTextTertiary: '#70757A',
      colorTextQuaternary: '#A7ABB0',
      borderRadius: 8,
      fontSize: 14,
      fontFamily: FONT_FAMILY,
      boxShadowSecondary: '0 4px 12px rgba(0, 0, 0, 0.08)',
    },
    components: {
      Layout: {
        headerBg: '#ffffff',
        bodyBg: '#F7F8FA',
        siderBg: '#ffffff',
      },
      Menu: {
        itemBg: 'transparent',
        itemColor: '#444444',
        itemHoverBg: 'rgba(66, 87, 178, 0.06)',
        itemHoverColor: '#4257B2',
        itemSelectedBg: 'rgba(66, 87, 178, 0.08)',
        itemSelectedColor: '#4257B2',
        horizontalItemSelectedColor: '#4257B2',
        horizontalItemHoverColor: '#4257B2',
      },
      Button: {
        primaryColor: '#ffffff',
        fontWeight: 500,
      },
      Card: {
        colorBgContainer: '#F7F8FA',
      },
      Modal: {
        contentBg: '#ffffff',
        headerBg: 'transparent',
      },
      Drawer: {
        colorBgElevated: '#ffffff',
      },
      Tabs: {
        inkBarColor: '#4257B2',
        itemSelectedColor: '#4257B2',
        itemHoverColor: '#4257B2',
      },
      Table: {
        colorBgContainer: '#ffffff',
      },
    },
  },
  'eye-care': {
    algorithm: antdTheme.defaultAlgorithm,
    token: {
      colorPrimary: '#4257B2',
      colorInfo: '#4257B2',
      colorLink: '#4257B2',
      colorSuccess: '#28A745',
      colorWarning: '#F0AD4E',
      colorError: '#DC3545',
      colorBgBase: '#FBF6E9',
      colorBgContainer: '#FBF6E9',
      colorBgElevated: '#FFFDF6',
      colorBgLayout: '#F5EDDA',
      colorFillAlter: '#F5EDDA',
      colorBorder: '#E4D9C1',
      colorBorderSecondary: '#E4D9C1',
      colorText: '#3B3325',
      colorTextSecondary: '#55493A',
      colorTextTertiary: '#8A7E6B',
      colorTextQuaternary: '#A79C88',
      borderRadius: 8,
      fontSize: 14,
      fontFamily: FONT_FAMILY,
      boxShadowSecondary: '0 4px 12px rgba(80, 60, 20, 0.08)',
    },
    components: {
      Layout: {
        headerBg: '#FBF6E9',
        bodyBg: '#F5EDDA',
        siderBg: '#FBF6E9',
      },
      Menu: {
        itemBg: 'transparent',
        itemColor: '#55493A',
        itemHoverBg: 'rgba(66, 87, 178, 0.06)',
        itemHoverColor: '#4257B2',
        itemSelectedBg: 'rgba(66, 87, 178, 0.08)',
        itemSelectedColor: '#4257B2',
        horizontalItemSelectedColor: '#4257B2',
        horizontalItemHoverColor: '#4257B2',
      },
      Button: {
        primaryColor: '#ffffff',
        fontWeight: 500,
      },
      Card: {
        colorBgContainer: '#F5EDDA',
      },
      Modal: {
        contentBg: '#FFFDF6',
        headerBg: 'transparent',
      },
      Drawer: {
        colorBgElevated: '#FFFDF6',
      },
      Tabs: {
        inkBarColor: '#4257B2',
        itemSelectedColor: '#4257B2',
        itemHoverColor: '#4257B2',
      },
      Table: {
        colorBgContainer: '#FBF6E9',
      },
    },
  },
  night: {
    algorithm: antdTheme.darkAlgorithm,
    token: {
      colorPrimary: '#6B83D4',
      colorInfo: '#6B83D4',
      colorLink: '#6B83D4',
      colorSuccess: '#28A745',
      colorWarning: '#F0AD4E',
      colorError: '#DC3545',
      colorBgBase: '#1A1D24',
      colorBgContainer: '#23272F',
      colorBgElevated: '#23272F',
      colorBgLayout: '#1A1D24',
      colorFillAlter: '#23272F',
      colorBorder: '#2E333D',
      colorBorderSecondary: '#2E333D',
      colorText: '#E5EAF3',
      colorTextSecondary: '#C3CADF',
      colorTextTertiary: '#7C86A6',
      colorTextQuaternary: '#5A6178',
      borderRadius: 8,
      fontSize: 14,
      fontFamily: FONT_FAMILY,
      boxShadowSecondary: '0 4px 12px rgba(0, 0, 0, 0.35)',
    },
    components: {
      Layout: {
        headerBg: '#23272F',
        bodyBg: '#1A1D24',
        siderBg: '#23272F',
      },
      Menu: {
        itemBg: 'transparent',
        itemColor: '#C3CADF',
        itemHoverBg: 'rgba(107, 131, 212, 0.12)',
        itemHoverColor: '#6B83D4',
        itemSelectedBg: 'rgba(107, 131, 212, 0.16)',
        itemSelectedColor: '#6B83D4',
        horizontalItemSelectedColor: '#6B83D4',
        horizontalItemHoverColor: '#6B83D4',
      },
      Button: {
        primaryColor: '#ffffff',
        fontWeight: 500,
      },
      Card: {
        colorBgContainer: '#23272F',
      },
      Modal: {
        contentBg: '#23272F',
        headerBg: 'transparent',
      },
      Drawer: {
        colorBgElevated: '#23272F',
      },
      Tabs: {
        inkBarColor: '#6B83D4',
        itemSelectedColor: '#6B83D4',
        itemHoverColor: '#6B83D4',
      },
      Table: {
        colorBgContainer: '#23272F',
      },
    },
  },
}

// 随主题模式实时切换 antd token
const themeConfig = computed(() => antdThemes[themeStore.mode])
</script>
