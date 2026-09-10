import { defineStore } from 'pinia'

export type ThemeMode = 'day' | 'eye-care' | 'night'

interface ThemeState {
  mode: ThemeMode
  brightness: number // 50–150, default 100
  fontOffset: number // 0–10, default 0 (extra px added to all font sizes)
}

const STORAGE_KEY = 'app_theme'

function loadState(): ThemeState {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    if (raw) {
      const s: Partial<ThemeState> = JSON.parse(raw)
      if (['day', 'eye-care', 'night'].includes(s.mode as string) && typeof s.brightness === 'number') {
        return {
          mode: s.mode as ThemeMode,
          brightness: s.brightness,
          fontOffset: typeof s.fontOffset === 'number' && s.fontOffset >= 0 && s.fontOffset <= 10 ? s.fontOffset : 0,
        }
      }
    }
  } catch {
    // ignore
  }
  return { mode: 'day', brightness: 100, fontOffset: 0 }
}

function persist(state: ThemeState) {
  localStorage.setItem(STORAGE_KEY, JSON.stringify({ mode: state.mode, brightness: state.brightness, fontOffset: state.fontOffset }))
}

/** Apply theme to <html> element: data-theme attribute + brightness filter */
function applyTheme(mode: ThemeMode, brightness: number, fontOffset: number) {
  const root = document.documentElement
  root.setAttribute('data-theme', mode)
  root.style.filter = brightness === 100 ? '' : `brightness(${brightness}%)`
  root.style.setProperty('--font-offset', `${fontOffset}px`)
}

export const useThemeStore = defineStore('theme', {
  state: (): ThemeState => loadState(),
  actions: {
    setMode(mode: ThemeMode) {
      this.mode = mode
      persist({ mode: this.mode, brightness: this.brightness, fontOffset: this.fontOffset })
      applyTheme(this.mode, this.brightness, this.fontOffset)
    },
    setBrightness(val: number) {
      this.brightness = val
      persist({ mode: this.mode, brightness: this.brightness, fontOffset: this.fontOffset })
      applyTheme(this.mode, this.brightness, this.fontOffset)
    },
    setFontOffset(val: number) {
      this.fontOffset = val
      persist({ mode: this.mode, brightness: this.brightness, fontOffset: this.fontOffset })
      applyTheme(this.mode, this.brightness, this.fontOffset)
    },
    /** Call once on app startup to apply saved theme */
    init() {
      applyTheme(this.mode, this.brightness, this.fontOffset)
    },
  },
})
