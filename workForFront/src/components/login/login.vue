<script setup>
import { message } from 'ant-design-vue';
import { ref, onMounted,onBeforeUnmount} from 'vue'
import { useRouter } from 'vue-router';
import axios from '@/plugins/axiosBase.js'
import md5 from 'js-md5'
// 要操作的元素
const router = useRouter()
const account = ref("");
const password = ref("");
const mdtSalt="yueyv";
async function response(res) {
    console.log(res);
        if(res.code==200){
            localStorage.setItem("token", JSON.stringify(res.data))
            localStorage.setItem("userId",JSON.stringify(account.value))
        }
    setTimeout(() => {
        message.info(res.message)
    }, 1000)
}
async function check() {
    localStorage.removeItem('token');
    await axios.post('/login', { account: `${account.value}`,  password: `${md5(password.value+mdtSalt)}` })
        .then(response)
        .catch(err => {
            console.log(err)
        })
}
function login() {
    new Promise((res, rej) => {
        if (password.value == "" || account.value == "") {
            rej("请输入完整")
        }
        else if (account.value.length > 20 || account.value.length < 8) {
            rej('账号长度应在8-20位')
        }
        else if (password.value.length > 20 || password.value.length < 8) {
            rej('密码长度应在8-20位')
        }
        else {
            router.push({
                name: 'loading',
            })
            check();
        }
    }).catch(err => {
        message.error(err)
    })

}
function register() {
    router.push('/register')
}

onMounted(()=>{
    // MARK 预检
    // check()
    document.body.style.overflow = 'hidden';
}) 
onBeforeUnmount(() => {
    document.body.style.overflow = 'auto';
})
</script>

<template>
    <div class="box">
        <div class="container">
            <h1>Welcome</h1>
            <div class="form">
                <input type="text" v-model="account" autofocus placeholder="您的账号">
                <input type="password" v-model="password" placeholder="您的密码">
                <button class="btn-login" @click="login()">登录</button>
                <button class="btn-login" @click="register()">切换注册</button>
            </div>
        </div>
        <ul class="bg-squares">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</template>

<style scoped lang='less'>
.box {
    height: 100vh;
    width: 100vw;
    /* 弹性布局 居中显示 */
    display: flex;
    justify-content: center;
    align-items: center;
    /* 渐变背景 */
    background: linear-gradient(to top left, #ffe29f, #ffa99f, #ff719a);
    /* 溢出隐藏 */
    overflow: hidden;


}

.container {
    text-align: center;
    color: #fff;
    overflow: hidden;
}

.container h1 {
    font-size: 52px;
    font-weight: 100;
    letter-spacing: 2px;
    margin-bottom: 0px;
    /* 过渡效果 */
    transition: 1s ease-in-out;
    color: #fff;
}

.form {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    z-index: 2;
    opacity: 1;
    /* 不透明度改变时的过渡效果 */
    transition: opacity 0.5s;
}

.form input {
    outline: none;
    border: 1px solid rgba(255, 255, 255, 0.4);
    background-color: rgba(255, 255, 255, 0.2);
    width: 250px;
    padding: 10px 15px;
    border-radius: 3px;
    margin: 0 auto 10px auto;
    text-align: center;
    color: #fff;
    font-size: 15px;
    transition: 0.25s;
}

.form input::placeholder {
    color: #fff;
    font-size: 14px;
    font-weight: 300;
}

.form input:hover {
    background-color: rgba(255, 255, 255, 0.4);
}

.form input:focus {
    background-color: #fff;
    width: 300px;
    color: #ff719a;
}

.btn-login {
    outline: none;
    background-color: #fff;
    color: #ff719a;
    border: none;
    width: 280px;
    padding: 10px 15px;
    border-radius: 3px;
    font-size: 15px;
    cursor: pointer;
    transition: 0.25s;
    margin-bottom: 1.5vh;
}

.btn-login:hover {
    background-color: #f5f7f9;
}

/* 背景方块 */
.bg-squares {
    list-style: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: 1;
}

.bg-squares li {
    width: 40px;
    height: 40px;
    background-color: rgba(255, 255, 255, 0.15);
    position: absolute;
    bottom: -160px;
    /* 执行动画：动画名 时长 线性 无限次播放 */
    animation: square 20s linear infinite;
}

/* 为每一个方块设置不同的位置、大小、动画延迟时间、动画时长、背景色 */
.bg-squares li:nth-child(1) {
    left: 10%;
}

.bg-squares li:nth-child(2) {
    left: 20%;
    width: 80px;
    height: 80px;
    /* 动画延迟时间 */
    animation-delay: 2s;
    /* 动画时长 */
    animation-duration: 17s;
}

.bg-squares li:nth-child(3) {
    left: 25%;
    animation-delay: 4s;
}

.bg-squares li:nth-child(4) {
    left: 40%;
    width: 60px;
    height: 60px;
    background-color: rgba(255, 255, 255, 0.25);
    animation-duration: 22s;
}

.bg-squares li:nth-child(5) {
    left: 70%;
}

.bg-squares li:nth-child(6) {
    left: 80%;
    width: 120px;
    height: 120px;
    background-color: rgba(255, 255, 255, 0.2);
    animation-delay: 3s;
}

.bg-squares li:nth-child(7) {
    left: 32%;
    width: 160px;
    height: 160px;
    animation-delay: 7s;
}

.bg-squares li:nth-child(8) {
    left: 55%;
    width: 20px;
    height: 20px;
    animation-delay: 15s;
    animation-duration: 40s;
}

.bg-squares li:nth-child(9) {
    left: 25%;
    width: 10px;
    height: 10px;
    background-color: rgba(255, 255, 255, 0.3);
    animation-delay: 2s;
    animation-duration: 40s;
}

.bg-squares li:nth-child(10) {
    left: 90%;
    width: 160px;
    height: 160px;
    animation-delay: 11s;
}

.container.success h1 {
    transform: translateY(75px);
}

.container.success .form {
    opacity: 0;
    visibility: hidden;
}

/* 定义动画 */
@keyframes square {
    0% {
        transform: translateY(0);
    }

    100% {
        transform: translateY(-120vh) rotate(600deg);
    }
}
</style>