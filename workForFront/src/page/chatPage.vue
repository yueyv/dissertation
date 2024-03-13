<script setup>
import myHeader from '@/components/header/header.vue';
import { h, ref, onMounted, nextTick, onUpdated, watch, onBeforeMount, onUnmounted } from 'vue';
import axios from '../plugins/axiosBase'
import { message } from "ant-design-vue"
import { io } from "socket.io-client";
import {
    CommentOutlined,
    MailOutlined,
    CloseOutlined,
    AlignLeftOutlined
} from '@ant-design/icons-vue';
// 上一个
const selectedKeys = ref([]);
const inputText = ref("")
const openKeys = ref();
const user_id = ref()
const chatLog = ref()

// 读取key，获取交流
const items = ref([
    {
        key: '0',
        icon: () => h(MailOutlined),
        label: '交流0',
        title: '交流0',
        children: [
            {
                key: 'chat0',
                label: '查看聊天',
                title: '查看聊天',
                icon: () => h(CommentOutlined),
            },
            {
                key: 'find0',
                label: '查看资料',
                title: '查看资料',
                icon: () => h(AlignLeftOutlined),
            },
            {
                key: 'delete30',
                label: '删除',
                title: '删除',
                icon: () => h(CloseOutlined),
            },]
        }
]);
const to_id = ref(items.value[0].key)
let socket = undefined
const handleClick = menuInfo => {
    if (menuInfo.key.includes("chat")) {
        to_id.value = openKeys.value[0]
        // 获取历史记录
        // TODO从存储中获取
        getChatLog(openKeys.value[0])
    }
    // console.log(openKeys.value);
};
const getChatLog = (chatToId) => {
    axios.post('get_chat', { chatWith: chatToId }).then((res) => {
        if (res.code == 200) {
            chatLog.value = res.data

        } else {
            console.log("服务器错误");
        }
    })
}
const buildChatItem = (item) => {
    return {
        key: item,
        icon: () => h(MailOutlined),
        label: `交流${item}`,
        title: `交流${item}`,
        children: [
            {
                key: `chat${item}`,
                label: '查看聊天',
                title: '查看聊天',
                icon: () => h(CommentOutlined),
            },
            {
                key: `find${item}`,
                label: '查看资料',
                title: '查看资料',
                icon: () => h(AlignLeftOutlined),
            },
            {
                key: `delete${item}`,
                label: '删除',
                title: '删除',
                icon: () => h(CloseOutlined),
            },
        ]
    };
}

//  获取聊天记录滚动到最底部
const scrollContainer = ref(null);

const scrollToBottom = () => {
    setTimeout(() => {
        if (scrollContainer.value) {
            scrollContainer.value.scrollTop = scrollContainer.value.scrollHeight;
        }
    }, 0);
};
const sendMsg = () => {
    // console.log(inputText.value);
    if (inputText?.value == "") {
        message.info('Message is required!');
        return
    }
    const msg = {
        text: inputText.value,
        to_id: to_id.value
    };

    socket.emit('private_chat', msg);



}
onBeforeMount(() => {
    axios.get('getChatId').then((res) => {
        if (res.code == 200) {
            const chatId = res.data.chat_id.split(',')
            const result = chatId.map(item=>buildChatItem(item));
            items.value=result
    console.log(result);
} else {
    message.info("返回数据错误")
}
    }).catch((e) => {
    message.error("请求错误")
    console.log(e);
})
// 挂载socket
const token = JSON.parse(localStorage.getItem('token'))
socket = io('http://localhost:3000', {
    reconnectionDelayMax: 10000,
    auth: { token: token }
})
socket.on('connect', () => {
    socket.emit('online');
});
socket.on('chat_success', (req) => {
    if (req == true) {
        message.info("已发送消息")
        console.log(chatLog.value);
        chatLog.value.push({ to_id: to_id.value, content: inputText.value })
        inputText.value = '';
    }
});
socket.on('reply_private_chat', (req) => {
    message.info(`${req}收到了信息`)
    console.log(req);
});

socket.on("disconnect", () => {
    socket.connect();
});

})
onMounted(() => {
    selectedKeys.value = [items.value[0].children[0].key];
    const userInformation = JSON.parse(sessionStorage.getItem("userInformation"))
    user_id.value = userInformation.user_id
    // console.log(items.value[0].key);
    getChatLog(items.value[0].key)
    // console.log(userInformation);
});
onUpdated(() => {
    nextTick(scrollToBottom);
})

