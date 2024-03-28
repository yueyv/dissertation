<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from "vue-router";
import { debounce } from '../../utils/debounce';
import { throttle } from '../../utils/throttle';
import { message } from 'ant-design-vue';
const router=useRouter()
import "animate.css"
const props = defineProps({
    nav_list:{
        type:Array,
        default:["样式", "笔记", "工具"],
    },
    nav_show:{
        type:Array,
        default:[true, false, false],
    }
})
// MARK 防抖节流
const shownav = ref(true)
const enter = throttle(() => { shownav.value = true }, 1000)
 const leave=debounce(()=>{shownav.value=false},60000)
leave()
const emit=defineEmits(['nav_choose'])
function nav_choosed(key){
    emit('nav_choose',key)
}
const exit=()=>{
    localStorage.clear()
    sessionStorage.clear()
    router.push('/adminLogin')
}
</script>

<template>
    <div class="listen" @mouseenter="enter()" @mouseleave="leave()">
        <div class="box animate__animated" :class="{ 'animate__backInLeft': shownav, 'animate__backOutLeft': !shownav }">
            <div class="choose" v-for="key in nav_list.length" :key="nav_list[key-1]" @click="nav_choosed(key-1)" :class="{'choosed':nav_show[key-1]}">
                <span>{{ nav_list[key-1] }}</span>
            </div>
            <br>
            <div class="choose" @click="()=>{shownav=false}">
                <span>隐藏</span>
            </div>
            <div class="choose" @click="exit()">
                <span>退出</span>
            </div>
        </div>
    </div>
</template>

<style scoped lang='less'>
.listen {
    z-index: 1;
    // background-color: #ff719a;
    height: 80vh;
    position: fixed;
    width: 8vh;
    left: 0vw;
    top: 10vh;
}

.box {
    padding-top: 5px;
    padding-bottom: 10px;
    transition: all 1s;
    z-index: 2;
    width: 60px;
    top: 30vh;
    left: 2vw;
    min-height: 300px;
    position: fixed;
    // height: 200px;
    background-color: #ff719a;
    border-radius: 20px;
    display: grid;
    box-shadow: 5ch;
    // visibility: hidden;
    z-index: 1;
    justify-content: center;
    align-items: center;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
    background: linear-gradient(to top left, #ffe29f, #ffa99f, #ff719a);
    color: #ccfffafd;

    &:hover {
        box-shadow: 5px 5px 2px 1px rgba(255, 255, 255,0.3);
        visibility: visible;
        background: linear-gradient(to bottom right, #ffe29f, #ffa99f, #ff719a);
    }
}

.choose {
    width: 45px;
    // height: 30px;
    padding-right: 5px;
    padding-left: 5px;
    padding-top: 10px;
    padding-bottom: 5px;
    font-size: 18px;
    text-align: center;
    overflow: hidden;
    // background-color: #ffe29f;

    &:hover {
        color: #eec3ff;
    }

}
.choosed{
    color: #ff719a;
    background: linear-gradient(200deg, #fab0aa, #7ccfff);
    box-shadow: #ffa99f;
    border-radius: 5px;
}


@keyframes animate {
    0% {
        transform: rotate(0deg);
    }

    100% {
        transform: rotate(360deg);
    }
}</style>