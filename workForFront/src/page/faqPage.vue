<script setup>
import { ref, reactive } from 'vue'
import myHeader from '@/components/header/header.vue';
import { message } from 'ant-design-vue';
import axios from '../plugins/axiosBase.js';
import { useRoute, useRouter } from 'vue-router';
import { CustomerServiceOutlined, CommentOutlined,ExclamationOutlined } from '@ant-design/icons-vue';
// mark 动画效果 
const router = useRouter()
const faqMain = [
{
    title: "我要如何找回密码？",
    content: "请用个人资料中提交的手机号码拨打客服电话，或者使用个人资料中的电子邮箱发送客服电子邮箱。\n联系方式在右下角",
  },
{
    title: "我发送了消息，对面第一时间能收到吗",
    content: "如果对方在线，可以第一时间收到。消息会实时发送给对方。如果不在线，则会在对面上线时，提醒对方",
  },
  {
    title: "如果我阅读了消息不会，对方会不会知道",
    content: "为防止争议，没有显示聊天的阅读状态，仅有未读消息通知",
  },
  {
    title: "审核岗位流程，审核申请招聘流程",
    content: "1. 用户发起请求并提交相关材料\n2. 请求进入审核中状态，客服会根据审核材料与你进行联系\n3. 申请成功",
  },
  {
    title: "为什么访问这么慢",
    content: "服务器预算不足。请稍后重试",
  },
  {
    title: "如何修改个人信息",
    content: "您可以登录到您的账户，然后在个人资料页面进行修改。",
  },
  {
    title: "如何找到合适的职位",
    content: "您可以使用平台提供的搜索功能，根据关键词、地点等条件筛选出符合您需求的职位。",
  },
  {
    title: "如何联系招聘方",
    content: "您可以在职位详情页面找到招聘方提供的联系方式，如电话号码或电子邮件地址。",
  },
  {
    title: "如何查看已申请的职位",
    content: "您可以在您的个人账户中找到“已申请的职位”或类似选项，查看您之前提交的职位申请记录。",
  },
  // {
  //   title: "如何举报虚假招聘信息",
  //   content: "如果您发现虚假招聘信息，您可以在该页面进行举报或者在招聘页面进行举报",
  // // },
  // {
  //   title: "如何设置求职意向",
  //   content: "您可以在个人资料设置中找到“求职意向”或类似选项，填写您的求职意向信息。",
  // },
  {
    title: "如何申请职位",
    content: "在您感兴趣的职位详情页面，您可以找到申请职位的按钮，按照提示完成申请流程。",
  },
  {
    title: "如何查看招聘方的回复",
    content: "您可以在您的个人账户中找到“消息”或类似选项，查看招聘方对您的职位申请的回复。",
  },
  {
    title: "如何提升简历曝光度",
    content: "您可以完善个人资料，添加工作经历、教育背景等信息，提升简历的完整性和吸引力。",
  },
  // {
  //   title: "如何查看招聘会信息",
  //   content: "您可以在平台首页或相关页面找到招聘会信息，了解最新的招聘会时间、地点和参与方式。",
  // },
  // {
  //   title: "如何参加在线面试",
  //   content: "如果您被邀请参加在线面试，您可以在消息中找到面试邀请，按照指引参加在线面试。",
  // },
  {
    title: "如何查看招聘方的公司介绍",
    content: "在职位详情页面，您可以找到招聘方提供的公司介绍，了解公司背景和文化。",
  },
  // {
  //   title: "如何处理忘记密码情况",
  //   content: "如果您忘记密码，您可以通过手机短信或邮箱验证重置密码，确保账户安全。",
  // }
]
const faqActive = ref(Array(faqMain.length).fill(-1))
const faqActiveFunc = (index) => {
  faqActive.value[index] *= -1
  // console.log(faqActive.value);
}
// Mark 原生剪切
const clipboard = navigator.clipboard || {
          writeText: (text) => {
            let copyInput = document.createElement('input');
            copyInput.value = text;
            document.body.appendChild(copyInput);
            copyInput.select();
            document.execCommand('copy');
            document.body.removeChild(copyInput);
          }
        }
const copyText = async (content) => {
  try {
    await clipboard.writeText(content);
    message.success(`已粘贴到剪切板,${content}`);
  } catch {
    message.warning(`粘贴失败,手动输入${content}`);
  }


};
const chatToadmin = () => {
  axios.post("chatToadmin").then((res) => {
    if (res.code == 200) {
      message.info("跳转中")
      router.push('/chatPage')
    } else {
      message.error("返回错误，请登录后重试")
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
  <a-float-button-group trigger="click" type="primary" :style="{ right: '8vw' }" tooltip="联系客服">
    <template #icon>
      <CustomerServiceOutlined />
    </template>
    <!-- <a-float-button  tooltip="举报反馈">
      <template #icon>
        <ExclamationOutlined />
      </template>
    </a-float-button> -->
    <a-float-button @click="copyText('05552333233')" tooltip="联系方式">
      <template #icon>
        <i class="bi bi-telephone"></i>
        <!-- MARK 黏贴到剪切板 -->
      </template>
    </a-float-button>
    <a-float-button @click="copyText('yueyvlunhui@outlook.com')" tooltip="电子邮箱">
      <template #icon>
        <i class="bi bi-envelope"></i>
      </template>
    </a-float-button>
    <!-- done 和客服交流 -->
    <a-float-button @click="chatToadmin()" tooltip="客服反馈">
      <template #icon>
        <CustomerServiceOutlined />
      </template>
    </a-float-button>
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
