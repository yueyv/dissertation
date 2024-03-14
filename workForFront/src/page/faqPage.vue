<script setup>
import { ref, reactive } from 'vue'
import myHeader from '@/components/header/header.vue';
import { message } from 'ant-design-vue';
import axios from '../plugins/axiosBase.js';
import { useRoute, useRouter } from 'vue-router';
import { CustomerServiceOutlined, CommentOutlined } from '@ant-design/icons-vue';
// mark 动画效果 
const router = useRouter()
const faqMain = [
  {
    title: "为什么没有消息推送",
    content: "通过存储的登录时间和此次登录时间的时间差之中的消息来实现（能力不足，暂定）",

  }, {
    title: "我发送了消息，对面第一时间能收到吗",
    content: "如果对方在线，可以第一时间收到",

  }, {
    title: "审核流程",
    content: "1:发起请求\n2:审核中\n3:审核成功OR失败",

  }, {
    title: "为什么访问这么慢",
    content: "服务器在国外",
  }, {
    title: "随便扯点把",
    content: "我嘟嘟嘟嘟嘟",
  },
]
const faqActive = ref(Array(5).fill(-1))
const faqActiveFunc = (index) => {
  faqActive.value[index] *= -1
  // console.log(faqActive.value);
}
// Mark 原生剪切
const copyText = async (content) => {
  try {
    await navigator.clipboard.writeText(content);
    message.success(`已粘贴到剪切板,${content}`);
  } catch {
    message.warning(`粘贴失败,手动输入${content}`);
  }


};
const chatToadmin=()=>{
  axios.post("chatToadmin").then((res)=>{
    if(res.code==200){
      message.info("跳转中")
      router.push('/chatPage')
    }else{
      message.error("服务器错误")
    }
  })
}
</script>

<template>
  <myHeader :active-nav="4"></myHeader>
  <div class="advs">使用说明及反馈</div>
  <div class="tip-head" v-for="(item, index) in faqMain" @click="faqActiveFunc(index)">
    <p>{{ item.title }}</p><i :class="faqActive[index] > 0 ? 'rotating-element' : ''" class="bi bi-arrow-up-short"
      style="font-size: 30px; color: white; justify-self: end; padding: 0px 5px;"></i>
    <p class="faqContent" :class="faqActive[index] < 0 ? 'hidden' : ''">{{ item.content }}</p>
  </div>
  <a-float-button-group trigger="click" type="primary" :style="{ right: '8vw' }">
    <template #icon>
      <CustomerServiceOutlined />
    </template>
    <a-float-button @click="copyText('05552333233')">
      <template #icon>
        <i class="bi bi-telephone"></i>
        <!-- MARK 黏贴到剪切板 -->
      </template>
    </a-float-button>
    <a-float-button @click="copyText('yueyvlunhui@outlook.com')">
      <template #icon>
        <i class="bi bi-envelope"></i>
      </template>
    </a-float-button>
    <!-- done 和客服交流 -->
    <a-float-button @click="chatToadmin()">
      <template #icon>
        <CustomerServiceOutlined />
      </template></a-float-button>
  </a-float-button-group>
</template>

<style scoped lang='scss'>
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

.tip-head {
  color: white;
  margin-left: 15vw;
  margin-top: 20px;
  margin-right: 15vw;
  padding-right: 20px;
  background-color: #e7cbc8;
  // height: 40px;
  border-radius: 20px;
  padding-left: 20px;
  line-height: 40px;
  display: grid;
  grid-template-columns: 1fr auto;

  &:hover {
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.5);
  }
}

@keyframes rotate180 {
  0% {
    transform: rotate(0deg);
    /* 开始时角度为 0 度 */
  }

  100% {
    transform: rotate(180deg);
    /* 结束时角度为 180 度 */
  }
}

.rotating-element {
  transform-origin: center center;
  /* 将变换原点设置为元素中心 */
  animation: rotate180 0.5s linear forwards;
  /* 应用旋转动画 */
}

.faqContent {
  height: 100px;
  overflow: hidden;
  transition: height 0.5s ease;
}

.hidden {
  height: 0px;
  overflow: hidden;
  transition: height 0.5s ease;
}
</style>
