<script setup lang="ts">
import { useSettingStore } from '@/stores/modules/setting.ts'
import { useUserStore } from '@/stores/modules/user.ts'

const settingStore = useSettingStore()

const userStore = useUserStore()
import { ref, h, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router';
import type { MenuProps } from 'ant-design-vue';
import * as AntIcons from '@ant-design/icons-vue';

const $route = useRoute()

const $router = useRouter()
defineProps(['menuList'])

const handleClick: MenuProps['onClick'] = menuInfo => {
  console.log(menuInfo)
  $router.push(
    String(menuInfo.key),
  )
};

const selectedKeys = ref([$route.path])

const menuAllList = ref<any[]>([])

onMounted(() => {
  
  userStore.userInfo.menuList.forEach(item => {
    
    
    const icon = item.icon ? () => h((AntIcons as any)[item.icon]) : null;
    let children = null;
    if (!item.children || item.children.length === 0) {
      children = null;
    } else {
      children = item.children.map(child => {
        
        
        const icon = child.icon ? () => h((AntIcons as any)[child.icon]) : null;
        return {
          key: child.key,
          label: child.label,
          icon: icon,
        };
      });
    }
    menuAllList.value.push({
      key: item.key,
      label: item.label,
      icon: icon,
      children: children,
    });
  });
});

const openKeysList = ref<any>([]);

const rootSubmenuKeys = ref();
const onOpenChange = (openKeys: string[]) => {
  rootSubmenuKeys.value = menuAllList.value.map(item => item.key);
  
  const latestOpenKey = openKeys.find(key => openKeysList.value.indexOf(key) === -1);
  
  if (rootSubmenuKeys.value.indexOf(latestOpenKey) === -1) {
    
    openKeysList.value = openKeys;
  } else {
    
    openKeysList.value = latestOpenKey ? [latestOpenKey] : [];
  }
};
</script>
<template>
  <a-menu mode="inline" :open-keys="openKeysList" @openChange="onOpenChange" class="custom-menu" :items="menuAllList"
    v-model:selectedKeys="selectedKeys" @click="handleClick" :inline-collapsed="settingStore.fold"
    :theme="settingStore.isDark ? 'dark' : 'light'">
  </a-menu>
</template>
<style lang="scss" scoped>
.custom-menu {
  ::v-deep(.ant-menu-item-selected) {
    color: $base-menu-active-color !important;
    background-color: $base-menu-active-background !important;
  }
}
</style>
