<template>
  <div style="border: 1px solid #ccc">
    <Toolbar v-if="showToolbarFlag" :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode"
      style="border-bottom: 1px solid #ccc" />
    <Editor v-model="valueHtml" :defaultConfig="editorConfig" :mode="mode" @onCreated="handleCreated"
      @onChange="handleChange" :style="{ height: editorHeight, overflowY: 'hidden' }" :readOnly="readOnlyFlag" />
  </div>
</template>

<script setup lang="ts">
import { watch, onBeforeUnmount, nextTick, ref, shallowRef, onMounted } from 'vue'

import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import '@wangeditor/editor/dist/css/style.css' 

const props = defineProps({
  
  content: { type: String, default: '' },
  
  showToolbarFlag: { type: Boolean, default: true },
  
  editorHeight: { type: String, default: '200px' },
  
  readOnlyFlag: { type: Boolean, default: false }
})

const emit = defineEmits<{ (e: 'update', content: string): void }>()

const mode = ref('default')

const editorRef = shallowRef()

const valueHtml = ref('')

const toolbarConfig = {
  toolbarKeys: [
    
    'headerSelect',      
    'bold',             
    'underline',        
    'through',          
    '|',                
    'color',            
    'bgColor',          
    '|',
    'bulletedList',     
    'numberedList',     
    '|',
    'code',             
    'codeBlock',        
  ]
}

const editorConfig = {
  placeholder: '请输入内容...',
  MENU_CONF: {} as any
}
const handleCreated = (editor: any) => {
  editorRef.value = editor 

  
  if (props.readOnlyFlag) {
    editorRef.value.disable();
  } else {
    editorRef.value.enable();
  }
}

const handleChange = () => {
  valueHtml.value = editorRef.value.getHtml()
  emit('update', valueHtml.value)
}

watch(() => props.content, (newVal: string) => {
  nextTick(() => {
    if (editorRef.value) {
      
      
      editorRef.value.setHtml(newVal)
      valueHtml.value = newVal
    }
  })
}
)

onMounted(async () => {
  await nextTick(); 
  if (props.content) {
    valueHtml.value = props.content
  }
})

onBeforeUnmount(() => {
  const editor = editorRef.value
  if (editor == null) return
  editor.destroy()
})

</script>