import { message } from "ant-design-vue"
import { io } from "socket.io-client";
// SSR tip
const token = JSON.parse(localStorage.getItem('token'))
// 发送接收信息


// console.log(token);
// 携带token
const productionURL=()=>{
    if(process.env.NODE_ENV === 'production'){
        return "http://20.213.10.238:3000"
    }else{
        return "http://localhost:3000"
    }
}
const inputText = ref("")
const to_id = ref()
// console.log(token);
// 携带token
const socket = io(productionURL(), {
    reconnectionDelayMax: 10000,
    auth: { token: token }
})
socket.on('reply_private_chat', (req) => {
    message.info(`${req}收到了信息`)
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


