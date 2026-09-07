<script setup lang="ts">
import { useUserStore } from '@/stores/modules/user';
import AdminIndex from './adminIndex.vue';
import CommonIndex from './commonIndex.vue';
const userStore = useUserStore()

const identity = userStore.userInfo.identity
console.log('身份', identity);

</script>
<template>
  <div class="index-body">
    
    <template v-if="identity === 2">
      <AdminIndex />
    </template>
    
    <template v-else>
      <CommonIndex />
    </template>
  </div>
</template>
<style lang="scss" scoped></style>
