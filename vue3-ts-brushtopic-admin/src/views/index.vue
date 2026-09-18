<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
import AdminIndex from './adminIndex.vue';
import CommonIndex from './commonIndex.vue';
const userStore = useUserStore()
const identity = userStore.userInfo.identity
</script>
<template>
  <div class="dashboard-container">
    <template v-if="identity === 2">
      <AdminIndex />
    </template>
    <template v-else>
      <CommonIndex />
    </template>
  </div>
</template>
<style lang="scss" scoped>
.dashboard-container { width: 100%; min-height: 100%; padding: 0; }
</style>
