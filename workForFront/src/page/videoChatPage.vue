
<script setup>
import { ref, reactive, computed, onBeforeMount, shallowReactive, onUnmounted } from 'vue'
import { message } from 'ant-design-vue'
import { useRouter } from "vue-router";
import nprogress from "nprogress";
import "nprogress/nprogress.css";
import { useVideoChatStore } from "../store/index";
import { InformationTypes } from "@/omcs";
import RequestDialog2Active from "@/components/videoChat/RequestDialog2Active.vue";
import RequestDialog2Passive from "@/components/videoChat/RequestDialog2Passive.vue";
import axios from '../plugins/axiosBase';


// import '/public/H5Media.iife.lock'
// Object.keys(H5Media).forEach((key) => {
//         if (key !== "default") {
//           window[key] = H5Media[key];
//         }
//       });
// import Tabs from "@/components/videoChat/Tabs.vue";
let videoChatTo = ref()
const videoMode = ref(false)
const isReady = ref(false)
const isVideoChat = ref(false)
const isVideoScreen = ref(false)
const videoChat = useVideoChatStore()
const formData = shallowReactive({
    username: "",
    password: "",
    serverIP: ""
});

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
        img_url: new URL("../assets/image/mic_closed.png", import.meta.url).href,
        text: "麦克风关闭"
    },
    {
        img_url: new URL("../assets/image/mic_opened.png", import.meta.url).href,
        text: "麦克风开启"
    }
];
// 扬声器按钮数据
const speakerBtnData = [
    {
        img_url: new URL("../assets/image/speaker_closed.png", import.meta.url).href,
        text: "扬声器关闭"
    },
    {
        img_url: new URL("../assets/image/speaker_opened.png", import.meta.url).href,
        text: "扬声器开启"
    }
];
// 摄像头按钮数据
const cameraBtnData = [
    {
        img_url: new URL("../assets/image/camera_closed.png", import.meta.url).href,
        text: "摄像头关闭"
    },
    {
        img_url: new URL("../assets/image/camera_opened.png", import.meta.url).href,
        text: "摄像头开启"
    }
];
const userId = ref("")
const userStatus = ref("加载中")

