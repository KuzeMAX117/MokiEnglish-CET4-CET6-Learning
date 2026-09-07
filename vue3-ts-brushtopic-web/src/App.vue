<template>
  <a-config-provider :locale="zhCN" :theme="themeConfig">
    <router-view />
  </a-config-provider>
</template>

<script setup lang="ts">
import zhCN from 'ant-design-vue/es/locale/zh_CN'
import { theme as antdTheme } from 'ant-design-vue'

const themeConfig = {
  algorithm: antdTheme.darkAlgorithm,
  token: {
    colorPrimary: '#8b5cf6',
    colorInfo: '#8b5cf6',
    colorLink: '#22d3ee',
    colorBgBase: '#0b0f1a',
    colorBgContainer: '#121828',
    colorBgElevated: '#1a2135',
    colorBorder: 'rgba(255,255,255,0.12)',
    colorBorderSecondary: 'rgba(255,255,255,0.08)',
    colorText: '#e5eaf3',
    colorTextSecondary: '#9aa4bd',
    borderRadius: 10,
    fontFamily:
      "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, 'PingFang SC', 'Microsoft YaHei', sans-serif",
  },
  components: {
    Layout: {
      headerBg: 'transparent',
      bodyBg: 'transparent',
      siderBg: '#0b0f1a',
    },
    Menu: {
      itemBg: 'transparent',
      itemColor: '#9aa4bd',
      itemHoverBg: 'rgba(139,92,246,0.12)',
      itemSelectedBg: 'rgba(139,92,246,0.2)',
      itemSelectedColor: '#22d3ee',
      horizontalItemSelectedColor: '#22d3ee',
      horizontalItemHoverColor: '#8b5cf6',
    },
    Button: {
      primaryColor: '#fff',
      fontWeight: 500,
    },
    Card: {
      colorBgContainer: 'rgba(255,255,255,0.04)',
    },
    Modal: {
      contentBg: '#1a2135',
      headerBg: 'transparent',
    },
    Drawer: {
      colorBgElevated: '#121828',
    },
    Tabs: {
      inkBarColor: '#22d3ee',
      itemSelectedColor: '#22d3ee',
      itemHoverColor: '#8b5cf6',
    },
    Input: {
      colorBgContainer: 'rgba(255,255,255,0.06)',
    },
    Table: {
      colorBgContainer: 'transparent',
    },
  },
}
</script>
