<script setup>
const target = route.query.type;
const logText = ref("");
let localVideo;
let remoteVideo;
const startbutton = ref(null);
const logshow=ref(false)
const targetUsername="测试"
const videoMode=ref(false)
const isActiveRequestVideo=ref(false)
const isActiveRequestDesktop=ref(false)
const isReady=ref(false)
const testServer = "ws://localhost:9900";
const logger = {
    log(msg) {
        logText.value += `<span>${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
    },
    error(msg) {
        logText.value += `<span class="error">${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
    },
};
async function startLive(offerSdp) {
    let stream;
    try {
        logger.log("尝试调取本地摄像头/麦克风");
        stream = await navigator.mediaDevices.getUserMedia({
            video: true,
            // audio: true,
        });
        logger.log("摄像头/麦克风获取成功！");
        localVideo.srcObject = stream;
    } catch(e) {
        console.log(e);
        message.info("摄像头/麦克风获取失败！")
        logger.error("摄像头/麦克风获取失败！");
        return;
    }

    logger.log(
        `------ WebRTC ${target === "offer" ? "发起方" : "接收方"}流程开始 ------`
    );
    logger.log("将媒体轨道添加到轨道集");
    stream.getTracks().forEach((track) => {
        peer.addTrack(track, stream);
    });

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
}
async function startLiveDesktop(offerSdp) {
    let stream;
    try {
        logger.log("尝试调取屏幕");
        stream = await navigator.mediaDevices.getDisplayMedia({
            video: true,
            // audio: true,
        });
        logger.log("屏幕获取成功");
        localVideo.srcObject = stream;
    } catch(e) {
        console.log(e);
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
}
onMounted(() => {
    localVideo = document.querySelector("#local-video");
    remoteVideo = document.querySelector("#remote-video");
    localVideo.onloadeddata = () => {
        logger.log("播放本地视频");
        localVideo.play();
    };

    remoteVideo.onloadeddata = () => {
        logger.log("播放对方视频");
        remoteVideo.play();
    };
});
logger.log("信令通道（WebSocket）创建中......");
const socket = new WebSocket(testServer);
socket.onopen = () => {
    logger.log("信令通道创建成功！");
};
socket.onerror = () => logger.error("信令通道创建失败！");
socket.onmessage = (e) => {
    const {
        type,
        sdp,
        iceCandidate
    } = JSON.parse(e.data);
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
        startLive(
            new RTCSessionDescription({
                type,
                sdp,
            })
        );
    } else if (type === "offer_ice") {
        peer.addIceCandidate(iceCandidate);
    }
};
const PeerConnection =
    window.RTCPeerConnection ||
    window.mozRTCPeerConnection ||
    window.webkitRTCPeerConnection;
!PeerConnection && logger.error("浏览器不支持WebRTC！");
const peer = new PeerConnection();
peer.ontrack = (e) => {
    if (e && e.streams) {
        logger.log("收到对方音频/视频流数据...");
        remoteVideo.srcObject = e.streams[0];
    }
};

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
const showLog=()=>{
    // message.info("222")
    logshow.value=!logshow.value
}
</script>
<template>
<div class="logger" v-if="logshow">
    <div v-html="logText"></div>
  </div>
<!-- </div> -->
<a-layout class="container">
    <a-layout-header class="header">
        <!-- <div class="monitored" v-if="isMonitored">
            <span class="username">{{ desktopPassiveUsername }}</span>
            <span>正在观看你的屏幕</span>
            <a-button @click="disconnectBtnHandler">断开连接</a-button>
        </div> -->
        <div class="box" @click=showLog()>
            <!-- <img src="/FeHeart.svg" alt="no"> -->
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
                        <a-button style="margin-top: 10px" ghost type="primary" @click="startLive()">申请视频聊天</a-button>
                    </div>
                    <div v-else>
                        <a-button style="margin-top: 10px" ghost type="primary" disabled>视频聊天已开启</a-button>
                    </div>
                    <!-- <a-button danger>Danger Default</a-button> -->
                </div>
                <div style="text-align: center">
                    <div v-if="!isActiveRequestDesktop">
                        <a-button style="margin-top: 10px" ghost type="primary" @click="startLiveDesktop()">申请分享屏幕</a-button>
                    </div>
                    <div v-else>
                        <a-button style="margin-top: 10px" ghost type="primary" disabled>屏幕分享已开启</a-button>
                    </div>
                    <!-- <a-button type="primary">Primary Button</a-button>
                          <a-button danger>Danger Default</a-button> -->
                </div>
                <div style="text-align: center">
                    <div v-if="!videoMode">
                        <a-button disabled style="margin-top: 10px" ghost type="primary">当前显示视频聊天</a-button>
                    </div>
                    <div v-else>
                        <a-button disabled style="margin-top: 10px" ghost type="primary">当前显示屏幕分享</a-button>
                    </div>
                    <a-button style="margin-top: 10px" ghost @click="
                    () => {
                    videoMode = !videoMode;
                    }
              ">切换显示</a-button>
                </div>
   
            </div>
        </a-layout-sider>

        <a-layout-content class="content">
            <div class="content-header">
                <p class="title">面试摄像头</p>
            </div>
            <!-- v-show="!videoMode" -->
            <div class="video-chat">
                <div v-show="!videoMode" class="video-area" style="background-color: aliceblue">
                <video id="remote-video" autoplay></video>
                    <!-- v-show="videoingid !== ''" -->
                    <div class="close-btn" v-show="isActiveRequestVideo !== ''" @click="() => closeVideo(false)">
                        <!-- <img src="@/assets/image/group_handsup.png" /> -->
                        <br />
                        <p>结束视频会话</p>
                    </div>
                </div>
                <div v-show="videoMode" class="desktop-area" style="background-color: aqua">
                    <video id="remote-desktop" autoplay></video>
                    <!-- v-show="desktopActiveUsername !== ''"  -->
                    <div class="close-btn" v-show="isActiveRequestDesktop !== ''" @click="() => closeDesktop(false)">
                        <!-- <img src="@/assets/image/group_handsup.png" /> -->
                        <br />
                        <p>结束桌面会话</p>
                    </div>
                </div>
            </div>
        </a-layout-content>
    </a-layout>
    <a-layout-footer class="footer"></a-layout-footer>
</a-layout>