async function getId() {
    try {
        userId.value = JSON.parse(localStorage.getItem("userId") ?? 'undefined')
    } catch (error) {
        console.error('Error:', error);
    }


}
// 基本信息
const FromUserHandler = () => {
    formData.username = userId.value;
    formData.password = "1";
    formData.serverIP = "h5rtc.oraycn.com";
    // formData.serverIP = "192.168.0.234";
};
// p2p服务器
const videoChatStart = () => {
    if (formData.username == 'undefined' || formData.username == '未登录') {
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
                // message.success("上线成功");
                userStatus.value = "在线中"
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
// 连接状态计算属性
const connectStr = computed(() => {
    return videoChat.isServerConnect ? "已连接" : "断开，正在重连...";
});

const isVideoing = computed(() => {
    return videoingid.value !== "";
});

const remoteVideoHeight = computed(() => {
    return isVideoing.value = "100%";
});

const requestVideoBtnHandler = async () => {
    const multimediaManager = videoChat.multimediaManager;
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
    const multimediaManager = videoChat.multimediaManager;
    dynamicCameraConnector4Me.Disconnect();
    multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.CancelVideo, null, null);
    isActiveRequestVideo.value = false;
};
// 请求远程桌面会话
const requestDesktopBtnHandler = async () => {
    const multimediaManager = videoChat.multimediaManager;
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
    const multimediaManager = videoChat.multimediaManager;
    multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.CancelDesktop, null, null);
    isActiveRequestDesktop.value = false;
};
// 处理收到来自服务端或其他客户端的消息
const messageHandler = (data) => {
    if (data.MsgType == InformationTypes.VideoRequest) {
        // 2023-08-28
        const multimediaManager = videoChat.multimediaManager;
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
        const multimediaManager = videoChat.multimediaManager;
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
    const multimediaManager = videoChat.multimediaManager;
    multimediaManager.sendCustomMessage(desktopPassiveUsername.value, InformationTypes.OwnerCloseDesktop, null, null);
    isMonitored.value = false;
    desktopPassiveUsername.value = "";
};
// 麦克风按钮点击事件处理函数
const micBtnHandler = () => {
    const multimediaManager = videoChat.multimediaManager;
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
    const multimediaManager = videoChat.multimediaManager;
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
    const myUsername = userId.value;
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
    const multimediaManager = videoChat.multimediaManager;
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
        const multimediaManager = videoChat.multimediaManager;
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
    const multimediaManager = videoChat.multimediaManager;
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
        console.log(` ${ownerID}; 输出?: ${flag}`);
    };
    dynamicDesktopConnector.SetWatchingOnly(false);
    dynamicDesktopConnector.SetShowMouseCursor(true);
    dynamicDesktopConnector.ConnectEnded = (ownerID, res) => {
        if (res.ResultCode === 3) {
            message.info(`${ownerID}为移动端设备，不支持远程桌面`);
            const multimediaManager = videoChat.multimediaManager;
            multimediaManager.sendCustomMessage(targetUsername.value, InformationTypes.GuestCloseDesktop, null, null);
            closeDesktop(true);
        }
    };
    dynamicDesktopConnector.SetViewer(document.querySelector("#remote-desktop"));
    dynamicDesktopConnector.BeginConnect(targetUserID);
};
// 关闭远程桌面
const closeDesktop = (flag) => {
    const multimediaManager = videoChat.multimediaManager;
    // this.screenShareStatus = false;
    if (dynamicDesktopConnector != undefined) {
        dynamicDesktopConnector.Disconnect();
    }
    if (!flag) {
        multimediaManager.sendCustomMessage(desktopActiveUsername.value, InformationTypes.GuestCloseDesktop, null, null);
    }
    desktopActiveUsername.value = "";
};
onBeforeMount(() => {

    getId()
    if (sessionStorage.getItem("videoChat")) {
        videoChatTo.value = JSON.parse(sessionStorage.getItem("videoChat") ?? "")
        isReady.value = true
        targetUsername.value = videoChatTo.value.label
        console.log(targetUsername.value);
    }
    videoChat.initMultimediaManager();
    FromUserHandler()
    // IM 连接服务器
    videoChatStart()
    if (videoChat) {
        videoChat.setCustomMessageReceivedCallback(messageHandler)
    }
    // console.log(userId.value)
    axios.post("videoChatOver").then(
        (res)=>{
            if(res.code==200){
                // message.info("退出面试")
            }
        }
    )

})

onUnmounted(() => {
    videoChat.multimediaManager.Dispose()
    // axios.post("videoChatOver").then(
    //     (res)=>{
    //         if(res.code==200){
    //             message.info("退出面试")
    //         }
    //     }
    // )
    // TODO 发送请求
})
</script>

