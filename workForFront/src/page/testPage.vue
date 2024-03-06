<script setup>
import { ref,reactive} from 'vue'
import {Button as AButton,message} from "ant-design-vue"
import {axiosBase} from '../plugins/axiosBase'
import md5 from 'js-md5'   

console.log(md5("233"));
message.info(md5("323"))
</script>

<template>
<a-button @click="" type="primary">Primary Button</a-button>

</template>

<style scoped lang='scss'>

</style>