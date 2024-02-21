<script setup>
import { ref,reactive} from 'vue'
import {AButton} from "ant-design-vue"
import {axiosBase} from '../pingins/axiosBase'
const testAxios=axiosBase.get('/ask_city').then((e)=>{
    console.log(e);
})
</script>

<template>
<a-button @click="testAxios" type="primary">Primary Button</a-button>
</template>

<style scoped lang='scss'>

</style>