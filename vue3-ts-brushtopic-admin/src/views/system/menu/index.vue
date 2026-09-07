<script setup lang="ts">
import { ref, onMounted, h, createVNode } from 'vue'
import { apiGetMenuList, apiAddMenu, apiDeleteMenu, apiUpdateMenu } from '@/api/system/menu/index'
import type { MenuType } from '@/api/system/menu/type'
import {
  PlusOutlined,
  EditOutlined,
  DeleteOutlined,
  ExclamationCircleOutlined
} from '@ant-design/icons-vue';

import * as Icons from '@ant-design/icons-vue'
import Modal from 'ant-design-vue/es/modal/Modal';
import { message } from 'ant-design-vue';

const iconList = ref(
  Object.keys(Icons)
    .filter(key => key.endsWith('Outlined'))
    .map(key => ({
      value: key,
      label: key,
      icon: Icons[key as keyof typeof Icons]
    }))
)

const getMenuList = async () => {
  const res = await apiGetMenuList(params.value)
  tableData.value = res.data
}

const params = ref({
  menuName: '',
})

const tableData = ref([])

const columns = [
  {
    title: '菜单名称',
    dataIndex: 'menuName',
    key: 'menuName',
    align: 'center',
    width: 180,
  },
  {
    title: '图标',
    dataIndex: 'icon',
    key: 'icon',
    align: 'center',
    width: 100,
  },
  {
    title: '排序',
    dataIndex: 'sorted',
    key: 'sorted',
    align: 'center',
    width: 100,
  },
  {
    title: '路径',
    dataIndex: 'route',
    key: 'route',
    align: 'center',
    width: 150,
  },
  {
    title: '创建时间',
    dataIndex: 'createTime',
    key: 'createTime',
    align: 'center'
  },
  {
    title: '修改时间',
    dataIndex: 'updateTime',
    key: 'updateTime',
    align: 'center'
  },
  {
    title: '操作',
    dataIndex: 'operation',
    key: 'operation',
    align: 'center'
  }
]

const handleQuery = () => {
  getMenuList()
}

const handleReset = () => {
  params.value = {
    menuName: '',
  }
  getMenuList()
}

const formRef = ref<any>(null)

const drawerTitle = ref('新增')

const drawer = ref(false)

const onClose = () => {
  clearFormData()
  drawer.value = false
}

const formData = ref<MenuType>({
  id: null,
  menuName: '',
  icon: '',
  route: '',
  sorted: null,
  parentId: 0
})

const rules = {
  menuName: [{ required: true, message: '请输入菜单名称', trigger: 'blur' }],
  route: [{ required: true, message: '请输入路由路径', trigger: 'blur' }],
  icon: [{ required: true, message: '请选择图标', trigger: 'blur' }],
  sorted: [{ required: true, message: '请输入排序号', trigger: 'blur' }]
}

const treeData = ref<any>([])

const handleTreeData = (data: any) => {
  return data.map((item: any) => ({
    value: item.id,
    title: item.menuName,
    children: item.children ? handleTreeData(item.children) : []
  }))
}

const getTreeData = async () => {
  params.value = {
    menuName: '',
  }
  const res = await apiGetMenuList(params.value)
  
  treeData.value = [{
    value: 0,
    title: '主类目',
    children: handleTreeData(res.data)
  }]
}

const handleAdd = (pId: number) => {
  drawerTitle.value = '新增菜单'
  clearFormData()
  formData.value.parentId = pId
  getTreeData()
  drawer.value = true
}

const handleUpdate = (record: any) => {
  drawer.value = true
  formData.value = {
    ...record
  }
  getTreeData()
}

const clearFormData = () => {
  formData.value = {
    menuName: '',
    id: null,
    icon: '',
    route: '',
    sorted: null,
    parentId: 0  
  }
  if (formRef.value) {
    formRef.value.resetFields()
  }
}

const onSave = () => {
  formRef.value.validate().then(async () => {
    let mes = ''
    console.log(formData.value);
    try {
      
      if (formData.value.id) {
        
        await apiUpdateMenu(formData.value)
        mes = '修改菜单成功'
      } else {
        
        await apiAddMenu(formData.value)

        mes = '新增菜单成功'
      }
      getMenuList()
      clearFormData()
      drawer.value = false
      message.success(mes)
    } catch (error: any) {
      message.error(error.getMessage())
    }
  }).catch(() => {
    message.error('信息有误')
  })
}

