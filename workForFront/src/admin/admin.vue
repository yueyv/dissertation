<script setup>
import { ref,reactive,watch} from 'vue'
import navbox from './nav/index.vue';
import {message} from 'ant-design-vue'
import headerbox from '../admin/header/index.vue'
import { debounce } from '../utils/debounce'
import { throttle } from '../utils/throttle'
const nav_list = ref(["用户审查", "职位审查", "用户反馈"])
const nav_show = ref([true, false, false])
const time = ref(true)
function nav_choose(value) {
    message.info(value)
    for (let i = 0; i < nav_show.value.length; i++) {
        nav_show.value[i] = false
    }
    nav_show.value[value] = true
    console.log(nav_show.value);
}
const debouncedLeave = debounce(() => {
    time.value = false
}, 60000);
const throttleEnter = throttle(() => {
    time.value = true
}, 5000)
</script>

<template>
<div id="adminBox">
    <header>
        <headerbox @mouseenter="throttleEnter()" @mouseleave="debouncedLeave()"
                class="animate__animated animate__rubberBand">
            </headerbox>
    </header>

    <navbox :nav_list="nav_list" style="z-index: 3;" :nav_show="nav_show" @nav_choose="nav_choose"></navbox>
    <keep-alive>
    <component :is='' ></component>
    </keep-alive>
</div>
</template>

<style scoped lang='scss'>

#adminBox {
    /* 100%窗口高度 */
    height: 100vh;
    /* 弹性布局 居中 */
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(to top left, #ffe29f, #ffa99f, #ff719a);
}
</style>