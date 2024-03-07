<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import { useRouter } from 'vue-router'
const router = useRouter()
const permission = ref(1);
onBeforeMount(() => {
    permission.value = JSON.parse(sessionStorage.getItem("permission"))
    console.log(permission.value);
})
const back = () => {
    router.back()
}
const moveToApply = () => {
    router.push('/bringInPage/apply')
}
</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="auth" v-show="permission == 0">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">权限不足</h1>
            <a-button @click="moveToApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">申请</a-button>
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">返回</a-button>
        </div>
    </div>
    <div class="advs">编辑招聘详情</div>
    <div class="edit-job-contain"></div>
</template>

<style scoped lang='scss'>
.auth {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: #00000057;

    .auth-box {
        font-size: 30px;
        background-color: rgba(240, 248, 255, 0.76);
        width: 20vw;
        height: 20vw;
        display: flex;
        justify-items: center;
        flex-direction: column;
        align-items: center;
        border-radius: 30px;
        position: fixed;
        left: 50%;
        top: 40%;
        transform: translate(-50%, -50%);
        ;
    }
}

// .edit-job-contain {}

.advs {
    font-weight: 800;
    color: white;
    letter-spacing: 5px;
    line-height: 180px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 200px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
</style>
