<template>
  <div class="md-body" v-html="html"></div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import MarkdownIt from 'markdown-it'

const props = defineProps<{ content: string }>()

const md = new MarkdownIt({
  html: true,
  linkify: true,
  breaks: true,
})

const html = computed(() => (props.content ? md.render(props.content) : ''))
</script>
