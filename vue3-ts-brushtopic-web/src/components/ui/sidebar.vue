<script setup lang="ts">
/**
 * Sidebar — Quizlet soft-UI navigation
 *
 * Desktop : 260px expanded / 72px collapsed, CSS spring-feel transition
 * Mobile  : slide-out drawer from left, animated hamburger → X toggle
 * Feature : collapsible sub-menu sections with Vue <Transition> height anim
 * Style   : white bg, rounded-xl items, CSS-variable design tokens
 *
 * Dependencies: lucide-vue-next
 */

import { ref, computed, watch, type Component } from 'vue'
import {
  Menu,
  X,
  ChevronLeft,
  ChevronRight,
  LogOut,
  Settings,
  Sun,
  Moon,
  Eye,
  Type,
} from 'lucide-vue-next'
import { useThemeStore, type ThemeMode } from '@/stores/theme'

/* ────────────────────────────────────────────
 *  TypeScript Interfaces
 * ──────────────────────────────────────────── */

export interface SidebarSubItem {
  key: string
  label: string
  icon?: Component
  href?: string
}

export interface SidebarMenuItem {
  key: string
  label: string
  icon: Component
  href?: string
  children?: SidebarSubItem[]
}

export interface SidebarMenuGroup {
  key: string
  label?: string
  items: SidebarMenuItem[]
}

export interface SidebarUserInfo {
  name: string
  email: string
  avatar?: string
}

/* ────────────────────────────────────────────
 *  Props & Emits
 * ──────────────────────────────────────────── */

const props = withDefaults(
  defineProps<{
    menuGroups: SidebarMenuGroup[]
    userInfo: SidebarUserInfo
    activeKey?: string
    onItemClick?: (key: string) => void
    onLogout?: () => void
  }>(),
  { activeKey: '' },
)

const emit = defineEmits<{
  (e: 'item-click', key: string): void
  (e: 'logout'): void
}>()

/* ────────────────────────────────────────────
 *  Constants
 * ──────────────────────────────────────────── */

const WIDTH_EXPANDED = 260
const WIDTH_COLLAPSED = 72

// Spring-like cubic-bezier: fast start → slight overshoot → settle
const SPRING_EASE = 'cubic-bezier(0.32, 0.72, 0, 1)'

/* ────────────────────────────────────────────
 *  State
 * ──────────────────────────────────────────── */

const isExpanded = ref(true)
const isMobileOpen = ref(false)
const openSubMenus = ref<Record<string, boolean>>({})

/* ── Theme settings ── */
const themeStore = useThemeStore()
const showSettings = ref(false)

const themeOptions: { key: ThemeMode; label: string; icon: any; desc: string }[] = [
  { key: 'day', label: '白日模式', icon: Sun, desc: '明亮清晰' },
  { key: 'eye-care', label: '护眼淡黄', icon: Eye, desc: '温暖舒适' },
  { key: 'night', label: '夜间模式', icon: Moon, desc: '暗色护眼' },
]

const toggleSettings = () => {
  showSettings.value = !showSettings.value
}

const selectTheme = (mode: ThemeMode) => {
  themeStore.setMode(mode)
}

const onBrightnessChange = (val: number) => {
  themeStore.setBrightness(val)
}

const onFontOffsetChange = (val: number) => {
  themeStore.setFontOffset(val)
}

// Auto-expand sub-menus that contain the active key
function syncOpenSubMenus(key: string) {
  if (!key) return
  for (const group of props.menuGroups) {
    for (const item of group.items) {
      if (item.children?.some((c) => c.key === key)) {
        if (!openSubMenus.value[item.key]) {
          openSubMenus.value = { ...openSubMenus.value, [item.key]: true }
        }
        return
      }
    }
  }
}

syncOpenSubMenus(props.activeKey)
watch(() => props.activeKey, (val) => syncOpenSubMenus(val ?? ''))

/* ────────────────────────────────────────────
 *  Methods
 * ──────────────────────────────────────────── */

