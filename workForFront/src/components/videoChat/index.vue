<script setup>
defineOptions({
  name: "Home"
});
import { ElButton, ElDialog } from 'element-plus'
import { onMounted, computed, ref } from "vue";
import { useRouter } from "vue-router";
import {message} from 'ant-design-vue'
import nprogress from "nprogress";
import { useAppStore } from "@/store";
import { InformationTypes } from "@/omcs";
import RequestDialog2Active from "@/components/RequestDialog2Active.vue";
import RequestDialog2Passive from "@/components/RequestDialog2Passive.vue";
import Tabs from "@/components/Tabs.vue";
/**
 * ------------数据层------------
 */
// #region
// 全局共享数据
const app = useAppStore();
// 路由器isRequestDesktop
const router = useRouter();
// 当前登录用户信息
const H5MediaUser = ref(null);
// 对方的账号
const targetUsername = ref("");
// 摄像头 麦克风 阵列
let cameraArr = {};
let micArr = {};
// 视频连接器
let dynamicCameraConnector4Me = null;
let dynamicCameraConnector4Other = null;
// 桌面连接器
let dynamicDesktopConnector = null;
// 麦克风连接器
let microphoneConnector4Other = null;
// 控制主动请求视频弹框
const isActiveRequestVideo = ref(false);
// 控制被动请求视频弹框
const isPassiveRequestVideo = ref(false);
// 控制主动请求桌面弹框
const isActiveRequestDesktop = ref(false);
// 控制被动请求桌面弹框
const isPassiveRequestDesktop = ref(false);
// 正在视频的对方的账号
const videoingid = ref("");
// 看别人桌面，别人的id
const desktopActiveUsername = ref("");
// 被别人看，别人的id
const desktopPassiveUsername = ref("");
// 屏幕是否被别人监控
const isMonitored = ref(false);
const micBtnIndex = ref(1);
const speakerBtnIndex = ref(1);
const cameraBtnIndex = ref(1);
// 麦克风按钮数据
const micBtnData = [
  {
    img_url: new URL("../../assets/image/mic_closed.png", import.meta.url).href,
    text: "麦克风关闭"
  },
  {
    img_url: new URL("../../assets/image/mic_opened.png", import.meta.url).href,
    text: "麦克风开启"
  }
];
// 扬声器按钮数据
const speakerBtnData = [
  {
    img_url: new URL("../../assets/image/speaker_closed.png", import.meta.url).href,
    text: "扬声器关闭"
  },
  {
    img_url: new URL("../../assets/image/speaker_opened.png", import.meta.url).href,
    text: "扬声器开启"
  }
];
// 摄像头按钮数据
const cameraBtnData = [
  {
    img_url: new URL("../../assets/image/camera_closed.png", import.meta.url).href,
    text: "摄像头关闭"
  },
  {
    img_url: new URL("../../assets/image/camera_opened.png", import.meta.url).href,
    text: "摄像头开启"
  }
];


// 连接状态计算属性
const connectStr = computed(() => {
  return app.isServerConnect ? "已连接" : "断开，正在重连...";
});

const isVideoing = computed(() => {
  return videoingid.value !== "";
});

const remoteVideoHeight = computed(() => {
  return isVideoing.value ? "calc(100% - 120px)" : "100%";
});
// #endregion

/**
 * ------------生命周期层------------
 */