<template>
    <a-layout class="container">
        <a-layout-header class="header">
            <div class="monitored"  v-if="isMonitored">
                <span class="username">{{ desktopPassiveUsername }}</span>
                <span>正在观看你的屏幕</span>
                <a-button @click="disconnectBtnHandler">断开连接</a-button>
            </div>
            <div class="box">
                <!-- <img src="/FeHeart.svg" alt="no"> -->
                <h1>{{ connectStr }}</h1>
            </div>
        </a-layout-header>
        <a-layout class="header" >
            <a-layout-sider :width="'40vw'" class="sider">
                <h1 class="title">我的摄像头</h1>
                <div class="my-video" style="overflow: hidden;">
                    <video id="local-video" autoplay></video>
                </div>
                <div class="video-to" style="overflow: hidden;">
                    <div v-if="!isReady">
                        <h2 class="title" style="padding-top: 10px;">交流对象：{{ targetUsername }}</h2>
                    </div>
                    <div v-else>
                        <h2 class="title" style="padding-top: 10px;">交流对象：{{ targetUsername }}</h2>
                    </div>

                    <div style="text-align: center;">
                        <div v-if="!isActiveRequestVideo">
                            <a-button style="margin-top: 10px;" ghost type="primary"
                                @click="requestVideoBtnHandler">申请视频聊天</a-button>
                        </div>
                        <div v-else>
                            <a-button style="margin-top: 10px;" ghost type="primary" disabled>视频聊天已开启</a-button>
                        </div>
                        <!-- <a-button danger>Danger Default</a-button> -->

                    </div>
                    <div style="text-align: center;">
                        <div v-if="!isActiveRequestDesktop">
                            <a-button style="margin-top: 10px;" ghost type="primary"
                                @click="requestDesktopBtnHandler">申请分享屏幕</a-button>
                        </div>
                        <div v-else>
                            <a-button style="margin-top: 10px;" ghost type="primary" disabled>屏幕分享已开启</a-button>
                        </div>
                        <!-- <a-button type="primary">Primary Button</a-button>
                        <a-button danger>Danger Default</a-button> -->

                    </div>
                    <div style="text-align: center;">
                        <div v-if="!videoMode">
                            <a-button disabled style="margin-top: 10px;" ghost type="primary">当前显示视频聊天</a-button>
                        </div>
                        <div v-else>
                            <a-button disabled style=" margin-top: 10px;" ghost type="primary">当前显示屏幕分享</a-button>
                        </div>
                        <a-button style="margin-top: 10px;" ghost
                            @click="() => { videoMode = !videoMode }">切换显示</a-button>
                    </div>
                    <!-- <div v-if="isActiveRequestVideo&&videoMode"> -->
                    <div v-if="!videoMode&&videoingid !== ''">
                        <div class="video-btns">
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
                            <!-- <div class="close-btn" @click="() => closeVideo(false)">
                                <img src="@/assets/image/group_handsup.png" />
                                <span>结束视频会话</span>
                            </div> -->
                        </div>
                    </div>
                </div>

            </a-layout-sider>

            <a-layout-content class="content">
                <div class="content-header">
                    <p class="title">面试摄像头</p>
                </div>
                <!-- v-show="!videoMode" -->
                <div class="video-chat">
                    <div v-show="!videoMode"   class="video-area" style="background-color: aliceblue;">
                        <video id="remote-video" autoplay></video>
                        <!-- v-show="videoingid !== ''" -->
                        <div class="close-btn" v-show="videoingid !== ''"  @click="() => closeVideo(false)">
                            <img src="@/assets/image/group_handsup.png" />
                            <br>
                            <p>结束视频会话</p>
                        </div>
                    </div>
                    <div v-show="videoMode" class="desktop-area" style="background-color: aqua;">
                        <video id="remote-desktop" autoplay></video>
                        <!-- v-show="desktopActiveUsername !== ''"  -->
                        <div class="close-btn" v-show="desktopActiveUsername !== ''" @click="() => closeDesktop(false)">
                            <img src="@/assets/image/group_handsup.png" />
                            <br>
                            <p>结束桌面会话</p>
                        </div>
                    </div>
                </div>
            </a-layout-content>
        </a-layout>
        <a-layout-footer class="footer"></a-layout-footer>
    </a-layout>
    <!-- 发起视频请求对话框 -->
    <RequestDialog2Active :isShow="isActiveRequestVideo" type="video" @close="cancelRequestVideoHandler" />
    <!-- 接受视频请求对话框 -->
    <RequestDialog2Passive :isShow="isPassiveRequestVideo" :username="targetUsername" type="video"
        @video-resolve="() => videoResult(true)" @video-reject="() => closeVideo(false)" />

    <!-- 发起桌面请求对话框 -->
    <RequestDialog2Active :isShow="isActiveRequestDesktop" type="desktop" @close="cancelRequestDesktopHandler" />
    <!-- 接受桌面请求对话框 -->
    <RequestDialog2Passive :isShow="isPassiveRequestDesktop" :username="targetUsername" type="desktop"
        @desktop-resolve="() => desktopResult(true)" @desktop-reject="() => desktopResult(false)" />
</template>

<style scoped lang='scss'>

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
        height: v-bind(remoteVideoHeight);
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

    >div {
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
#local-video{
    width: 100%;
    height: 100%;
    background-color: #303030;
}
.close-btn {
    position: absolute;
    font-size: 12px;
    cursor: pointer;
    padding: 8px 20px;
    // background-color: #d54b44;
    color: #fff;
    transition: all 0.2s;
    top: 30vh;
    left: 90vw;
    text-align: center;
    z-index: 999;

    &:hover {
        color: #fd3737;
        // background-color: #b32922;
    }

    img {
        width: 80px;
        height: 80px;
    }
}
</style>