const toggleDesktop = () => {
  isExpanded.value = !isExpanded.value
}
const toggleMobile = () => {
  isMobileOpen.value = !isMobileOpen.value
}
const closeMobile = () => {
  isMobileOpen.value = false
}
const toggleSubMenu = (key: string) => {
  openSubMenus.value = {
    ...openSubMenus.value,
    [key]: !openSubMenus.value[key],
  }
}
const handleItemClick = (key: string) => {
  emit('item-click', key)
  props.onItemClick?.(key)
}
const handleLogout = () => {
  emit('logout')
  props.onLogout?.()
}

/* ────────────────────────────────────────────
 *  Computed helpers
 * ──────────────────────────────────────────── */

const sidebarWidth = computed(() =>
  isExpanded.value ? WIDTH_EXPANDED : WIDTH_COLLAPSED,
)

const userInitials = computed(() =>
  props.userInfo.name
    .split(' ')
    .map((w) => w[0])
    .join('')
    .toUpperCase()
    .slice(0, 2),
)

const isSelfActive = (item: SidebarMenuItem) =>
  props.activeKey === item.key

const hasActiveChild = (item: SidebarMenuItem) =>
  item.children?.some((c) => c.key === props.activeKey) ?? false

const isHighlighted = (item: SidebarMenuItem) =>
  isSelfActive(item) || hasActiveChild(item)

const hasChildren = (item: SidebarMenuItem) =>
  !!(item.children && item.children.length > 0)
</script>

<!-- ──────────────────────────────────────────────────────────
     TEMPLATE
     ────────────────────────────────────────────────────────── -->
