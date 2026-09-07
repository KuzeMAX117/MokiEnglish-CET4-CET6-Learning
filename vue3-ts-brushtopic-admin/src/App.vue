<script setup lang="ts">
import { RouterView } from 'vue-router'
import zhCN from 'ant-design-vue/es/locale/zh_CN';
import { theme } from 'ant-design-vue';
import dayjs from 'dayjs';
import { watch } from 'vue';
import 'dayjs/locale/zh-cn';
dayjs.locale('zh-cn');

import { useSettingStore } from '@/stores/modules/setting';
const settingStore = useSettingStore()
const compositeAlgorithm = (algorithms: any[]) => {
  return algorithms.filter(a => a); 
};

watch(() => settingStore.isDark, (newVal) => {
  const html = document.documentElement;
  if (newVal) {
    html.classList.add('dark');
  } else {
    html.classList.remove('dark');
  }
}, { immediate: true });
</script>

<template>
  <a-config-provider :locale="zhCN" :theme="{

    // 自定义主题色
    token: {
      colorPrimary: settingStore.themeColor,
      colorInfo: settingStore.themeColor,
      colorInfoText: settingStore.themeColor,
      colorPrimaryText: settingStore.themeColor,
      colorLink: settingStore.themeColor,
    },
    algorithm: compositeAlgorithm([
      // 暗黑模式
      settingStore.isDark && theme.darkAlgorithm,
      // 紧凑模式
      settingStore.isCompact && theme.compactAlgorithm,
    ])
  }">
    
    <RouterView />
  </a-config-provider>
</template>

<style scoped></style>