// #region
// 是否登录
onMounted(() => {
  const H5MediaUserStr = localStorage.getItem("H5MediaUser");
  if (H5MediaUserStr) {
    H5MediaUser.value = JSON.parse(H5MediaUserStr);
    // debugger;
    if (H5MediaUser.value.action === "login") {
      localStorage.setItem("H5MediaUser", JSON.stringify(Object.assign(H5MediaUser.value, { action: "logined" })));
      return;
    }
    const { username, password, serverIP } = H5MediaUser.value;
    // 重新初始化多媒体管理器及登录
    nprogress.start();
    app.initMultimediaManager();
    app.multimediaManager.Initialize(
      username,
      password,
      serverIP,
      9900,
      {
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
          message.success("登录成功!");
          // 更新与服务器连接状态
          app.updateServerConnect(true);
        } else {
          message.error("登录失败!");
          router.replace("/login");
        }
      }
    );
  } else {
    message.warning("登录状态丢失，请重新登录!");
    router.replace("/login");
  }
});
// 初始化自定义消息处理
onMounted(() => {
  if (app) {
    app.setCustomMessageReceivedCallback(messageHandler);
  }
});
// 测试
onMounted(() => {
  const remoteVideoEl = document.querySelector("#remote-video");
  remoteVideoEl.addEventListener("resize", (event) => {
    console.log("###remoteVideoEl resize###", remoteVideoEl.videoWidth, remoteVideoEl.videoHeight);
  });
});
// #endregion
/**
 * ------------事件处理层------------
 */
// #region
// 退出登录事件处理
const exitBtnHandler = () => {
  app.multimediaManager.Dispose();
  localStorage.removeItem("H5MediaUser");
  router.replace("/login");
};
// 请求远程视频会话
const requestVideoBtnHandler = async () => {
  const multimediaManager = app.multimediaManager;
  if (targetUsername.value === "") {
    return message.error("请输入对方的账号!");
  }
  if (!(await multimediaManager.IsUserOnline(targetUsername.value))) {
    return message.warning(`用户${targetUsername.value}不在线!`);
  }
  multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.VideoRequest, null, null);
  isActiveRequestVideo.value = true;
  connectVideoSelf();
};
// 取消请求远程视频会话
const cancelRequestVideoHandler = () => {
  const multimediaManager = app.multimediaManager;
  dynamicCameraConnector4Me.Disconnect();
  multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.CancelVideo, null, null);
  isActiveRequestVideo.value = false;
};
// 请求远程桌面会话
const requestDesktopBtnHandler = async () => {
  const multimediaManager = app.multimediaManager;
  if (targetUsername.value === "") {
    return message.error("请输入对方的账号!");
  }
  if (!(await multimediaManager.IsUserOnline(targetUsername.value))) {
    return message.warning(`用户${targetUsername.value}不在线!`);
  }
  isActiveRequestDesktop.value = true;
  multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.DesktopRequest, null, null);
};
// 取消请求远程桌面会话
const cancelRequestDesktopHandler = () => {
  const multimediaManager = app.multimediaManager;
  multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.CancelDesktop, null, null);
  isActiveRequestDesktop.value = false;
};
// 处理收到来自服务端或其他客户端的消息
const messageHandler = (data) => {
  if (data.MsgType == InformationTypes.VideoRequest) {
    // 2023-08-28
    const multimediaManager = app.multimediaManager;
    if (videoingid.value) {
      multimediaManager.sendCustomMessage(data.TargetUserID, InformationTypes.BusyLine, null, null);
      return;
    }
    // 来者何人，报上名来
    targetUsername.value = data.TargetUserID;
    // 视频请求弹框
    isPassiveRequestVideo.value = true;
  } else if (data.MsgType == InformationTypes.VideoResult) {
    // debugger
    if (data.Msg[0] == 1) {
      // setTimeout(() => {
      connectVideo(data.TargetUserID);
      videoingid.value = data.TargetUserID;
      // }, 500);
    } else {
      closeVideo(true);
      message.info(`${data.TargetUserID}拒绝视频通话!`);
    }
  } else if (data.MsgType == InformationTypes.CloseVideo) {
    closeVideo(true);
    message.info(`${data.TargetUserID}挂断视频通话!`);
  } else if (data.MsgType == InformationTypes.NetReasonCloseVideo) {
    closeVideo(true);
    message.info(`${data.TargetUserID}网络原因导致视频中断`);
  } else if (data.MsgType == InformationTypes.BusyLine) {
    closeVideo(true);
    message.info(`${data.TargetUserID}忙线中`);
  } else if (data.MsgType == InformationTypes.DesktopRequest) {
    const multimediaManager = app.multimediaManager;
    if (desktopPassiveUsername.value) {
      multimediaManager.sendCustomMessage(data.TargetUserID, InformationTypes.BusyLine, null, null);
      return;
    }
    targetUsername.value = data.TargetUserID;
    // 显示弹框组件
    isPassiveRequestDesktop.value = true;
    desktopPassiveUsername.value = data.TargetUserID;
  } else if (data.MsgType == InformationTypes.DesktopResult) {
    // this.$refs.popup.close();
    isActiveRequestDesktop.value = false;
    if (data.Msg[0] == 1) {
      connectDesktop(targetUsername.value);
      desktopActiveUsername.value = targetUsername.value;
    } else {
      message.info(`${targetUsername.value}拒绝您控制其电脑`);
    }
  } else if (data.MsgType == InformationTypes.CancelDesktop) {
    isPassiveRequestDesktop.value = false;
    desktopPassiveUsername.value = "";
    message.info(`${data.TargetUserID}取消了远程桌面请求`);
  } else if (data.MsgType == InformationTypes.CancelVideo) {
    isPassiveRequestVideo.value = false;
    videoingid.value = "";
    message.info(`${data.TargetUserID}取消了视频会话请求`);
  } else if (data.MsgType == InformationTypes.OwnerCloseDesktop) {
    message.info(`${desktopActiveUsername.value}关闭了屏幕分享`);
    closeDesktop(true);
  } else if (data.MsgType == InformationTypes.GuestCloseDesktop) {
    isMonitored.value = false;
    desktopPassiveUsername.value = "";
  }
};
// 连接其他人的视频成功
const connectOtherVideoHandler = (ownerID, baseResult) => {
  console.log("连接其他人的摄像头", ownerID, baseResult);
  if (baseResult.ResultCode === 0) {
    isActiveRequestVideo.value = false;
  }
};
// 断开桌面分享
const disconnectBtnHandler = () => {
  const multimediaManager = app.multimediaManager;
  multimediaManager.sendCustomMessage(desktopPassiveUsername.value, InformationTypes.OwnerCloseDesktop, null, null);
  isMonitored.value = false;
  desktopPassiveUsername.value = "";
};
// 麦克风按钮点击事件处理函数
const micBtnHandler = () => {
  const multimediaManager = app.multimediaManager;
  if (micBtnIndex.value === 0) {
    micBtnIndex.value = 1;
    multimediaManager.SetOutputAudio(true);
  } else {
    micBtnIndex.value = 0;
    multimediaManager.SetOutputAudio(false);
  }
};
// 扬声器按钮点击事件处理函数
const speakerBtnHandler = () => {
  if (speakerBtnIndex.value === 0) {
    speakerBtnIndex.value = 1;
    microphoneConnector4Other.SetMute(false);
  } else {
    speakerBtnIndex.value = 0;
    microphoneConnector4Other.SetMute(true);
  }
};
// 摄像头按钮点击事件处理函数
const cameraBtnHandler = () => {
  const multimediaManager = app.multimediaManager;
  if (cameraBtnIndex.value === 0) {
    cameraBtnIndex.value = 1;
    multimediaManager.SetOutputVideo(true);
  } else {
    cameraBtnIndex.value = 0;
    multimediaManager.SetOutputVideo(false);
  }
};

