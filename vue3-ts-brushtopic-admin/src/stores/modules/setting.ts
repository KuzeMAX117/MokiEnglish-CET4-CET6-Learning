import {
  defineStore
} from "pinia";
import {
  ref
} from 'vue'
export const useSettingStore = defineStore('setting', () => {
  
  const fold = ref(false)
  
  const themeColor = ref('#0a3442')
  
  const isDark = ref(false)
  
  const isCompact = ref(false)
  
  const theme = localStorage.getItem("settingTheme")
  
  if (theme) {
    
    const jsonTheme = JSON.parse(theme)
    
    fold.value = jsonTheme.fold
    themeColor.value = jsonTheme.themeColor
    isDark.value = jsonTheme.isDark
    isCompact.value = jsonTheme.isCompact
  } else {
    
  }
  return {
    fold,
    themeColor,
    isDark,
    isCompact
  }
})