<template>
  <!-- ════════ Mobile Top Bar ════════ -->
  <div class="sidebar-mobile-header">
    <!-- Animated hamburger → X -->
    <button
      type="button"
      class="hamburger-btn"
      :aria-label="isMobileOpen ? '关闭菜单' : '打开菜单'"
      @click="toggleMobile"
    >
      <span class="hamburger-box">
        <span
          class="hamburger-bar"
          :class="{ 'hamburger-bar--open': isMobileOpen }"
          style="top: 0"
        />
        <span
          class="hamburger-bar hamburger-bar--mid"
          :class="{ 'hamburger-bar--hidden': isMobileOpen }"
          style="top: 50%"
        />
        <span
          class="hamburger-bar"
          :class="{ 'hamburger-bar--open': isMobileOpen }"
          style="bottom: 0"
        />
      </span>
    </button>
    <span class="sidebar-brand-text">TopicBrush</span>
  </div>

  <!-- ════════ Mobile Drawer Overlay + Panel ════════ -->
  <Transition name="fade">
    <div
      v-if="isMobileOpen"
      class="sidebar-backdrop"
      @click="closeMobile"
    />
  </Transition>

  <Transition name="slide-left">
    <aside v-if="isMobileOpen" class="sidebar-drawer">
      <!-- Drawer header -->
      <div class="sidebar-drawer__header">
        <h1 class="sidebar-brand-text">TopicBrush</h1>
        <button
          type="button"
          class="sidebar-icon-btn"
          @click="closeMobile"
        >
          <X :size="18" />
        </button>
      </div>

      <!-- Menu body (always expanded in drawer) -->
      <nav class="sidebar-nav">
        <template v-for="(group, gIdx) in menuGroups" :key="group.key">
          <hr v-if="gIdx > 0" class="sidebar-divider" />
          <p v-if="group.label" class="sidebar-group-label">
            {{ group.label }}
          </p>
          <ul class="sidebar-menu-list">
            <li v-for="item in group.items" :key="item.key">
              <button
                type="button"
                class="sidebar-menu-btn"
                :class="{ 'sidebar-menu-btn--active': isHighlighted(item) }"
                @click="
                  () => {
                    if (hasChildren(item)) toggleSubMenu(item.key)
                    handleItemClick(item.key)
                    closeMobile()
                  }
                "
              >
                <span
                  v-if="isSelfActive(item)"
                  class="sidebar-active-bar"
                />
                <component
                  :is="item.icon"
                  :size="20"
                  class="sidebar-menu-icon"
                  :class="{ 'sidebar-menu-icon--active': isHighlighted(item) }"
                />
                <span class="sidebar-menu-label">{{ item.label }}</span>
                <span
                  v-if="hasChildren(item)"
                  class="sidebar-chevron"
                  :class="{ 'sidebar-chevron--open': openSubMenus[item.key] }"
                >
                  <ChevronRight :size="15" />
                </span>
              </button>

              <!-- Sub-menu -->
              <Transition name="sub-menu">
                <div
                  v-if="openSubMenus[item.key] && hasChildren(item)"
                  class="sidebar-submenu-wrap"
                >
                  <ul class="sidebar-submenu-list">
                    <li v-for="child in item.children" :key="child.key">
                      <button
                        type="button"
                        class="sidebar-submenu-btn"
                        :class="{ 'sidebar-submenu-btn--active': activeKey === child.key }"
                        @click="
                          () => {
                            handleItemClick(child.key)
                            closeMobile()
                          }
                        "
                      >
                        <component
                          v-if="child.icon"
                          :is="child.icon"
                          :size="15"
                          class="shrink-0"
                        />
                        <span class="truncate">{{ child.label }}</span>
                      </button>
                    </li>
                  </ul>
                </div>
              </Transition>
            </li>
          </ul>
        </template>
      </nav>

      <!-- Settings (drawer) -->
      <div class="sidebar-settings-trigger">
        <button type="button" class="sidebar-menu-btn" @click="toggleSettings">
          <Settings :size="20" class="sidebar-menu-icon" />
          <span class="sidebar-menu-label">外观设置</span>
        </button>
        <Transition name="sub-menu">
          <div v-if="showSettings" class="sidebar-settings-panel">
            <div class="settings-theme-grid">
              <button
                v-for="opt in themeOptions"
                :key="opt.key"
                type="button"
                class="settings-theme-card"
                :class="{ 'settings-theme-card--active': themeStore.mode === opt.key }"
                @click="selectTheme(opt.key)"
              >
                <component :is="opt.icon" :size="18" />
                <span class="settings-theme-name">{{ opt.label }}</span>
                <span class="settings-theme-desc">{{ opt.desc }}</span>
              </button>
            </div>
            <div class="settings-brightness">
              <label class="settings-brightness-label">亮度 {{ themeStore.brightness }}%</label>
              <input
                type="range"
                class="settings-brightness-slider"
                min="50"
                max="150"
                step="5"
                :value="themeStore.brightness"
                @input="onBrightnessChange(Number(($event.target as HTMLInputElement).value))"
              />
            </div>
            <div class="settings-fontsize">
              <label class="settings-fontsize-label">
                <Type :size="14" />
                字体增大 +{{ themeStore.fontOffset }}px
              </label>
              <div class="settings-fontsize-row">
                <span class="settings-fontsize-hint">A</span>
                <input
                  type="range"
                  class="settings-brightness-slider"
                  min="0"
                  max="10"
                  step="1"
                  :value="themeStore.fontOffset"
                  @input="onFontOffsetChange(Number(($event.target as HTMLInputElement).value))"
                />
                <span class="settings-fontsize-hint" style="font-size: calc(18px + var(--font-offset, 0px))">A</span>
              </div>
            </div>
          </div>
        </Transition>
      </div>

      <!-- User footer (drawer) -->
      <div class="sidebar-user-footer">
        <div class="sidebar-user-row">
          <img
            v-if="userInfo.avatar"
            :src="userInfo.avatar"
            :alt="userInfo.name"
            class="sidebar-user-avatar"
          />
          <div v-else class="sidebar-user-avatar sidebar-user-avatar--initials">
            {{ userInitials }}
          </div>
          <div class="sidebar-user-info">
            <p class="sidebar-user-name">{{ userInfo.name }}</p>
            <p class="sidebar-user-email">{{ userInfo.email }}</p>
          </div>
          <button type="button" class="sidebar-icon-btn" title="退出登录" @click="handleLogout">
            <LogOut :size="16" />
          </button>
        </div>
      </div>
    </aside>
  </Transition>

  <!-- ════════ Desktop Sidebar ════════ -->
  <aside
    class="sidebar-desktop"
    :style="{ width: sidebarWidth + 'px' }"
  >
    <!-- Header: brand + toggle -->
    <div class="sidebar-desktop__header">
      <Transition name="brand" mode="out-in">
        <h1 v-if="isExpanded" key="full" class="sidebar-brand-text">
          TopicBrush
        </h1>
        <span
          v-else
          key="icon"
          class="sidebar-brand-icon"
        >T</span>
      </Transition>

      <button
        type="button"
        class="sidebar-icon-btn"
        :title="isExpanded ? '收起侧栏' : '展开侧栏'"
        @click="toggleDesktop"
      >
        <span
          class="sidebar-toggle-icon"
          :class="{ 'sidebar-toggle-icon--collapsed': !isExpanded }"
        >
          <ChevronLeft :size="18" />
        </span>
      </button>
    </div>

    <!-- Menu body -->
    <nav class="sidebar-nav">
      <template v-for="(group, gIdx) in menuGroups" :key="group.key">
        <hr v-if="gIdx > 0" class="sidebar-divider" />
        <p v-if="group.label && isExpanded" class="sidebar-group-label">
          {{ group.label }}
        </p>
        <ul class="sidebar-menu-list">
          <li v-for="item in group.items" :key="item.key">
            <button
              type="button"
              class="sidebar-menu-btn"
              :class="{ 'sidebar-menu-btn--active': isHighlighted(item) }"
              :title="!isExpanded ? item.label : undefined"
              @click="
                () => {
                  if (hasChildren(item)) toggleSubMenu(item.key)
                  handleItemClick(item.key)
                }
              "
            >
              <span
                v-if="isSelfActive(item)"
                class="sidebar-active-bar"
              />
              <component
                :is="item.icon"
                :size="20"
                class="sidebar-menu-icon"
                :class="{ 'sidebar-menu-icon--active': isHighlighted(item) }"
              />
              <Transition name="label">
                <span v-if="isExpanded" :key="'label-' + item.key" class="sidebar-menu-label">
                  {{ item.label }}
                </span>
              </Transition>
              <span
                v-if="hasChildren(item) && isExpanded"
                class="sidebar-chevron"
                :class="{ 'sidebar-chevron--open': openSubMenus[item.key] }"
              >
                <ChevronRight :size="15" />
              </span>
            </button>

            <!-- Sub-menu (desktop: only when expanded) -->
            <Transition name="sub-menu">
              <div
                v-if="openSubMenus[item.key] && hasChildren(item) && isExpanded"
                class="sidebar-submenu-wrap"
              >
                <ul class="sidebar-submenu-list">
                  <li v-for="child in item.children" :key="child.key">
                    <button
                      type="button"
                      class="sidebar-submenu-btn"
                      :class="{ 'sidebar-submenu-btn--active': activeKey === child.key }"
                      @click="handleItemClick(child.key)"
                    >
                      <component
                        v-if="child.icon"
                        :is="child.icon"
                        :size="15"
                        class="shrink-0"
                      />
                      <span class="truncate">{{ child.label }}</span>
                    </button>
                  </li>
                </ul>
              </div>
            </Transition>
          </li>
        </ul>
      </template>
    </nav>

    <!-- Settings (desktop) -->
    <div class="sidebar-settings-trigger">
      <button
        type="button"
        class="sidebar-menu-btn"
        :title="!isExpanded ? '外观设置' : undefined"
        @click="toggleSettings"
      >
        <Settings :size="20" class="sidebar-menu-icon" />
        <Transition name="label">
          <span v-if="isExpanded" class="sidebar-menu-label">外观设置</span>
        </Transition>
      </button>
      <Transition name="sub-menu">
        <div v-if="showSettings && isExpanded" class="sidebar-settings-panel">
          <div class="settings-theme-grid">
            <button
              v-for="opt in themeOptions"
              :key="opt.key"
              type="button"
              class="settings-theme-card"
              :class="{ 'settings-theme-card--active': themeStore.mode === opt.key }"
              @click="selectTheme(opt.key)"
            >
              <component :is="opt.icon" :size="18" />
              <span class="settings-theme-name">{{ opt.label }}</span>
              <span class="settings-theme-desc">{{ opt.desc }}</span>
            </button>
          </div>
          <div class="settings-brightness">
            <label class="settings-brightness-label">亮度 {{ themeStore.brightness }}%</label>
            <input
              type="range"
              class="settings-brightness-slider"
              min="50"
              max="150"
              step="5"
              :value="themeStore.brightness"
              @input="onBrightnessChange(Number(($event.target as HTMLInputElement).value))"
            />
          </div>
          <div class="settings-fontsize">
            <label class="settings-fontsize-label">
              <Type :size="14" />
              字体增大 +{{ themeStore.fontOffset }}px
            </label>
            <div class="settings-fontsize-row">
              <span class="settings-fontsize-hint">A</span>
              <input
                type="range"
                class="settings-brightness-slider"
                min="0"
                max="10"
                step="1"
                :value="themeStore.fontOffset"
                @input="onFontOffsetChange(Number(($event.target as HTMLInputElement).value))"
              />
              <span class="settings-fontsize-hint" style="font-size: calc(18px + var(--font-offset, 0px))">A</span>
            </div>
          </div>
        </div>
      </Transition>
    </div>

    <!-- User footer -->
    <div class="sidebar-user-footer">
      <div class="sidebar-user-row">
        <img
          v-if="userInfo.avatar"
          :src="userInfo.avatar"
          :alt="userInfo.name"
          class="sidebar-user-avatar"
        />
        <div v-else class="sidebar-user-avatar sidebar-user-avatar--initials">
          {{ userInitials }}
        </div>
        <Transition name="label">
          <div v-if="isExpanded" class="sidebar-user-info">
            <p class="sidebar-user-name">{{ userInfo.name }}</p>
            <p class="sidebar-user-email">{{ userInfo.email }}</p>
          </div>
        </Transition>
        <Transition name="label">
          <button
            v-if="isExpanded"
            type="button"
            class="sidebar-icon-btn"
            title="退出登录"
            @click="handleLogout"
          >
            <LogOut :size="16" />
          </button>
        </Transition>
      </div>
    </div>
  </aside>