// #endregion

/**
 * ------------逻辑复用层------------
 */

// #region
// 连接自己的视频
const connectVideoSelf = () => {
  // debugger;
  const myUsername = H5MediaUser.value.username;
  const haveCon = Object.keys(cameraArr).includes(myUsername) ? 1 : 0;
  if (haveCon === 0) {
    dynamicCameraConnector4Me = new DynamicCameraConnector();
  } else {
    dynamicCameraConnector4Me = cameraArr[myUsername];
  }
  dynamicCameraConnector4Me.SetViewer(document.querySelector("#local-video"));
  dynamicCameraConnector4Me.BeginConnect(myUsername);
  cameraArr[myUsername] = dynamicCameraConnector4Me;
};
// 连接别人的视频
const connectVideo = (destID) => {
  // debugger;
  const disconnected = createDisconnected();
  let haveCon = Object.keys(cameraArr).includes(destID) ? 1 : 0;
  if (haveCon === 0) {
    dynamicCameraConnector4Other = new DynamicCameraConnector();
    dynamicCameraConnector4Other.OwnerOutputChanged = function (ownerID, flag) {
      console.log(`ownerID: ${ownerID}; is video output?: ${flag}`);
    };
  } else {
    dynamicCameraConnector4Other = cameraArr[destID];
  }
  dynamicCameraConnector4Other.ConnectEnded = connectOtherVideoHandler;
  dynamicCameraConnector4Other.Disconnected = disconnected;
  dynamicCameraConnector4Other.SetViewer(document.querySelector("#remote-video"));
  dynamicCameraConnector4Other.BeginConnect(destID);
  cameraArr[destID] = dynamicCameraConnector4Other;
  let haveMic = Object.keys(micArr).includes(destID) ? 1 : 0;
  if (haveMic === 0) {
    microphoneConnector4Other = new MicrophoneConnector();
    microphoneConnector4Other.OwnerOutputChanged = function (ownerID, flag) {
      console.log(`ownerID: ${ownerID}; is video output?: ${flag}`);
    };
  } else {
    microphoneConnector4Other = micArr[destID];
  }
  microphoneConnector4Other.Disconnected = disconnected;
  microphoneConnector4Other.SetViewer(document.querySelector("#remote-video"));
  microphoneConnector4Other.BeginConnect(destID);
  micArr[destID] = microphoneConnector4Other;
};
// owner（设备）掉线
const createDisconnected = () => {
  let count = 0;
  return (ownerID, ConnectorDisconnectedType) => {
    console.log("owner（设备）掉线", ConnectorDisconnectedType);
    if (count++ > 0) return;
    if (ConnectorDisconnectedType === 1) {
      closeVideo(true);
      message.info(`${ownerID}掉线了，视频会话结束`);
    } else if (ConnectorDisconnectedType === 2) {
      closeVideo(true);
      // message.info("视频会话结束");
    }
  };
};
/**
 * 响应视频请求：true-同意 false-拒绝
 * @param {boolean} flag
 */
