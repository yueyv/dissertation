<script setup>
import { h, ref, reactive, onMounted, nextTick, onUpdated, watch, onBeforeMount, onUnmounted } from 'vue';
import axios from '@/plugins/axiosBase.js'
import { message } from "ant-design-vue"
import { io } from "socket.io-client";
import { useRoute, useRouter } from 'vue-router';
import {
    CommentOutlined,
    MailOutlined,
    CloseOutlined,
    AlignLeftOutlined
} from '@ant-design/icons-vue';
import { useChatStore } from '../../store/index'
import { storeToRefs } from 'pinia'
const ChatStore = useChatStore()
const { status } = storeToRefs(ChatStore)
const { statusChangeFalse } = ChatStore
const productionURL=()=>{
    if(process.env.NODE_ENV === 'production'){
        return "http://20.213.10.238:3000"
    }else if(process.env.NODE_ENV === 'nginx'){
        return ""
    }
    else{
        return ""
    }
}
console.log(status.value);
watch(status, () => {
    if (status.value == true) {
        statusChangeFalse()
        axios.get('getChatId').then((res) => {
            if (res.code == 200) {
                const chatId = res.data
                // console.log(res.data);
                const result = chatId.map(item => {
                    // 给定初始化
                    // console.log(item);
                    chatLog[item[0]] = Array(0)
                    // console.log(chatLog);
                    // Mark 记录未读消息
                    if (item[2]?.read == 0) {
                        return buildUnReadChatItem(item[0], item[1])
                    }
                    return buildChatItem(item[0], item[1])
                });
                items.value = result
                isShow.value = true
                selectedKeys.value = [items.value[0].children[0].key];
                getChatLog(items.value[0].key)
                to_id.value = items.value[0].key
                // console.log(result);
            } else {
                console.log(res);
                if (res.code == 202) {
                    message.info("尚未开始聊天")
                } else {
                    message.info("返回数据错误")
                }

            }
        }).catch((e) => {
            message.error("请求错误")
            console.log(e);
        })
    }
})
// 上一个
// MARK 根据permission 进行不同页面的跳转
const router = useRouter()
const refresh = ref(0)
const permission = ref(-1)
const selectedKeys = ref([]);
const inputText = ref("")
const openKeys = ref();
const user_id = ref(0)
// todo 存储在indexedDB中 放弃
const chatLog = reactive({})
const isShow = ref(false)
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
                key: 'delete0',
                label: '删除',
                title: '删除',
                icon: () => h(CloseOutlined),
            },]
    }
]);
const to_id = ref()
let socket = undefined
const handleClick = menuInfo => {
    if (menuInfo.key.includes("chat")) {
        to_id.value = openKeys.value[0]
        // 获取历史记录
        // done从存储中获取
        getChatLog(openKeys.value[0])
    }
    if (menuInfo.key.includes("find")) {
        // done 分类操作
        if (permission.value == 1) {
            router.push(`/applicantPage/${openKeys.value[0]}`)
        }
        if (permission.value == 0) {
            router.push(`/chatFindPage/${openKeys.value[0]}`)
        }

    }
    if (menuInfo.key.includes("delete")) {
        axios.post('chatDelete', { delete_id: openKeys.value[0] }).then((res) => {
            if (res.code == 200) {
                message.success("删除成功")
                axios.get('getChatId').then((res) => {
                    if (res.code == 200) {
                        const chatId = res.data
                        // console.log(res.data);
                        const result = chatId.map(item => {
                            // 给定初始化
                            // console.log(item);
                            chatLog[item[0]] = Array(0)
                            // console.log(chatLog);
                            // Mark 记录未读消息
                            if (item[2]?.read == 0) {
                                return buildUnReadChatItem(item[0], item[1])
                            }
                            return buildChatItem(item[0], item[1])
                        });
                        items.value = result
                        isShow.value = true
                        selectedKeys.value = [items.value[0].children[0].key];
                        getChatLog(items.value[0].key)
                        to_id.value = items.value[0].key
                        // console.log(result);
                    } else {
                        console.log(res);
                        if (res.code == 202) {
                            message.info("尚未开始聊天")
                        } else {
                            message.info("返回数据错误")
                        }

                    }
                }).catch((e) => {
                    message.error("请求错误")
                    console.log(e);
                })
            }
        }
        )

    }
    // console.log(openKeys.value);
};
const getChatLog = (chatToId) => {

    axios.post('get_chat', { chatWith: chatToId }).then((res) => {
        if (res.code == 200) {
            chatLog[chatToId] = res.data
            // console.log(chatLog);
        } else {
            console.log("服务器错误");
        }
    })
}
const buildChatItem = (item, label) => {
    return {
        key: item,
        icon: () => h(MailOutlined),
        label: `${label}`,
        title: `${label}`,
        children: [
            {
                key: `chat${item}`,
                label: '查看聊天',
                title: '查看聊天',
                icon: () => h(CommentOutlined),
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
const buildUnReadChatItem = (item, label) => {
    return {
        key: item,
        icon: () => h(MailOutlined, { style: { color: 'red' } }),
        label: `${label}`,
        title: `${label}`,
        children: [
            {
                key: `chat${item}`,
                label: '查看聊天',
                title: '查看聊天',
                icon: () => h(CommentOutlined),
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
    if (inputText?.value == "" || inputText?.value == "\n") {
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
            const chatId = res.data
            // console.log(res.data);
            const result = chatId.map(item => {
                // 给定初始化
                // console.log(item);
                chatLog[item[0]] = Array(0)
                // console.log(chatLog);
                // Mark 记录未读消息
                if (item[2]?.read == 0) {
                    return buildUnReadChatItem(item[0], item[1])
                }
                return buildChatItem(item[0], item[1])
            });
            items.value = result
            isShow.value = true
            selectedKeys.value = [items.value[0].children[0].key];
            getChatLog(items.value[0].key)
            to_id.value = items.value[0].key
            // console.log(result);
        } else {
            console.log(res);
            if (res.code == 202) {
                message.info("尚未开始聊天")
            } else {
                message.info("返回数据错误")
            }

        }
    }).catch((e) => {
        message.error("请求错误")
        console.log(e);
    })
    // 挂载socket
    const token = JSON.parse(localStorage.getItem('token'))
    socket = io(productionURL(), {
        reconnectionDelayMax: 10000,
        auth: { token: token }
    })
    socket.on('connect', () => {
        socket.emit('online');
    });
    socket.on('chat_success', (req) => {
        if (req == true) {
            message.info("已发送消息")
            // console.log(chatLog);
            chatLog[to_id.value].push({ to_id: to_id.value, content: inputText.value })
            inputText.value = '';
            // console.log( chatLog);
        }
    });
    socket.on('reply_private_chat', (req) => {
        // console.log(req);
        message.info(`收到了${req.from_username}的信息`)
        chatLog[req.from_id].push({ to_id: user_id.value, content: req.content })
        // console.log(chatLog);

    });

    socket.on("disconnect", () => {
        socket.connect();
    });

})
onMounted(() => {


    // console.log(items.value[0].key);

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
    <div class="chat-contain">
        <div class="chat-box">
            <div class="menu-nav" :key="refresh">
                <!-- :defaultOpenKeys="items[0].children[0].key" -->
                <a-menu v-if="!isShow" class="menu-item" />
                <a-menu v-if="isShow" class="menu-item" :selectable="true" v-model:openKeys="openKeys"
                    v-model:selectedKeys="selectedKeys" mode="vertical" :items="items" @click="handleClick" />
            </div>
            <div class="menu-content" style="width: 100%;">
                <div class="chat-content" ref="scrollContainer">
                    <div v-for="item in chatLog[to_id]" :key="item.message_id">
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
    margin-right: 50%;
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
    margin-left: 50%;
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
    transition: all ease 1s;

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

// .anticon-mail{
//     color: red !important;
// }</style>