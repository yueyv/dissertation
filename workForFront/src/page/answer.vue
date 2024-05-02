<script setup>
import "@wangeditor/editor/dist/css/style.css"; // 引入 cs
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";
import { onBeforeUnmount, ref, shallowRef, onMounted } from "vue";
import { message } from "ant-design-vue";
import { useRoute } from "vue-router";
const editorRef = shallowRef();
const route = useRoute();
const target = "answer";
const logText = ref("");
const logshow = ref(true);
const targetUsername = target == "offer" ? "发起者" : "接收者";
const videoMode = ref(false);
const isActiveRequestVideo = ref(false);
const isActiveRequestDesktop = ref(false);
const isReady = ref(false);
const testServer = "ws://localhost:9900";
const toolbarConfig = {};
const textarea = ref();
const valueHtml = ref("");
const open1 = ref(false);
const open2 = ref(false);
const editorConfig = {
  placeholder: "请输入内容进行展示",
  MENU_CONF: {},
};
editorConfig.MENU_CONF["uploadImage"] = {
  base64LimitSize: 1024 * 1024, // 5kb
};
onBeforeUnmount(() => {
  const editor = editorRef.value;
  if (editor == null) return;
  editor.destroy();
});
const handleCreated = (editor) => {
  editorRef.value = editor; // 记录 editor 实例，重要！
};
if (target == "error") {
  message.error("错误。返回重试");
}
const logger = {
  log(msg) {
    logText.value += `<span>${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
  },
  error(msg) {
    logText.value += `<span class="error">${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
  },
};
const PeerConnection =
  window.RTCPeerConnection ||
  window.mozRTCPeerConnection ||
  window.webkitRTCPeerConnection;
!PeerConnection && logger.error("浏览器不支持WebRTC！");
const peer = new PeerConnection();
const peerVideo = new PeerConnection();
const socket = new WebSocket(testServer);
let localVideo;
let stream;

async function startLiveDesktop(offerSdp) {
  try {
    logger.log("尝试调取屏幕");
    stream = await navigator.mediaDevices.getDisplayMedia({
      video: true,
      audio: true,
    });
    logger.log("屏幕获取成功");
    // 本地屏幕获取成功
    localVideo.srcObject = stream;
  } catch (e) {
    console.log(e);
    message.info("摄像头/麦克风获取失败！");
    logger.error("屏幕分享摄像头/麦克风获取失败！");
    logger.error("获取失败！");
    return;
  }

  logger.log(
    `------ WebRTC ${target === "offer" ? "发起方" : "接收方"}流程开始 ------`
  );
  logger.log("将媒体轨道添加到轨道集");
  stream.getTracks().forEach((track) => {
    peer.addTrack(track, stream);
  });
  try {
    if (!offerSdp) {
      logger.log("创建本地SDP");
      const offer = await peer.createOffer();
      await peer.setLocalDescription(offer);

      logger.log(`传输发起方本地SDP`);
      socket.send(JSON.stringify(offer));
    } else {
      logger.log("接收到发送方SDP");
      await peer.setRemoteDescription(offerSdp);

      logger.log("创建接收方（应答）SDP");
      const answer = await peer.createAnswer();
      logger.log(`传输接收方（应答）SDP`);
      socket.send(JSON.stringify(answer));
      await peer.setLocalDescription(answer);
    }
  } catch (error) {
    console.log(error);
  }
}
let sendSDPDesktop;
onMounted(() => {
  localVideo = document.querySelector("#local-video");
  // remoteVideo = document.querySelector("#remote-video");
  // remoteDesktop=document.querySelector("#remote-desktop");

  localVideo.onloadeddata = () => {
    logger.log("播放本地视频");
    localVideo.play();
  };

  // remoteVideo.onloadeddata = () => {
  //     logger.log("播放对方视频");
  //     remoteVideo.play();
  // };

  // remoteDesktop.onloadeddata = () => {
  //     logger.log("播放对方屏幕");
  //     remoteDesktop.play();
  // };

  logger.log("信令通道（WebSocket）创建中......");

  socket.onopen = () => {
    logger.log("信令通道创建成功！");
  };
  socket.onerror = () => logger.error("信令通道创建失败！");
  socket.onmessage = (e) => {
    const { type, sdp, iceCandidate } = JSON.parse(e.data);
    if (type === "answer") {
      peer.setRemoteDescription(
        new RTCSessionDescription({
          type,
          sdp,
        })
      );
    } else if (type === "answer_ice") {
      peer.addIceCandidate(iceCandidate);
    } else if (type === "offer") {
      open2.value = true;
      sendSDPDesktop = () => {
        open2.value = false;
        startLiveDesktop(
          new RTCSessionDescription({
            type,
            sdp,
          })
        );
      };
    } else if (type === "offer_ice") {
      peer.addIceCandidate(iceCandidate);
    } else if (type == "chatMessage") {
      message.info(`收到消息：${iceCandidate}`);
    } else if (type == "closeShare") {
      message.info("对方断开连接");
      stopSharing();
    }
  };
  // peer.ontrack = (e) => {
  //     if (e && e.streams) {
  //         logger.log("收到对方音频/视频流数据...");
  //         remoteVideo.srcObject = e.streams[0];
  //     }
  // };
  peer.onicecandidate = (e) => {
    if (e.candidate) {
      logger.log("搜集并发送候选人");
      socket.send(
        JSON.stringify({
          type: `${target}_ice`,
          iceCandidate: e.candidate,
        })
      );
    } else {
      logger.log("候选人收集完成！");
    }
  };
});

const toggleVideoMode = () => {
  videoMode.value = !videoMode.value;
};

const closeVideo = () => {
  isActiveRequestVideo.value = false;
};

const closeDesktop = () => {
  isActiveRequestDesktop.value = false;
};
const showLog = () => {
  logshow.value = !logshow.value;
};
const sendMeg = () => {
  if (textarea.value != null) {
    message.success(`已发送信息:${textarea.value}`);
    socket.send(
      JSON.stringify({
        type: `chatMessage`,
        iceCandidate: textarea.value,
      })
    );
    textarea.value = null;
  } else {
    message.error("消息为空");
  }
};
function stopSharing() {
  if (stream) {
    stream.getTracks().forEach((track) => {
      track.stop(); // 停止轨道的捕获
    });
  }
  logger.log("断开连接");
  stream = null;
  peer.close();
}
function stopSharingAndNotify() {
  function notifyStopSharing() {
    socket.send(
      JSON.stringify({
        type: `closeShare`,
        iceCandidate: "对方已断开视频",
      })
    );
  }
  notifyStopSharing();
  if (stream) {
    stream.getTracks().forEach((track) => {
      track.stop(); // 停止轨道的捕获
    });
  }
  stream = null;
  peer.close();
  logger.log("断开连接");
  message.info("已断开");
}
</script>
<template>
  <a-modal v-model:open="open1" title="申请视频聊天通知框" @ok="starDesktop()">
    <p>确定接受视频聊天</p>
  </a-modal>
  <a-modal
    v-model:open="open2"
    title="申请屏幕分享通知框"
    @ok="sendSDPDesktop()"
  >
    <p>确定接受屏幕分享</p>
  </a-modal>
  <div class="logger" v-if="logshow">
    <div v-html="logText"></div>
  </div>
  <a-layout class="container">
    <a-layout-header class="header">
      <div class="box" @click="showLog()">
        <h1>查看日志</h1>
      </div>
    </a-layout-header>
    <a-layout class="header">
      <a-layout-sider :width="'40vw'" class="sider">
        <h1 class="title">我的摄像头</h1>
        <div class="my-video" style="overflow: hidden">
          <video id="local-video" autoplay></video>
        </div>
        <div class="video-to" style="overflow: hidden">
          <div v-if="!isReady">
            <h2 class="title" style="padding-top: 10px">
              交流对象：{{ targetUsername }}
            </h2>
          </div>
          <div v-else>
            <h2 class="title" style="padding-top: 10px">
              交流对象：{{ targetUsername }}
            </h2>
          </div>
          <div style="text-align: center">
            <div v-if="!isActiveRequestVideo">
              <a-button disabled style="margin-top: 10px" ghost type="primary"
                >等待视频聊天</a-button
              >
            </div>
            <div v-else>
              <a-button style="margin-top: 10px" ghost type="primary" disabled
                >视频聊天已开启</a-button
              >
            </div>
          </div>
          <div style="text-align: center">
            <div v-if="!isActiveRequestDesktop">
              <a-button
                disabled
                style="margin-top: 10px"
                ghost
                type="primary"
                @click="startLiveDesktop()"
                >等待分享屏幕</a-button
              >
            </div>
            <div v-else>
              <a-button style="margin-top: 10px" ghost type="primary" disabled
                >屏幕分享已开启</a-button
              >
            </div>
          </div>
          <div style="text-align: center">
            <div v-if="!videoMode">
              <a-button disabled style="margin-top: 10px" ghost type="primary"
                >当前显示视频聊天</a-button
              >
            </div>
            <div v-else>
              <a-button disabled style="margin-top: 10px" ghost type="primary"
                >当前显示屏幕分享</a-button
              >
            </div>
            <!-- <a-button style="margin-top: 10px" ghost @click="toggleVideoMode()">切换显示</a-button> -->
            <div style="margin-top: 20px; border-radius: 20px">
              <a-textarea
                v-model:value="textarea"
                placeholder="在此发送信息..."
                :auto-size="{ minRows: 5, maxRows: 5 }"
              />
              <a-button
                @click="sendMeg()"
                style="margin-top: 10px"
                ghost
                type="primary"
                >发送</a-button
              >
            </div>
          </div>
        </div>
      </a-layout-sider>

      <a-layout-content class="content">
        <div class="content-header">
          <p class="title">展示</p>
        </div>
        <div class="video-chat">
          <div
            v-show="!videoMode"
            class="video-area"
            style="background-color: aliceblue"
          >
            <div style="border: 1px solid #ccc" class="wangeditor-container">
              <Toolbar
                style="border-bottom: 1px solid #ccc"
                :editor="editorRef"
                :defaultConfig="toolbarConfig"
                :mode="mode"
              />
              <Editor
                style="height: 500px; overflow-y: hidden"
                v-model="valueHtml"
                :defaultConfig="editorConfig"
                :mode="mode"
                @onCreated="handleCreated"
              />
            </div>
            <div class="close-btn" @click="stopSharingAndNotify()">
              <!-- <br /> -->
              <p>结束视频会话</p>
            </div>
          </div>
        </div>
      </a-layout-content>
    </a-layout>
    <a-layout-footer class="footer"></a-layout-footer>
  </a-layout>
</template>

<style lang="scss" scoped>
.wangeditor-container {
  // margin-top: ;
  height: 100%;
  border-radius: 20px;
  overflow: hidden;
  width: 100%;
  // height: 80vh;
  //   margin: 5vh auto;
}
.monitored {
  margin-top: 40px;
  text-align: center;
  line-height: 40px;
  position: absolute;
  padding: 4px 4px;
  height: 50px;
  border-radius: 3px;
  background-color: #fff;
  color: #000;
  box-shadow: 0 0 10px #666;
  left: 50%;
  transform: translateX(-50%);

  .username {
    color: red;
    margin-right: 3px;
  }

  .stop-btn:hover {
    filter: brightness(1.1);
  }
}

.username {
  color: red;
  margin-right: 3px;
}

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
    width: 100%;
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
  height: 50%;
  // padding: 20px;
  margin: 20px 20px 20px 20px;
  border-radius: 10px;
}