onUnmounted(() => {
    socket.disconnect()
})
// MARK 测试
// watch(selectedKeys, () => {
//     console.log(selectedKeys.value);
//     ref
// })
</script>

<template>
    <myHeader></myHeader>
    <div class="chat-contain">
        <div class="chat-box">
            <div class="menu-nav">
                <!-- :defaultOpenKeys="items[0].children[0].key" -->
                <a-menu class="menu-item" :selectable="true" v-model:openKeys="openKeys"
                    v-model:selectedKeys="selectedKeys" mode="vertical" :items="items" @click="handleClick" />
            </div>
            <div class="menu-content" style="width: 100%;">
                <div class="chat-content" ref="scrollContainer">
                    <div v-for="item in chatLog" :key="item.message_id">
                        <div v-if="item.to_id == user_id" class="chat-item-left">
                            {{ item.content }}
                        </div>
                        <div v-if="item.to_id != user_id" class="chat-item-right">
                            {{ item.content }}
                        </div>
                    </div>
                </div>

                <div class="chat-input">
                    <a-textarea v-model:value="inputText" @keyup.enter="sendMsg()" placeholder="在此输入聊天内容。输入回车发送"
                        :auto-size="{ minRows: 3, maxRows: 3 }" />

                </div>
            </div>
        </div>
    </div>
</template>

<style scoped lang='scss'>
.chat-contain {
    display: flex;

    border-radius: 20px;
    margin-top: 5vh;
    margin-left: 10vw;
    width: 80vw;
    height: 80vh;
    background-color: rgba(255, 255, 255, 0.589);
}

.chat-box {
    display: flex;
    margin-top: 20px;
    background-color: rgba(27, 107, 107, 0.404);
    width: 100%;
    margin-bottom: 20px;
}

.menu-item {
    min-height: 100%;
    text-align: center;
    font-weight: 600;
    background-color: #e0e0e0c7;

    // color: #FFFFFF;
}

.menu-nav {
    width: 30%;
    overflow: scroll;

    &::-webkit-scrollbar {
        display: none;
    }
}


.chat-item-left {
    max-width: 60%;
    margin-right: 40%;
    display: inline-block;
    border-radius: 10px;
    padding-top: 5px;
    padding-left: 20px;
    padding-right: 20px;
    margin-top: 5px;
    margin-left: 10px;
    padding-bottom: 8px;
    background-color: rgba(97, 177, 177, 0.356);
    text-align: left;
    font-size: 1.2rem;
    overflow-wrap: break-word;
    margin-bottom: 10px;
}

.chat-item-right {
    margin-right: 10px;
    margin-left: 40%;
    margin-bottom: 5px;
    max-width: 60%;
    border-radius: 10px;
    padding-top: 5px;
    padding-left: 20px;
    padding-right: 20px;
    padding-bottom: 8px;
    background-color: rgba(216, 208, 208, 0.589);
    text-align: left;
    font-size: 1.2rem;
    overflow-wrap: break-word;
    float: right;
}

.menu-content {



    // flex-grow: 1;
    max-width: 70%;
    min-height: 100%;
    background-color: rgba(240, 248, 255, 0.514);
}

.chat-content {
    overflow-x: hidden;

    &::-webkit-scrollbar {
        display: none;
    }

    height: calc(100% - 78px);

}

.chat-input {
    display: flex;
    justify-content: center;
    /* 水平居中 */
    align-items: end;
    /* 垂直居中 */
    // height: 20%;
    margin-top: 3px;
    // min-height: 20%;
    border-radius: 20px;
}
</style>