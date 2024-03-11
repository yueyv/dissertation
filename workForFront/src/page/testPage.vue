<script setup>
import { ref, reactive, onUnmounted } from 'vue'
import { message } from "ant-design-vue"
import { axiosBase } from '../plugins/axiosBase'
import md5 from 'js-md5'
import { io } from "socket.io-client";
// SSR tip
const token = JSON.parse(localStorage.getItem('token'))
// 发送接收信息
const query = {
    sender: 'Sender',
    receiver: 'receiver'
};
const inputText = ref("")
const to_id = ref()
// console.log(token);
// 携带token
const socket = io('http://localhost:3000', {
    reconnectionDelayMax: 10000,
    auth: { token: token }
})
socket.on('connect', () => {
    socket.emit('online', query.sender);
});
socket.on('reply_private_chat', (req) => {
    message.info("收到了信息")
    console.log(req);
});
const sendMsg = () => {
    // console.log(inputText.value);
    if (inputText.value == "") {
        message.info('Message is required!');
        return
    }
    const msg = {
        text: inputText.value,
        to_id: to_id.value
    };

    socket.emit('private_chat', msg);
    message.info("已发送消息")
    inputText.value = '';

}


    function sendMsgByEnter(event) {
        if (event.keyCode === 13) {
            sendMsg();
        }
    }
socket.on("disconnect", () => {
    socket.connect();
});
onUnmounted(() => {
    socket.disconnect()
})

</script>

<template>
    <a-input v-model:value="to_id"></a-input>
    <a-input v-model:value="inputText"></a-input>
    <!-- <a-button @click="" type="primary">Primary Button</a-button> -->
    <a-button @click="sendMsg">SEND </a-button>
</template>

<style scoped lang='scss'></style>

<!-- socket.emit("hello","this is a try")
socket.on("???",(val)=>{
        console.log(val);
    })
// console.log(socket);
// console.log(md5("233"));
// message.info(md5("323")) -->