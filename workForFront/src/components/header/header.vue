<script setup lang='js'>
import { ref,reactive} from 'vue'
import {Alert} from 'ant-design-vue';
import {getCity,getIP} from '../../hooks/useGetCity'
import {useIPStore} from '../../store/index.js'
import { storeToRefs } from 'pinia'
// 使用pinia
const ipStore=useIPStore()
const {ip}=storeToRefs(ipStore)
const {useGetIP}=ipStore
const fetchIP=async()=>{
    console.log(222);
    await useGetIP()
    console.log(ip.value);
}
fetchIP()
const city=ref("定位中")
const props = defineProps({
  activeNav: {
    type: Number,
    default: 0 
  }
});
const navItems=[{
    linkTo:'/',
    title:"首页"
},{
    linkTo:'#',
    title:"推荐"
},{
    linkTo:"/searchPage",
    title:"搜素"
},{
    linkTo:"#",
    title:""
},{
    linkTo:"/faqPage",
    title:"FAQ"
},{
    linkTo:"/bringInPage",
    title:"招聘"
},{
    linkTo:"/huntJobPage",
    title:"求职"
},]
// TODO 受同源策略,后端更改
// const fetchCity = async () => {
// //   const data = await getCity();
// const data = await getIP();
//   city.value = data;
// };
// fetchCity()
console.log(props.activeNav);
// 存到store中
</script>

<template>
<header>
    <ul class="top-nav">
        <li>云聘</li>
        <li style="display: flex;justify-content: center; align-items: center;" ><img  style="width: 1.2em;margin-bottom: 3px;" src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiMwMjg0YzciIGQ9Ik0xMiAxMnEuODI1IDAgMS40MTMtLjU4N1QxNCAxMHEwLS44MjUtLjU4Ny0xLjQxMlQxMiA4cS0uODI1IDAtMS40MTIuNTg4VDEwIDEwcTAgLjgyNS41ODggMS40MTNUMTIgMTJtMCAxMHEtNC4wMjUtMy40MjUtNi4wMTItNi4zNjJUNCAxMC4ycTAtMy43NSAyLjQxMy01Ljk3NVQxMiAycTMuMTc1IDAgNS41ODggMi4yMjVUMjAgMTAuMnEwIDIuNS0xLjk4NyA1LjQzOFQxMiAyMiIvPjwvc3ZnPg==">
            <div>{{city}}</div>
        </li>
        <li v-for="(item,index) in navItems" :key="index" :class="index==activeNav?`active`:``">
            <router-link :to="item.linkTo">
                {{ item.title }}
            </router-link>
        </li>
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
    font-size: 1.2rem;
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
        color: #FFFFFF;
        &.active{
            color: #FF4081;
            pointer-events: none;
        }
        &:hover{
            color: #E91E63;
        }
        a{
            color: inherit;
            font-size: inherit;
            text-decoration: none;
            font-size: inherit;
            &:hover{
                color: #E91E63;
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