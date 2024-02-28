<script setup lang='js'>
import { ref, reactive, onBeforeMount } from 'vue'
import { Alert } from 'ant-design-vue';
import { getCity, getIP } from '../../hooks/useGetCity'
import { useIPStore } from '../../store/index.js'
import { DownOutlined } from '@ant-design/icons-vue';
import { storeToRefs } from 'pinia'
// TODO使用pinia
const ipStore = useIPStore()
const { city } = storeToRefs(ipStore)
const { useGetIP, useGetCity, manualUpdateCity } = ipStore
// UPDATE 修改为只允许运行一次，待更新
onBeforeMount(() => {
    if (!sessionStorage.getItem("userIP")) {
        useGetIP()
        useGetCity()
    }
})
const switchCity = () => {
    manualUpdateCity("dwawdaw")
}

const props = defineProps({
    activeNav: {
        type: Number,
        default: 0
    }
});
const navItems = [{
    linkTo: '/',
    title: "首页"
}, {
    linkTo: '/commendPage',
    title: "推荐"
}, {
    linkTo: "/searchPage",
    title: "搜索"
}, {
    linkTo: "#",
    title: ""
}, {
    linkTo: "/faqPage",
    title: "FAQ"
}, {
    linkTo: "/bringInPage",
    title: "招聘"
}, {
    linkTo: "/huntJobPage",
    title: "求职"
},]
// TODO 受同源策略,后端更改
// const fetchCity = async () => {
// //   const data = await getCity();
// const data = await getIP();
//   city.value = data;
// };
// fetchCity()
// console.log(props.activeNav);
// 存到store中
const userId = ref(JSON.parse(localStorage.getItem('userId')) ?? "")
// console.log(userId.value);
const exitLogin=()=>{
    localStorage.removeItem("userId")
    localStorage.removeItem("token")
}

</script>


<template>
    <header>
        <ul class="top-nav">
            <li>云聘</li>
            <li style="display: flex;justify-content: center; align-items: center;"><img
                    style="width: 1.2em;margin-bottom: 3px;"
                    src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMjQgMjQiPjxwYXRoIGZpbGw9IiMwMjg0YzciIGQ9Ik0xMiAxMnEuODI1IDAgMS40MTMtLjU4N1QxNCAxMHEwLS44MjUtLjU4Ny0xLjQxMlQxMiA4cS0uODI1IDAtMS40MTIuNTg4VDEwIDEwcTAgLjgyNS41ODggMS40MTNUMTIgMTJtMCAxMHEtNC4wMjUtMy40MjUtNi4wMTItNi4zNjJUNCAxMC4ycTAtMy43NSAyLjQxMy01Ljk3NVQxMiAycTMuMTc1IDAgNS41ODggMi4yMjVUMjAgMTAuMnEwIDIuNS0xLjk4NyA1LjQzOFQxMiAyMiIvPjwvc3ZnPg==">
                <div>{{ city }}
                    <p class="city-input" @click="switchCity()">[切换]</p>
                </div>
            </li>
            <!-- TODO 从后端返回city数据，[切换按钮实现手动输入] -->
            <!-- 通过ip和腾讯服务实现 -->
            <li v-for="(item, index) in navItems" :key="index" :class="index == activeNav ? `active` : ``">
                <router-link :to="item.linkTo">
                    {{ item.title }}
                </router-link>
            </li>
            <li v-if="!userId"><router-link to="login">登录</router-link>/<router-link to="register">注册</router-link></li>
            <li v-else class="user-id">
                <a-dropdown>
                    <router-link to="chatPage" class="ant-dropdown-link" @click.prevent>
                        {{ userId }}
                        <DownOutlined />
                    </router-link>
                    <template #overlay>
                        <a-menu>
                            <a-menu-item>
                                <router-link to="personalPage" >个人中心</router-link>
                            </a-menu-item>
                            <a-menu-item>
                                <router-link to="chatPage" >聊天页面</router-link>
                            </a-menu-item>
                            <a-menu-item>
                                <router-link to="homePage" @click="exitLogin">退出</router-link>
                            </a-menu-item>
                        </a-menu>
                    </template>
                </a-dropdown>
            </li>
        </ul>
    </header>
</template>

<style scoped lang='scss'>
header {
    // position: fixed;
    top: 0%;
    height: 5vh;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    border-radius: 9px 9px 0px 0px;
}

.user-id {
    background-color: rgba(127, 255, 212, 0.603);
    border-radius: 20px;

    &:hover {
        background-color: rgba(127, 255, 212);
    }
}

.top-nav {
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

    li {
        flex-grow: 1;
        color: #FFFFFF;

        &.active {
            color: #FF4081;
            pointer-events: none;
        }

        &:hover {
            color: #E91E63;
        }

        a {
            color: inherit;
            font-size: inherit;
            text-decoration: none;
            font-size: inherit;

            &:hover {
                color: #E91E63;
            }
        }

        &:nth-child(2) {
            color: #FFFFFF;
        }
    }

    li:first-child {
        font-weight: 600;
        font-size: larger;
        color: #f1a9a9;
    }

    li:last-child {
        color: white;
    }
}

.city-input {
    display: inline-block;
    font-size: x-small;

    &:hover {
        color: #E91E63;
    }
}</style>