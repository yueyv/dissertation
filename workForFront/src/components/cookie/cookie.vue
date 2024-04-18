<script setup>
import { message } from 'ant-design-vue';
import { ref,reactive} from 'vue'
const isShow=ref('true')
const closeWindow = () => {
    isShow.value=false
}
const accept = () => {
    isShow.value=false
    localStorage.setItem('isAcceptCookie',JSON.parse(true))
}
</script>

<template>
    <div class="cookie-mes" v-if="isShow">
        <h2>是否允许该网站使用你的COOKIE，以更好地进行服务。</h2>
        <h2>如果不允许，您的访问可能受限</h2>
        <a-button type="primary"  style="margin-right: 50px;" @click="accept()">允许使用COOKIE</a-button>

        <a-button ghost danger  @click="closeWindow()">拒绝</a-button>
    </div>

</template>

<style scoped lang='scss'>
.cookie-mes{

    padding-top: 3vh;
    z-index: 9999;
    height: 15vh;
    position: fixed;
    top: 85vh;
    border-radius: 20px 20px 0 0;
    background-color: grey;
    width: 100vw;
    text-align: center;
    font-size: 24px;
    line-height: 30px;
    color: aliceblue;
}
</style>