
  
  <script setup>
import { ref, reactive, onMounted, watch, onBeforeMount } from 'vue'
import myHeader from '../components/header/header.vue';
import search from '@/components/search/index.vue';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
import { useRoute, useRouter } from 'vue-router';
const router = useRouter()
const route = useRoute()
// console.log(route.query)
message.info(route.query.type)
const target=route.query.type
const logText = ref('');
let localVideo 
let remoteVideo 
const startbutton = ref(null)
const testServer = 'ws://localhost:8080'
const logger = {
log(msg) {
  logText.value += `<span>${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
},
error(msg) {
  logText.value += `<span class="error">${new Date().toLocaleTimeString()}：${msg}</span><br/>`;
}
};
async function startLive (offerSdp) {
			let stream;
			try {
				logger.log('尝试调取本地摄像头/麦克风');
				stream = await navigator.mediaDevices.getDisplayMedia({ video: true, audio: true });
				logger.log('摄像头/麦克风获取成功！');
				localVideo.srcObject = stream;
			} catch {
				logger.error('摄像头/麦克风获取失败！');
				return;
			}

			logger.log(`------ WebRTC ${target === 'sender' ? '发起方' : '接收方'}流程开始 ------`);
			logger.log('将媒体轨道添加到轨道集');
			stream.getTracks().forEach(track => {
				peer.addTrack(track, stream);
			});

			if (!offerSdp) {
				logger.log('创建本地SDP');
				const offer = await peer.createOffer();
				await peer.setLocalDescription(offer);
				
				logger.log(`传输发起方本地SDP`);
				socket.send(JSON.stringify(offer));
			} else {
				logger.log('接收到发送方SDP');
				await peer.setRemoteDescription(offerSdp);

				logger.log('创建接收方（应答）SDP');
				const answer = await peer.createAnswer();
				logger.log(`传输接收方（应答）SDP`);
				socket.send(JSON.stringify(answer));
				await peer.setLocalDescription(answer);
			}
		}
onMounted(()=>{
   localVideo = document.querySelector('#local-video');
remoteVideo = document.querySelector('#remote-video');
localVideo.onloadeddata = () => {
  logger.log('播放本地视频');
  localVideo.play();
}

remoteVideo.onloadeddata = () => {
  logger.log('播放对方视频');
  remoteVideo.play();
}


    
}
)
logger.log('信令通道（WebSocket）创建中......');
		const socket = new WebSocket(testServer);
		socket.onopen = () => {
			logger.log('信令通道创建成功！');
		}
		socket.onerror = () => logger.error('信令通道创建失败！');
    socket.onmessage = e => {
			const { type, sdp, iceCandidate } = JSON.parse(e.data)
			if (type === 'answer') {
				peer.setRemoteDescription(new RTCSessionDescription({ type, sdp }));
			} else if (type === 'answer_ice') {
				peer.addIceCandidate(iceCandidate);
			} else if (type === 'offer') {
				startLive(new RTCSessionDescription({ type, sdp }));
			} else if (type === 'offer_ice') {
				peer.addIceCandidate(iceCandidate);
			}
		};
const PeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
		!PeerConnection && logger.error('浏览器不支持WebRTC！');
		const peer = new PeerConnection();
    peer.ontrack = e => {
			if (e && e.streams) {
				logger.log('收到对方音频/视频流数据...');
				remoteVideo.srcObject = e.streams[0];
			}
		};

		peer.onicecandidate = e => {
			if (e.candidate) {
				logger.log('搜集并发送候选人');
				socket.send(JSON.stringify({
					type: `${target}_ice`,
					iceCandidate: e.candidate
				}));
			} else {
				logger.log('候选人收集完成！');
			}
		};

		
  </script>
  <template>
    <a-button @click="startLive()">开始</a-button>
   <div class="container">
		<div class="video-box">
			<video  id="remote-video"></video>
			<video  id="local-video" muted></video>
			<!-- <button ref="startbutton" class="start-button" onclick="startLive()">start</button> -->
		</div>
		<div class="logger"><div v-html="logText"></div></div>
	</div>
  </template>
  <style scoped lang='scss'>
  		* {
			padding: 0;
			margin: 0;
			box-sizing: border-box;
		}
		.container {
			width: 100%;
			display: flex;
			display: -webkit-flex;
			justify-content: space-around;
			padding-top: 20px;
		}
		.video-box {
			position: relative;
			width: 800px;
			height: 400px;
		}
		#remote-video {
			width: 100%;
			height: 100%;
			display: block;
			object-fit: cover;
			border: 1px solid #eee;
			background-color: #F2F6FC;
		}
		#local-video {
			position: absolute;
			right: 0;
			bottom: 0;
			width: 240px;
			height: 120px;
			object-fit: cover;
			border: 1px solid #eee;
			background-color: #EBEEF5;
		}
		.start-button {
			position: absolute;
			left: 50%;
			top: 50%;
			width: 100px;
			display: none;
			line-height: 40px;
			outline: none;
			color: #fff;
			background-color: #409eff;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			transform: translate(-50%, -50%);
		}
		.logger {
			width: 40%;
			padding: 14px;
			line-height: 1.5;
			color: #4fbf40;
			border-radius: 6px;
			background-color: #272727;
		}
		.logger .error {
			color: #DD4A68;
		}
	</style>
  