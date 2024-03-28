<script setup >
import { ref, reactive } from 'vue'
import { onMounted, onUnmounted } from 'vue';
import { useRouter } from 'vue-router';
import { message } from 'ant-design-vue';
const router = useRouter()

// MARK鉴定token
const login = setTimeout(() => {
    if ((localStorage.getItem("token")?.length ??1) > 40){
        message.success("登录成功")
        if(sessionStorage.getItem("admin") && JSON.parse(sessionStorage.getItem("admin")) == "yueyv"){
            router.push('/admin')
        }else{
            router.push('/')    
            
        }
    }else{
        message.error("失败，返回")
        router.back()
    }
}, 3000)

onUnmounted(() => {
    clearTimeout(login)
})

</script>

<template>
    <div id="box">
        <div class="container">
            <div class="loading">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <div class="shadow"></div>
        </div>
    </div>
</template>

<style scoped lang='less'>
* {
    /* 初始化 */
    margin: 0;
    padding: 0;
}

#box {
    /* 100%窗口高度 */
    height: 100vh;
    /* 弹性布局 居中 */
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(to top left, #ffe29f, #ffa99f, #ff719a);
}

.container {
    /* 绝对定位 */
    position: absolute;
    top: 40vh;
    width: 6vw;
}

.loading {
    /* 执行动画：动画名 时长 贝塞尔曲线 无限次播放 */
    animation: rotate 2.5s cubic-bezier(0.75, 0, 0.5, 1) infinite;
}

.loading span {
    width: 100px;
    height: 100px;
    display: block;
    position: absolute;
    background-color: #ff8f92;
    border: 1px solid #ff8f92;
    border-radius: 100%;
}

.loading span:nth-child(1) {
    transform: translate(-28px, -28px);
    /* 执行动画：动画名 时长 贝塞尔曲线 无限次播放 */
    animation: animate1 2.5s cubic-bezier(0.75, 0, 0.5, 1) infinite;
}

.loading span:nth-child(2) {
    transform: translate(28px, -28px);
    /* 执行动画：动画名 时长 贝塞尔曲线 无限次播放 */
    animation: animate2 2.5s cubic-bezier(0.75, 0, 0.5, 1) infinite;
}

.loading span:nth-child(3) {
    position: relative;
    border-radius: 0;
    transform: scale(0.98) rotate(-45deg);
    /* 执行动画：动画名 时长 贝塞尔曲线 无限次播放 */
    animation: animate3 2.5s cubic-bezier(0.75, 0, 0.5, 1) infinite;
}

/* 阴影部分 */
.shadow {
    position: relative;
    width: 100px;
    height: 20px;
    background-color: #fafafa;
    border-radius: 50%;
    top: 50px;
    animation: shadow 2.5s cubic-bezier(0.75, 0, 0.5, 1) infinite;
}

/* 定义动画 */
/* 心形 左圆 */
@keyframes animate1 {
    60% {
        transform: scale(0.4);
    }
}

/* 心形 右圆 */
@keyframes animate2 {
    40% {
        transform: scale(0.4);
    }
}

/* 心形 中间部分 */
@keyframes animate3 {
    50% {
        border-radius: 100%;
        transform: scale(0.5) rotate(-45deg);
    }

    100% {
        transform: scale(0.98) rotate(-45deg);
    }
}

/* 再加个心形整体的旋转动画 */
@keyframes rotate {
    50% {
        transform: rotate(360deg);
    }

    100% {
        transform: rotate(720deg);
    }
}

/* 阴影动画 */
@keyframes shadow {
    50% {
        background-color: #f2f2f2;
        transform: scale(0.5);
    }
}
</style>