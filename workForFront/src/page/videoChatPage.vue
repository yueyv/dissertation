<script setup>
import { ref, reactive, onBeforeMount,shallowReactive } from 'vue'
import {message} from 'ant-design-vue'
import { useRouter } from "vue-router";
import nprogress from "nprogress";
import { useVideoChatStore } from "../store/index";

let videoChatTo = ref()
const videoMode = ref(false)
const isReady=ref(false)
const isVideoChat = ref(false)
const isVideoScreen = ref(false)
const videoChat=useVideoChatStore()
const formData = shallowReactive({
  username: "",
  password: "",
  serverIP: ""
});
const userId = ref("未登录")
async function getId() {
    try {
        userId.value = JSON.parse(localStorage.getItem("userId")??'undefined')
    } catch (error) {
        console.error('Error:', error);
    }
   
    
}
const FromUserHandler = () => {
  formData.username = userId.value;
  formData.password = "1";
  formData.serverIP = "h5rtc.oraycn.com";
  // formData.serverIP = "192.168.0.234";
};
const videoChatStart=()=>{
    if(formData.username=='undefined'||formData.username=='未登录'){
        return message.error("请返回重试")
    }
    nprogress.start()
    // P2P
    videoChat.multimediaManager.Initialize(
    formData.username,
    formData.password,
    formData.serverIP,
    9900,
    {
      // MARK P2P连接
      iceServers: [
        { urls: "stun:47.109.16.11:3478" },
        {
          urls: "turn:47.109.16.11:3478",
          username: "liliang",
          credential: "123456"
        }
      ],
      iceTransportPolicy: "all"
    },
    (res) => {
      nprogress.done();
      if (res.logonResult === 0) {
        message.success("上线成功");
        // 更新与服务器连接状态
        videoChat.updateServerConnect(true);
        // 跳转页面
        // router.replace("/home");
        // 缓存必要信息
        localStorage.setItem(
          "videoChatFrom",
          JSON.stringify({
            username: formData.username,
            serverIP: formData.serverIP,
          })
        );
      } else {
        message.error("请重试");
      }
    }
  );
}
onBeforeMount(() => {
    
    Object.keys(H5Media).forEach((key) => {
          if (key !== "default") {
            window[key] = H5Media[key];
          }
        });
    getId()
    if (sessionStorage.getItem("videoChat")) {
        videoChatTo.value = JSON.parse(sessionStorage.getItem("videoChat")??"")
        isReady.value=true
        console.log(videoChatTo.value);
    }
    videoChat.initMultimediaManager();
    FromUserHandler()
    videoChatStart()

}) 
</script>

<template>
    <a-layout class="container">
        <a-layout-header class="header">
            <div class="box">
        <!-- <img src="/FeHeart.svg" alt="no"> -->
        <h1>在线中</h1>
    </div>
        </a-layout-header>
        <a-layout class="header">
            <a-layout-sider :width="'40vw'" class="sider">
                <h1 class="title">我的摄像头</h1>
                <div class="my-video">

                </div>
                <div class="video-to">
                    <div v-if="!isReady">
                        <h2 class="title" style="padding-top: 40px;">面试对象：</h2>
                        </div>
                        <div v-else>
                            <h2 class="title" style="padding-top: 40px;">面试对象：{{ videoChatTo.label }}</h2>
                        </div>
                    
                    <div style="text-align: center;">
                        <div v-if="!isVideoChat">
                            <a-button style="margin-top: 40px;" ghost type="primary">申请视频聊天（空闲）</a-button>
                        </div>
                        <div v-else>
                            <a-button style="margin-top: 40px;" ghost type="primary" disabled>视频聊天已开启</a-button>
                        </div>
                        <!-- <a-button danger>Danger Default</a-button> -->

                    </div>
                    <div style="text-align: center;">
                        <div v-if="!isVideoScreen">
                            <a-button style="margin-top: 15px;" ghost type="primary">申请分享屏幕（空闲）</a-button>
                        </div>
                        <div v-else>
                            <a-button style="margin-top: 15px;" ghost type="primary" disabled>屏幕分享已开启</a-button>
                        </div>
                        <!-- <a-button type="primary">Primary Button</a-button>
                        <a-button danger>Danger Default</a-button> -->

                    </div>
                    <div style="text-align: center;">
                        <div v-if="videoMode">
                            <a-button style="margin-top: 15px;" ghost type="primary">当前显示视频聊天</a-button>
                        </div>
                        <div v-else>
                            <a-button disabled style=" margin-top: 15px;" ghost type="primary">当前显示屏幕分享</a-button>
                        </div>
                        <a-button style="margin-top: 15px;" ghost>切换显示</a-button>
                    </div>
                </div>

            </a-layout-sider>

            <a-layout-content class="content">
                <div class="content-header">
                    <p class="title">面试摄像头</p>
                </div>
                <div v-show="!videoMode" class="video-chat">

                </div>
                <div v-show="videoMode" class="video-chat">

                </div>
            </a-layout-content>
        </a-layout>
        <a-layout-footer class="footer"></a-layout-footer>
    </a-layout>
</template>

<style scoped lang='scss'>
.box {
    transition: all 1s;
    z-index: 2;
    width: 200px;
    top: 5vh;
    left: 80vw;
    position: absolute;
    height: 50px;
    background-color: #ff719a;
    border-radius: 20px;
    display: flex;
    box-shadow: 5ch;
    // visibility: hidden;
    z-index: 3;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
    background: linear-gradient(to top left, #ffe29f, #ffa99f, #ff719a);
    text-align: center;
    line-height: 50px;
    h1 {
        font-size: 1.2rem;
        font-weight: 600;
        color: whitesmoke;
        text-align: center;
        line-height: 50px;
        display: inline-block;
        // position: absolute;
        left: 70px;
    }

    &:hover {
        box-shadow: 5px 5px 2px 1px rgba(255, 255, 255, 0.3);
        visibility: visible;
        background: linear-gradient(to bottom right, #ffe29f, #ffa99f, #ff719a);
        transform: all 0.6s linear;
        transition-delay: 0.5s;
    }
}
.title {
    text-align: center;
    color: white;
    font-size: 1.5rem;

}

.my-video {
    background-color: aqua;
    height: 40%;
    // padding: 20px;
    margin: 20px;
    border-radius: 10px;
}

.video-to {
    background-color: rgba(97, 255, 255, 0.651);
    height: 40%;
    // padding: 20px;
    margin: 10vh 20px 20px 20px;
    border-radius: 10px;
}

.video-chat {
    background-color: rgb(0, 238, 238);
    height: 90%;
    // padding: 20px;
    margin: 25px 20px 20px 20px;
    border-radius: 10px;
}

.header {
    background-color: rgba(255, 255, 255, 0);
    // background-color: aqua;
}

.container {
    background-color: rgba(255, 255, 255, 0);
    height: 100vh;
    width: 100vw;
}

.sider {
    // width: 40vw;
    background-color: rgba(255, 255, 255, 0);
}

.content {
    background-color: rgba(255, 255, 255, 0);
}

.footer {
    opacity: 1;
    background-color: rgba(255, 255, 255, 0);
}
</style>