.video-chat {
  // background-color: rgb(0, 238, 238);
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

.video-area,
.desktop-area {
  border-radius: 10px;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.video-area {
  width: 100%;
  height: 100%;
  // position: relative;

  // display: flex;
  flex-direction: column;

  #remote-video {
    // height: calc(100% - 120px);
    height: 100%;
    width: 100%;
    background-color: #303030;
  }
}

.video-btns {
  flex-shrink: 0;
  margin-top: 5px;
  height: 80px;
  display: flex;
  gap: 10vw;
  position: relative;
  // background-color: #fff;

  > div {
    font-size: 10px;
    cursor: pointer;
    padding: 8px 20px;
    color: #fff;
    transition: all 0.2s;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 10px;
    // background-color: #41555d;

    &:hover {
      color: #ff93937e;
    }

    img {
      width: 50px;
      height: 50px;
    }
  }
}

.desktop-area {
  width: 100%;
  height: 100%;
  // position: relative;/

  #remote-desktop {
    width: 100%;
    height: 100%;
    background-color: #303030;
  }
}

#local-video {
  width: 100%;
  height: 100%;
  background-color: #303030;
}

.close-btn {
  position: absolute;
  font-size: 12px;
  border-radius: 40px;
  cursor: pointer;
  padding: 10px 10px;
  background-color: #d54b44;
  color: #fff;
  transition: all 0.2s;
  top: 30vh;
  left: 90vw;
  text-align: center;
  z-index: 999;

  &:hover {
    color: #fd3737;
    background-color: #b32922;
  }

  img {
    width: 80px;
    height: 80px;
  }
}

.logger {
  width: 40%;
  padding: 14px;
  line-height: 1.5;
  color: #4fbf40;
  position: fixed;
  left: 50%;
  z-index: 90999;
  top: 50%;
  transform: translate(-50%, -50%);
  border-radius: 6px;
  background-color: #272727;
}

.logger .error {
  color: #dd4a68;
}
</style>