</template>

<!-- ──────────────────────────────────────────────────────────
     SCOPED STYLES
     ────────────────────────────────────────────────────────── -->
<style scoped>
/* ══════════════════════════════════════════════
   Layout Primitives
   ══════════════════════════════════════════════ */

/* ── Desktop sidebar ── */
.sidebar-desktop {
  display: none;
  height: 100vh;
  flex-direction: column;
  border-right: 1px solid var(--border, #e8eaed);
  background: var(--page-bg, #fff);
  overflow: hidden;
  transition: width 0.4s v-bind('SPRING_EASE'), background-color 0.3s ease;
}
@media (min-width: 768px) {
  .sidebar-desktop { display: flex; }
}

.sidebar-desktop__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
  padding: 0 16px;
  border-bottom: 1px solid var(--border, #e8eaed);
  flex-shrink: 0;
}

/* ── Mobile header bar ── */
.sidebar-mobile-header {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 40;
  display: flex;
  align-items: center;
  height: 56px;
  width: 100%;
  padding: 0 12px;
  border-bottom: 1px solid var(--border, #e8eaed);
  background: var(--page-bg, #fff);
  transition: background-color 0.3s ease;
}
@media (min-width: 768px) {
  .sidebar-mobile-header { display: none; }
}

/* ── Mobile drawer ── */
.sidebar-drawer {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  z-index: 60;
  display: flex;
  flex-direction: column;
  width: 260px;
  border-right: 1px solid var(--border, #e8eaed);
  background: var(--page-bg, #fff);
  box-shadow: 4px 0 24px rgba(0, 0, 0, 0.12);
  transition: background-color 0.3s ease;
}
@media (min-width: 768px) {
  .sidebar-drawer { display: none; }
}

.sidebar-drawer__header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 56px;
  padding: 0 16px;
  border-bottom: 1px solid var(--border, #e8eaed);
  flex-shrink: 0;
}

/* ── Backdrop ── */
.sidebar-backdrop {
  position: fixed;
  inset: 0;
  z-index: 50;
  background: rgba(0, 0, 0, 0.2);
}
@media (min-width: 768px) {
  .sidebar-backdrop { display: none; }
}

/* ══════════════════════════════════════════════
   Brand / Toggle
   ══════════════════════════════════════════════ */

.sidebar-brand-text {
  font-size: calc(16px + var(--font-offset, 0px));
  font-weight: 700;
  color: var(--text-title, #1a1a1a);
}

.sidebar-brand-icon {
  font-size: calc(18px + var(--font-offset, 0px));
  font-weight: 700;
  color: var(--primary, #4257b2);
  margin: 0 auto;
}

.sidebar-icon-btn {
  flex-shrink: 0;
  padding: 6px;
  border-radius: 8px;
  border: none;
  background: transparent;
  color: var(--text-muted, #70757a);
  cursor: pointer;
  transition: background 0.15s, color 0.15s;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}
.sidebar-icon-btn:hover {
  background: var(--card-bg, #f7f8fa);
  color: var(--text-body, #444);
}

.sidebar-toggle-icon {
  display: inline-flex;
  transition: transform 0.3s v-bind('SPRING_EASE');
}
.sidebar-toggle-icon--collapsed {
  transform: rotate(180deg);
}

/* ══════════════════════════════════════════════
   Navigation
   ══════════════════════════════════════════════ */

.sidebar-nav {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 8px 12px;
}

.sidebar-divider {
  border: none;
  border-top: 1px solid var(--border, #e8eaed);
  margin: 12px 0;
}

.sidebar-group-label {
  padding: 0 12px;
  margin-bottom: 6px;
  font-size: calc(11px + var(--font-offset, 0px));
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--text-muted, #70757a);
  white-space: nowrap;
}

.sidebar-menu-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

/* ── Menu item button ── */
.sidebar-menu-btn {
  position: relative;
  display: flex;
  align-items: center;
  gap: 12px;
  width: 100%;
  min-width: 0;
  padding: 10px 12px;
  border: none;
  border-radius: 12px;
  background: transparent;
  font-size: calc(14px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-body, #444);
  cursor: pointer;
  transition: background 0.15s, color 0.15s;
}
.sidebar-menu-btn:hover {
  background: var(--card-bg, #f7f8fa);
  color: var(--text-title, #1a1a1a);
}
.sidebar-menu-btn--active {
  background: var(--primary-light, rgba(66, 87, 178, 0.08));
  color: var(--primary, #4257b2);
}

/* ── Active indicator bar ── */
.sidebar-active-bar {
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 3px;
  height: 20px;
  border-radius: 9999px;
  background: var(--primary, #4257b2);
}

/* ── Icon ── */
.sidebar-menu-icon {
  flex-shrink: 0;
  color: var(--text-muted, #70757a);
  transition: color 0.15s;
}
.sidebar-menu-icon--active {
  color: var(--primary, #4257b2);
}

/* ── Label ── */
.sidebar-menu-label {
  flex: 1;
  min-width: 0;
  text-align: left;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ── Chevron ── */
.sidebar-chevron {
  display: inline-flex;
  flex-shrink: 0;
  margin-left: auto;
  color: var(--text-muted, #70757a);
  transition: transform 0.2s ease;
}
.sidebar-chevron--open {
  transform: rotate(90deg);
}

/* ══════════════════════════════════════════════
   Sub-menu
   ══════════════════════════════════════════════ */

.sidebar-submenu-wrap {
  overflow: hidden;
}

.sidebar-submenu-list {
  list-style: none;
  margin: 4px 0 0 16px;
  padding: 4px 0 4px 12px;
  border-left: 1px solid var(--border, #e8eaed);
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.sidebar-submenu-btn {
  display: flex;
  align-items: center;
  gap: 10px;
  width: 100%;
  padding: 8px 10px;
  border: none;
  border-radius: 8px;
  background: transparent;
  font-size: calc(13px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-muted, #70757a);
  cursor: pointer;
  transition: background 0.15s, color 0.15s;
}
.sidebar-submenu-btn:hover {
  background: var(--card-bg, #f7f8fa);
  color: var(--text-body, #444);
}
.sidebar-submenu-btn--active {
  background: var(--primary-light, rgba(66, 87, 178, 0.08));
  color: var(--primary, #4257b2);
}

/* ══════════════════════════════════════════════
   User Footer
   ══════════════════════════════════════════════ */

.sidebar-user-footer {
  padding: 12px;
  border-top: 1px solid var(--border, #e8eaed);
}

.sidebar-user-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.sidebar-user-avatar {
  width: 36px;
  height: 36px;
  flex-shrink: 0;
  border-radius: 50%;
  object-fit: cover;
}
.sidebar-user-avatar--initials {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: calc(12px + var(--font-offset, 0px));
  font-weight: 600;
  background: var(--primary-light, rgba(66, 87, 178, 0.08));
  color: var(--primary, #4257b2);
}

.sidebar-user-info {
  flex: 1;
  min-width: 0;
}
.sidebar-user-name {
  font-size: calc(14px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-body, #444);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.sidebar-user-email {
  font-size: calc(12px + var(--font-offset, 0px));
  color: var(--text-muted, #70757a);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ══════════════════════════════════════════════
   Hamburger Animation (pure CSS)
   ══════════════════════════════════════════════ */

.hamburger-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border: none;
  border-radius: 12px;
  background: transparent;
  color: var(--text-muted, #70757a);
  cursor: pointer;
  transition: background 0.15s;
}
.hamburger-btn:hover {
  background: var(--card-bg, #f7f8fa);
}

.hamburger-box {
  position: relative;
  width: 20px;
  height: 20px;
}

.hamburger-bar {
  position: absolute;
  left: 0;
  width: 20px;
  height: 2px;
  border-radius: 9999px;
  background: currentColor;
  transform-origin: left center;
  transition: transform 0.35s v-bind('SPRING_EASE'), opacity 0.15s;
}
.hamburger-bar--mid {
  transform: translateY(-50%);
}
/* Open state → X shape */
.hamburger-bar--open[style*="top: 0"] {
  transform: rotate(45deg);
}
.hamburger-bar--open[style*="bottom: 0"] {
  transform: rotate(-45deg);
}
.hamburger-bar--hidden {
  opacity: 0;
  transform: translateY(-50%) scaleX(0);
}

/* ══════════════════════════════════════════════
   Vue <Transition> Animations
   ══════════════════════════════════════════════ */

/* ── Overlay fade ── */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* ── Drawer slide from left ── */
.slide-left-enter-active,
.slide-left-leave-active {
  transition: transform 0.35s v-bind('SPRING_EASE');
}
.slide-left-enter-from,
.slide-left-leave-to {
  transform: translateX(-260px);
}

/* ── Sub-menu expand / collapse ── */
.sub-menu-enter-active,
.sub-menu-leave-active {
  transition: all 0.25s ease-in-out;
  overflow: hidden;
}
.sub-menu-enter-from,
.sub-menu-leave-to {
  opacity: 0;
  max-height: 0;
}
.sub-menu-enter-to,
.sub-menu-leave-from {
  opacity: 1;
  max-height: 500px;
}

/* ── Label fade when toggling expand/collapse ── */
.label-enter-active {
  transition: opacity 0.2s ease 0.1s, transform 0.2s ease 0.1s;
}
.label-leave-active {
  transition: opacity 0.12s ease, transform 0.12s ease;
}
.label-enter-from,
.label-leave-to {
  opacity: 0;
  transform: translateX(-6px);
}

/* ── Brand name transition ── */
.brand-enter-active,
.brand-leave-active {
  transition: opacity 0.15s ease, transform 0.15s ease;
}
.brand-enter-from {
  opacity: 0;
  transform: scale(0.85);
}
.brand-leave-to {
  opacity: 0;
  transform: scale(0.85);
}

/* ── Generic utility ── */
.shrink-0 {
  flex-shrink: 0;
}
.truncate {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ══════════════════════════════════════════════
   Settings Panel
   ══════════════════════════════════════════════ */

.sidebar-settings-trigger {
  padding: 0 12px 4px;
  flex-shrink: 0;
}

.sidebar-settings-panel {
  margin-top: 6px;
  padding: 10px;
  border-radius: 12px;
  background: var(--card-bg, #f7f8fa);
  border: 1px solid var(--border, #e8eaed);
  overflow: hidden;
}

.settings-theme-grid {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.settings-theme-card {
  display: flex;
  align-items: center;
  gap: 10px;
  width: 100%;
  padding: 8px 10px;
  border: 1px solid transparent;
  border-radius: 8px;
  background: transparent;
  font-size: calc(13px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-body, #444);
  cursor: pointer;
  transition: all 0.15s;
}
.settings-theme-card:hover {
  background: var(--page-bg, #fff);
  border-color: var(--border, #e8eaed);
}
.settings-theme-card--active {
  background: var(--primary-light, rgba(66, 87, 178, 0.08));
  border-color: var(--primary, #4257b2);
  color: var(--primary, #4257b2);
}

.settings-theme-name {
  flex: 1;
  text-align: left;
  font-weight: 500;
}

.settings-theme-desc {
  font-size: calc(11px + var(--font-offset, 0px));
  color: var(--text-muted, #70757a);
  font-weight: 400;
}
.settings-theme-card--active .settings-theme-desc {
  color: var(--primary, #4257b2);
  opacity: 0.7;
}

.settings-brightness {
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px solid var(--border, #e8eaed);
}

.settings-brightness-label {
  display: block;
  font-size: calc(12px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-muted, #70757a);
  margin-bottom: 6px;
}

.settings-brightness-slider {
  -webkit-appearance: none;
  appearance: none;
  width: 100%;
  height: 4px;
  border-radius: 2px;
  background: var(--border, #e8eaed);
  outline: none;
  cursor: pointer;
}
.settings-brightness-slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--primary, #4257b2);
  border: 2px solid var(--page-bg, #fff);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
  cursor: pointer;
  transition: transform 0.15s;
}
.settings-brightness-slider::-webkit-slider-thumb:hover {
  transform: scale(1.2);
}
.settings-brightness-slider::-moz-range-thumb {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: var(--primary, #4257b2);
  border: 2px solid var(--page-bg, #fff);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
  cursor: pointer;
}

.settings-fontsize {
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px solid var(--border, #e8eaed);
}

.settings-fontsize-label {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: calc(12px + var(--font-offset, 0px));
  font-weight: 500;
  color: var(--text-muted, #70757a);
  margin-bottom: 6px;
}

.settings-fontsize-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.settings-fontsize-hint {
  font-size: calc(11px + var(--font-offset, 0px));
  color: var(--text-muted, #70757a);
  flex-shrink: 0;
  user-select: none;
}
</style>
