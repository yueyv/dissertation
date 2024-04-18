<script setup>
import { ref,reactive} from 'vue'
import myHeader from '@/components/header/header.vue';
import {
    AlignCenterOutlined,EditOutlined 
} from '@ant-design/icons-vue';
</script>

<template>
  <myHeader :active-nav="0"></myHeader>
  <a-float-button-group trigger="click" type="primary" :style="{ right: '8vw' }" tooltip="编辑公司信息">
        <template #icon>
            <EditOutlined />
        </template>
        <a-float-button tooltip="编辑公司信息">
            <template #icon>
                <router-link to="/editCompanyPage">
                    <EditOutlined />
                </router-link>
            </template>
        </a-float-button>
        <a-float-button tooltip="查看公司信息">
            <template #icon>
                <router-link to="/personalPage">
                    <AlignCenterOutlined />
                </router-link>
            </template>
        </a-float-button>
    </a-float-button-group>
</template>

<style scoped lang='scss'>

</style>