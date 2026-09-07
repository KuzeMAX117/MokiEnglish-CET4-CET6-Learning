<script setup lang="ts">
import { useSettingStore } from '@/stores/modules/setting.js';
import { RightOutlined, MenuFoldOutlined, MenuUnfoldOutlined } from '@ant-design/icons-vue';

const settingStore = useSettingStore();
import { useRoute } from 'vue-router';

const $route = useRoute();
console.log($route.matched);

const changeIcon = () => {
  settingStore.fold = !settingStore.fold
}
</script>
<template>
  
  <div class="icon-box" @click="changeIcon">
    <MenuFoldOutlined v-if="!settingStore.fold" />
    <MenuUnfoldOutlined v-else />
  </div>
  
  <a-breadcrumb>
    <template #separator>
      <RightOutlined />
    </template>
    
    <a-breadcrumb-item v-for="(item, index) in $route.matched" :key="index" v-show="item.meta.title" :to="item.path">
      <span>{{ item.meta.title }}</span>
    </a-breadcrumb-item>
  </a-breadcrumb>
</template>
<style lang="scss" scoped>
.icon-box {
  margin: 0 12px 0 5px;
}
</style>