const videoResult = (flag) => {
  const multimediaManager = app.multimediaManager;
  multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.VideoResult, [flag ? 1 : 0], "");
  if (flag) {
    isPassiveRequestVideo.value = false;
    connectVideoSelf();
    connectVideo(targetUsername.value);
    videoingid.value = targetUsername.value;
  } else {
    closeVideo(false);
    message.info(`您已拒绝${targetUsername.value}对方视频通话请求`);
  }
};
// 挂断视频会话
const closeVideo = (flag) => {
  isPassiveRequestVideo.value = false;
  isActiveRequestVideo.value = false;
  for (let key in cameraArr) {
    cameraArr[key].Disconnect();
    delete cameraArr[key];
  }
  for (let key in micArr) {
    micArr[key].Disconnect();
    delete micArr[key];
  }
  if (!flag) {
    const multimediaManager = app.multimediaManager;
    if (videoingid.value === "") {
      multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.CloseVideo, null, null);
    } else {
      multimediaManager.sendCustomMessage(videoingid.value, InformationTypes.CloseVideo, null, null);
    }
    console.log("您中止了语音视频通话");
  }
  videoingid.value = "";
};
/**
 * 响应桌面请求：true-同意 false-拒绝
 */
const desktopResult = (flag) => {
  const multimediaManager = app.multimediaManager;
  multimediaManager.sendCustomMessage(desktopPassiveUsername.value, InformationTypes.DesktopResult, [flag ? 1 : 0], "");
  isPassiveRequestDesktop.value = false;
  if (flag) {
    isMonitored.value = true;
  } else {
    desktopPassiveUsername.value = "";
  }
};
// 连接远程桌面
const connectDesktop = (targetUserID) => {
  dynamicDesktopConnector = new DynamicDesktopConnector();
  dynamicDesktopConnector.OwnerOutputChanged = function (ownerID, flag) {
    console.log(`ownerID: ${ownerID}; is video output?: ${flag}`);
  };
  dynamicDesktopConnector.SetWatchingOnly(false);
  dynamicDesktopConnector.SetShowMouseCursor(true);
  dynamicDesktopConnector.ConnectEnded = (ownerID, res) => {
    if (res.ResultCode === 3) {
      message.info(`${ownerID}为移动端设备，不支持远程桌面`);
      const multimediaManager = app.multimediaManager;
      multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.GuestCloseDesktop, null, null);
      closeDesktop(true);
    }
  };
  dynamicDesktopConnector.SetViewer(document.querySelector("#remote-desktop"));
  dynamicDesktopConnector.BeginConnect(targetUserID);
};
// 关闭远程桌面
const closeDesktop = (flag) => {
  const multimediaManager = app.multimediaManager;
  // this.screenShareStatus = false;
  if (dynamicDesktopConnector != undefined) {
    dynamicDesktopConnector.Disconnect();
  }
  if (!flag) {
    multimediaManager.sendCustomMessage(desktopActiveUsername.value, InformationTypes.GuestCloseDesktop, null, null);
  }
  desktopActiveUsername.value = "";
};
// #endregion
</script>