const handleDelete = (id: number) => {
  Modal.confirm({
    title: '是否确认删除该菜单?',
    icon: createVNode(ExclamationCircleOutlined),
    content: createVNode('div', { style: 'color:red;' }, '删除菜单会导致相关页面丢失，请慎重考虑!'),
    async onOk() {
      await apiDeleteMenu(id)
      getMenuList()
      clearFormData()
      message.success('删除成功')

    },
    onCancel() {
      console.log('Cancel');
    },
  });
}

onMounted(() => {
  getMenuList()
})
</script>
<template>
  <div class="menu-body">
    <a-space class="space-box">
      <div class="query-box">
        <a-space>
          
          <a-form-item label="菜单名称">
            <a-input placeholder="请输入菜单名称" v-model:value="params.menuName"></a-input>
          </a-form-item>
          <a-form-item>
            <a-space>
              <a-button type='primary' @click="handleQuery">搜索</a-button>
              <a-button @click="handleReset">重置</a-button>
            </a-space>
          </a-form-item>
        </a-space>
      </div>
      
      <a-form-item>
        <a-space>
          <a-button ghost type="primary" :icon="h(PlusOutlined)" @click="handleAdd(0)">新增</a-button>
        </a-space>
      </a-form-item>
    </a-space>
    
    <a-table :pagination="false" :dataSource="tableData" :columns="columns">
      <template #bodyCell="{ column, record }">
        <template v-if="column.key === 'operation'">
          <a-button type="link" size="small" :icon="h(PlusOutlined)" @click="handleAdd(record.parentId)">新增</a-button>
          <a-button type="link" size="small" :icon="h(EditOutlined)" @click="handleUpdate(record)">修改</a-button>
          <a-button type="link" size="small" :icon="h(DeleteOutlined)" @click="handleDelete(record.id)">删除</a-button>
        </template>
        
        <template v-else-if="column.key === 'icon'">
          <span v-if="record.icon">
            <component :is="record.icon" />
          </span>
        </template>
      </template>
    </a-table>
    
    <a-drawer :title="drawerTitle" placement="right" v-model:open="drawer" @close="onClose">
      <a-form ref="formRef" :model="formData" :rules="rules" :label-col="{ span: 6 }" :wrapper-col="{ span: 18 }">
        <a-form-item label="上级菜单" name="parentId">
          <a-tree-select v-model:value="formData.parentId" :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
            :tree-data="treeData" placeholder="请选择上级菜单" allow-clear />
        </a-form-item>
        <a-form-item label="菜单名称" name="menuName">
          <a-input v-model:value="formData.menuName" placeholder="请输入菜单名称" />
        </a-form-item>
        <a-form-item label="路由路径" name="route">
          <a-input v-model:value="formData.route" placeholder="请输入路由路径" />
        </a-form-item>
        <a-form-item label="菜单图标" name="icon">
          <a-select v-model:value="formData.icon" show-search placeholder="请选择图标" :options="iconList" :filter-option="(input: string, option: any) =>
            option.value.toLowerCase().indexOf(input.toLowerCase()) >= 0">
            <template #option="{ value, icon }">
              <span>
                <component :is="icon" /> {{ value }}
              </span>
            </template>
          </a-select>
        </a-form-item>
        <a-form-item label="菜单排序" name="sorted">
          <a-input-number style="width: 100%;" v-model:value="formData.sorted" :min="0" placeholder="菜单排序" />
        </a-form-item>
      </a-form>
      
      <template #footer>
        <a-space class="space-footer-box">
          <a-button @click="onClose">取消</a-button>
          <a-button type="primary" @click="onSave">保存</a-button>
        </a-space>
      </template>
    </a-drawer>
  </div>
</template>
<style lang="scss" scoped>
.space-box {
  display: flex;
  justify-content: space-between;

  .query-box {
    display: flex;
    justify-content: flex-end;
  }
}

.space-footer-box {
  display: flex;
  justify-content: flex-end;
}
</style>
