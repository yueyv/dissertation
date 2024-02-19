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
        <li><router-link  to="login">登录</router-link>/<router-link to="register">注册</router-link></li>
    </ul>
</header>
</template>

<style scoped lang='scss'>
header{
    // position: fixed;
    top: 0%;
    height: 5vh;
    width: 100%;
    background-color: rgba(0,0,0,0.5);
    border-radius: 9px 9px 0px 0px;
}
.top-nav{
    z-index: 2;
    font-size: 16;
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
        a{
            color: white;
            font-size: inherit;
            text-decoration: none;
            font-size: inherit;
            &:hover{
                color: #f1a9a9;
            }
        }
    }
    li:first-child{
        font-weight: 600;
        font-size: larger;
        color: #f1a9a9;
    }
    li:last-child{
        color: white;
    }
}
</style>