<template>
  <div class="home">
    <div class="header">
      <div class="monitored" v-if="isMonitored">
        <span class="username">{{ desktopPassiveUsername }}</span>
        <span>正在观看你的屏幕</span>
        <span class="stop-btn" @click="disconnectBtnHandler">断开连接</span>
      </div>
    </div>
    <div class="main">
      <div class="aside">
        <h4>会话账号及类型选择</h4>
        <div class="target">
          <el-button
            style="font-size: 18px"
            size="large"
            type="primary"
            plain
            :disabled="videoingid !== ''"
            @click="requestVideoBtnHandler"
            >请求视频会话</el-button
          >
          <el-button
            style="margin-left: 0; font-size: 18px"
            size="large"
            type="success"
            plain
            :disabled="desktopActiveUsername !== ''"
            @click="requestDesktopBtnHandler"
            >请求远程桌面</el-button
          >
        </div>
        <h4>本地摄像头区域</h4>
        <div class="local-video">
          <video id="local-video" autoplay></video>
        </div>
        <h4 class="tip">对方摄像头区域 ——→</h4>
      </div>
      <div class="remote-video">
        <Tabs :videoingid="videoingid" :desktopingid="desktopActiveUsername">
          <template #video>
            <div class="video-area">
              <video id="remote-video" autoplay></video>
              <div class="video-btns" v-show="videoingid !== ''">
                <div class="mic-btn" @click="micBtnHandler">
                  <img :src="micBtnData[micBtnIndex].img_url" />
                  <span>{{ micBtnData[micBtnIndex].text }}</span>
                </div>
                <div class="speaker-btn" @click="speakerBtnHandler">
                  <img :src="speakerBtnData[speakerBtnIndex].img_url" />
                  <span>{{ speakerBtnData[speakerBtnIndex].text }}</span>
                </div>
                <div class="camera-btn" @click="cameraBtnHandler">
                  <img :src="cameraBtnData[cameraBtnIndex].img_url" />
                  <span>{{ cameraBtnData[cameraBtnIndex].text }}</span>
                </div>
                <div class="close-btn" @click="() => closeVideo(false)">
                  <img src="@/assets/image/group_handsup.png" />
                  <span>结束视频会话</span>
                </div>
              </div>
            </div>
          </template>
          <template #desktop>
            <div class="desktop-area">
              <div class="desktop-btns">
                <div class="close-btn" v-show="desktopActiveUsername !== ''" @click="() => closeDesktop(false)">
                  结束桌面会话
                </div>
              </div>
              <video id="remote-desktop" autoplay></video>
            </div>
          </template>
        </Tabs>
      </div>
    </div>

    <!-- 发起视频请求对话框 -->
    <RequestDialog2Active :isShow="isActiveRequestVideo" type="video" @close="cancelRequestVideoHandler" />
    <!-- 接受视频请求对话框 -->
    <RequestDialog2Passive
      :isShow="isPassiveRequestVideo"
      :username="targetUsername"
      type="video"
      @video-resolve="() => videoResult(true)"
      @video-reject="() => closeVideo(false)"
    />

    <!-- 发起桌面请求对话框 -->
    <RequestDialog2Active :isShow="isActiveRequestDesktop" type="desktop" @close="cancelRequestDesktopHandler" />
    <!-- 接受桌面请求对话框 -->
    <RequestDialog2Passive
      :isShow="isPassiveRequestDesktop"
      :username="targetUsername"
      type="desktop"
      @desktop-resolve="() => desktopResult(true)"
      @desktop-reject="() => desktopResult(false)"
    />
  </div>
