<script setup>
import { ref,reactive} from 'vue'
import headerError from '../components/header/header.vue'
import { Button as AButton} from 'ant-design-vue' ;
</script>

<template>
    <headerError></headerError>
    <box class="errorMes">你可能遇到了错误,请返回重试
        <br>
        <br>
        <a-button type="primary" danger ghost href="/" size="large">返回首页</a-button>
    </box>
    
</template>

<style scoped lang='scss'>
.errorMes{
    font-size: 32px;
    position: relative;
    display: block;
    color: aqua;
    width: 60vw;
    text-align: center;
    margin-top: 40vh;
    // background-color: green;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
}

</style>
