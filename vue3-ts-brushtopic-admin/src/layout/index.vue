<script setup lang="ts">
import { useSettingStore } from '@/stores/modules/setting.ts'
import { useUserStore } from '@/stores/modules/user.ts'

const settingStore = useSettingStore()

const userStore = useUserStore()

import Logo from './logo/index.vue'

import Menu from './menu/index.vue'

import Tabbar from './tabbar/index.vue'
</script>
<template>
  <div class="layout_container">
    
    <div class="layout_slider" :class="{ fold: settingStore.fold ? true : false }">
      <Logo />
      
      
      <div class="scrollbar">
        
        
        <Menu :menuList="userStore.userInfo.menuList" />
      </div>
    </div>
    
    <div class="layout_tabbar" :class="{ fold: settingStore.fold ? true : false }">
      
      <Tabbar />
    </div>
    
    <div class="layout_main" :class="{ fold: settingStore.fold ? true : false }">
      <a-card style="height: 100%;">
        
        <router-view></router-view>
      </a-card>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.layout_container {
  width: 100%;
  height: 100vh;

  .layout_slider {
    color: white;
    width: $base-menu-width;
    height: 100vh;
    background: $base-menu-background;
    transition: all 0.3s;
    position: fixed;
    z-index: 1000;
    box-shadow: 2px 0 7px 0 rgba(29, 35, 41, 0.05);

    &.fold {
      width: $base-menu-min-width;
    }

    .scrollbar {
      width: 100%;
      height: calc(100vh - $base-menu-logo-height);
    }
  }

  .layout_tabbar {
    position: fixed;
    width: calc(100% - $base-menu-width);
    height: $base-tabbar-height;
    top: 0px;
    left: $base-menu-width;
    transition: all 0.3s;
    border-bottom: 1px solid $base-tabbar-background;

    &.fold {
      width: calc(100vw - $base-menu-min-width);
      left: $base-menu-min-width;
    }
  }

  .layout_main {
    position: absolute;
    width: calc(100% - $base-menu-width);
    height: calc(100vh - $base-tabbar-height);
    left: $base-menu-width;
    top: $base-tabbar-height;
    padding: 12px;
    overflow: auto;
    transition: all 0.3s;
    background-color: $base-content-background;

    &.fold {
      width: calc(100vw - $base-menu-min-width);
      left: $base-menu-min-width;
    }
  }
}
</style>