</template>

<style lang="less" scoped>
.header {
  position: relative;
  height: 80px;
  color: #fff;
  display: flex;
  align-items: center;
  box-sizing: border-box;
  padding: 0 60px;

  .title {
    font-size: 36px;
  }

  .monitored {
    position: absolute;
    padding: 16px 20px;
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

    .stop-btn {
      margin-left: 20px;
      padding: 8px 16px;
      border-radius: 2px;
      background-color: #0a7dd6;
      color: #fff;
      cursor: pointer;
      // transition: filter 0.2s;
    }
    .stop-btn:hover {
      filter: brightness(1.1);
    }
  }
}

.main {
  height: calc(100vh - 80px);
  background-color: #f2f2f2;
  display: flex;

  video {
    width: 100%;
    height: 100%;
  }
  .aside {
    width: 640px;
    background-color: #f5f5dc;
    box-sizing: border-box;
    padding: 20px;
    font-size: 24px;
    .userinfo {
      display: flex;
      gap: 20px;

      .msg {
        box-sizing: border-box;
        padding: 10px;
        p {
          margin-bottom: 20px;
        }
      }

      img {
        width: 200px;
        height: 200px;
        box-sizing: border-box;
        border: 1px solid #666;
      }
    }

    h4 {
      font-size: 22px;
      margin: 30px 0 15px;
    }

    .target {
      display: flex;
      gap: 5px;
    }

    .local-video {
      height: 340px;
      background-color: #000;
    }

    .tip {
      margin-top: 50px;
      text-align: right;
    }
  }

  .remote-video {
    flex: 1;
    // position: relative;
    // background-color: #000;
    .video-area {
      width: 100%;
      height: 100%;
      // position: relative;
      // display: flex;
      flex-direction: column;

      #remote-video {
        // height: calc(100% - 120px);
        height: v-bind(remoteVideoHeight);
        background-color: #303030;
      }

      .video-btns {
        flex-shrink: 0;
        height: 120px;
        display: flex;
        gap: 20px;
        position: relative;
        // background-color: #fff;

        > div {
          font-size: 18px;
          cursor: pointer;
          padding: 8px 20px;
          color: #fff;
          transition: all 0.2s;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          gap: 10px;
          background-color: #41555d;

          &:hover {
            background-color: #20333b;
          }

          img {
            width: 70px;
            height: 70px;
          }
        }
        // .mic-btn {
        //   background-color: #0c8918;

        //   &:hover {
        //     background-color: #0a6706;
        //   }
        // }
        // .speaker-btn {
        //   background-color: #ff8936;

        //   &:hover {
        //     background-color: #dd6714;
        //   }
        // }
        // .camera-btn {
        //   background-color: #2e4e7e;

        //   &:hover {
        //     background-color: #0c2c5c;
        //   }
        // }

        .close-btn {
          position: absolute;
          right: 0;
        }
      }
    }

    .desktop-area {
      width: 100%;
      height: 100%;
      position: relative;
      .desktop-btns {
        position: absolute;
        z-index: 999;
        right: 0;
        top: 0;

        .close-btn {
          font-size: 18px;
          cursor: pointer;
          padding: 8px 20px;
          background-color: #d54b44;
          color: #fff;
          transition: all 0.2s;
        }
        .close-btn:hover {
          background-color: #b32922;
        }
      }
      #remote-desktop {
        width: 100%;
        height: 100%;
        background-color: #303030;
      }
    }
  }
}
</style>
