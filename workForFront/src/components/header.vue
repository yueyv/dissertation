<script setup lang='js'>
import { ref,reactive} from 'vue'
const city=ref("城市")
</script>

<template>
<header>
    <ul class="top-nav">
        <li>云聘</li>
        <li>{{city}}</li>
        <li>首页</li>
        <li>推荐</li>
        <li>搜素</li>
        <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
        <!-- 留空白 -->
        <li>招聘</li>
        <li>求职</li>
        <li>登录</li>
    </ul>
</header>
</template>

<style scoped lang='scss'>
header{
    // position: fixed;
    top: 0%;
    height: 5vh;
    width: 100%;
    background-color: black;
    opacity: 0.5;
    border-radius: 9px 9px 0px 0px;
}
.top-nav{
    // position: fixed;
    padding: 0 10vw 0 10vw;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    height: 100%;
    line-height: 5vh;
    li{
        flex-grow: 1;
        color: white;
        .active{
            color: red;
        }
        &:hover{
            color: pink;
        }
    }
    :first-child{
        font-size: larger;
        color: red;
    }
}
</style>