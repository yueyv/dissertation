<script setup>
import { ref, reactive } from 'vue'
import headerError from '../components/header/header.vue'
import { Button as AButton } from 'ant-design-vue';
</script>

<template>
    <headerError></headerError>
    <div class="wrap">
        <div class="logo">
            <h1>404</h1>
            <div class="errorMes">你可能遇到了错误,请返回重试
                <br>
                <br>
                <a-button type="primary" danger ghost href="/" size="large">返回首页</a-button>

            </div>
        </div>
    </div>


</template>

<style scoped lang='scss'>
.errorMes {
    font-size: 32px;
    position: relative;
    display: block;
    color: aqua;
    width: 60vw;
    text-align: center;
    margin-top: 10vh;
    // background-color: green;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}

.wrap {
    margin: 0 auto;
    width: 1000px;
}

.logo h1 {    
    margin-top: 20vh;
    font-size: 200px;
    color: rgb(219, 219, 150);
    text-align: center;
    margin-bottom: 1px;
    text-shadow: 1px 1px 6px #555;
}

.logo p {
    color: white;
    font-size: 20px;
    margin-top: 1px;
    text-align: center;
}

.logo p span {
    color: lightgreen;
}

.sub a {
    color: yellow;
    background: #06afd8;
    text-decoration: none;
    padding: 5px;
    font-size: 13px;
    font-family: arial, serif;
    font-weight: bold;
}


</style>
