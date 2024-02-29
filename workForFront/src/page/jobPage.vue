<script setup>
import { ref, reactive } from 'vue'
import { useRoute } from "vue-router";
import myHeader from '@/components/header/header.vue';
const route = useRoute()
console.log(route.params.id);
const clickButton=()=>{

}
</script>

<template>
    <myHeader :active-nav="6"></myHeader>
    <div class="advs">
        <p style="padding-top: 40px;">职业名称{{ route.params.id }}</p>
        <!-- 传参 -->
        <p style="padding-top: 10px; font-size: 20px;">城市</p>
        <a-space style="">
            <a-button type="primary" ghost @click="">立刻沟通</a-button>
        </a-space>

    </div>
    <div class="job-content">
            <div class="job-title">职位描述</div>
            <div class="job-detail">adawjdliawjdildawjwi</div>
            <div class="job-title">工资福利</div>
            <div class="job-detail">adawjdliawjdildawjwi</div>
        </div>
</template>

<style scoped lang='scss'>
.advs {
    font-weight: 800;
    color: white;
    letter-spacing: 5px;
    line-height: 40px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 200px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
.job-content{
    overflow: scroll;

    margin-top: 5vh;
    background-color: rgba(255, 255, 255, 0.61);
    height: 60vh;
    width: 80vw;
    margin-left: 10vw;
    border-radius: 20px;
    &::-webkit-scrollbar {
        display: none;
    }
}
.job-title{
    margin-left: 80px;
    padding-top: 40px;
    font-size: 1.5rem;
}
.job-detail{
    margin-left: 80px;
    padding-top: 40px;
    width: calc(80vw - 160px);
    line-height: 1.5rem;
    font-size: 1.2rem;
}
</style>
