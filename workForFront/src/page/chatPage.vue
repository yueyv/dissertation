<script setup>
import myHeader from '@/components/header/header.vue';
import { h, ref, reactive, onMounted, nextTick, onUpdated, watch, onBeforeMount, onUnmounted } from 'vue';
import axios from '../plugins/axiosBase'
import { message } from "ant-design-vue"
import { io } from "socket.io-client";
import { useRoute, useRouter } from 'vue-router';
import {
    CommentOutlined,
    MailOutlined,
    CloseOutlined,
    AlignLeftOutlined
} from '@ant-design/icons-vue';
// 上一个
// MARK 根据permission 进行不同页面的跳转
const router = useRouter()
const permission = ref(-1)
const selectedKeys = ref([]);
const inputText = ref("")
const openKeys = ref();
const activeKey = ref()
const user_id = ref()
// todo 存储在indexedDB中
const chatLog = reactive({})
const isShow = ref(false)
// 读取key，获取交流
const items = ref([
    {
        key: '0',
        // icon: () => h(MailOutlined),
        read: true,
        label: '交流0',
        title: '交流0',
        // children: [
        //     {
        //         key: 'chat0',
        //         label: '查看聊天',
        //         title: '查看聊天',
        //         icon: () => h(CommentOutlined),
        //     },
        //     {
        //         key: 'find0',
        //         label: '查看资料',
        //         title: '查看资料',
        //         icon: () => h(AlignLeftOutlined),
        //     },
        //     {
        //         key: 'delete0',
        //         label: '删除',
        //         title: '删除',
        //         icon: () => h(CloseOutlined),
        //     },]
    }
]);
const to_id = ref()
let socket = undefined
// SSR
// const handleClick = menuInfo => {
//     console.log(menuInfo.key,11);
//     if (menuInfo.key.includes("chat")) {
//         to_id.value = openKeys.value[0]
//         // 获取历史记录
//         // done从存储中获取
//         getChatLog(openKeys.value[0])
//     }
//     if (menuInfo.key.includes("find")) {
//         // done 分类操作
//         if (permission.value == 1) {
//             router.push(`/applicantPage/${openKeys.value[0]}`)
//         }
//         if (permission.value == 0) {
//             router.push(`/chatFindPage/${openKeys.value[0]}`)
//         }

//     }
//     if (menuInfo.key.includes("delete")) {
//         axios.post('chatDelete', { delete_id: openKeys.value[0] }).then((res) => {
//             if (res.code == 200) {
//                 message.success("删除成功")
//                 axios.get('getChatId').then((res) => {
//                     if (res.code == 200) {
//                         const chatId = res.data
//                         // console.log(res.data);
//                         const result = chatId.map(item => {
//                             // 给定初始化
//                             // console.log(item);
//                             chatLog[item[0]] = Array(0)
//                             // console.log(chatLog);
//                             // Mark 记录未读消息
//                             if (item[2]?.read == 0) {
//                                 return buildUnReadChatItem(item[0], item[1])
//                             }
//                             return buildChatItem(item[0], item[1])
//                         });
//                         items.value = result
//                         isShow.value = true
//                         selectedKeys.value = [items.value[0].children[0].key];
//                         console.log(items.value[0]);
//                         getChatLog(items.value[0].key)
//                         to_id.value = items.value[0].key
//                         // console.log(result);
//                     } else {
//                         console.log(res);
//                         if (res.code == 202) {
//                             message.info("尚未开始聊天")
//                         } else {
//                             message.info("返回数据错误")
//                         }

//                     }
//                 }).catch((e) => {
//                     message.error("请求错误")
//                     console.log(e);
//                 })
//             }
//         }
//         )

//     }
//     // console.log(openKeys.value);
// };\
const chatItem = (chat_id) => {
    to_id.value = chat_id
    activeKey.value=chat_id
    //         // 获取历史记录
    //         // done从存储中获取
    getChatLog(chat_id)
}
const searchItem = (search_id) => {
    if (permission.value == 1) {
        router.push(`/applicantPage/${search_id}`)
    }
    if (permission.value != 1) {
        router.push(`/chatFindPage/${search_id}`)
    }
}
const deleteItem = (delete_id) => {
    axios.post('chatDelete', { delete_id: delete_id }).then((res) => {
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
                    // selectedKeys.value = [items.value[0].children[0].key];
                    // console.log(items.value[0]);
                    activeKey.value = items.value[0].key
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
}
const getChatLog = (chatToId) => {

    axios.post('get_chat', { chatWith: chatToId }).then((res) => {
        console.log({ chatWith: chatToId }, res);
        if (res.code == 200) {
            chatLog[chatToId] = res.data
            console.log(chatLog);
        } else {
            console.log("服务器错误");
        }
    })
}
const buildChatItem = (item, label) => {
    return {
        key: item,
        read: true,
        label: `${label}`,
        title: `${label}`,
        // children: [
        //     {
        //         key: `chat${item}`,
        //         label: '查看聊天',
        //         title: '查看聊天',
        //         icon: () => h(CommentOutlined),
        //     },
        //     {
        //         key: `find${item}`,
        //         label: '查看资料',
        //         title: '查看资料',
        //         icon: () => h(AlignLeftOutlined),
        //     },
        //     {
        //         key: `delete${item}`,
        //         label: '删除',
        //         title: '删除',
        //         icon: () => h(CloseOutlined),
        //     },
        // ]
    };
}
const buildUnReadChatItem = (item, label) => {
    return {
        key: item,
        read: false,
        label: `${label}`,
        title: `${label}`,
        // children: [
        //     {
        //         key: `chat${item}`,
        //         label: '查看聊天',
        //         title: '查看聊天',
        //         icon: () => h(CommentOutlined),
        //     },
        //     {
        //         key: `delete${item}`,
        //         label: '删除',
        //         title: '删除',
        //         icon: () => h(CloseOutlined),
        //     },
        // ]
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
    permission.value = JSON.parse(sessionStorage.getItem("permission"))
    const userInformation = JSON.parse(sessionStorage.getItem("userInformation"))
    if (userInformation == null) {
        router.push("/")
    }
    user_id.value = userInformation.user_id
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
            console.log(result);
            items.value = result
            isShow.value = true
            // selectedKeys.value = [items.value[0].children[0].key];
            getChatLog(items.value[0].key)
            to_id.value = items.value[0].key

            activeKey.value = items.value[0].key
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
            // console.log(chatLog);
            chatLog[to_id.value].push({ to_id: to_id.value, content: inputText.value })
            inputText.value = '';
            // console.log(chatLog);
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
    <myHeader></myHeader>
    <div class="chat-contain">
        <div class="chat-box">
            <div class="menu-nav">
                <!-- :defaultOpenKeys="items[0].children[0].key" -->
                <!-- SSR -->
                <!-- <a-menu v-if="!isShow" class="menu-item" />
                <a-menu v-if="isShow" class="menu-item" :selectable="true" v-model:openKeys="openKeys" :forceSubMenuRender="true"
                    v-model:selectedKeys="selectedKeys" mode="vertical" :items="items" @click="handleClick" /> -->
                <div v-if="!isShow" class="menu-item">
                    <div class="item-label" v-for="item in 3">
                                <!-- <MailOutlined style="color: #ffe29f;" /> -->
                                <a-skeleton :loading="true" active :paragraph="{ rows: 1,width:'100%' }"  :title="false"/>
                            </div>
                    
                    
                </div>
                <div v-if="isShow" class="menu-item">
                    <div v-for="(item, index) in items">
                        <a-dropdown>
                            <div class="item-label" :class="activeKey == item.key ? 'active' : ''">
                                <MailOutlined style="color: #ffe29f;" :class="item.read ? '' : 'unread'" />
                                {{ item.label }}
                            </div>
                            <template #overlay>
                                <a-menu style="width: 40%;margin-left: 80%; max-width: 200px;min-width: 150px;">
                                    <a-menu-item class="item" @click="chatItem(item.key)">
                                        <CommentOutlined />
                                        查看聊天
                                    </a-menu-item>
                                    <a-menu-item class="item" @click="searchItem(item.key)">
                                        <AlignLeftOutlined />
                                        查看资料
                                    </a-menu-item>
                                    <a-menu-item class="item" @click="deleteItem(item.key)">
                                        <CloseOutlined />
                                        删除
                                    </a-menu-item>
                                </a-menu>
                            </template>
                        </a-dropdown>
                    </div>
                </div>
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
.unread {
    color: #9c5e70 !important;
}

.item {
    :hover {
        color: #797979;
        background-color: rgba(255, 255, 255, 0.664);
    }
}

.item-label {
    padding-top: 10px;
    padding-bottom: 10px;
    margin-bottom: 15px;
    // border: 1px solid black;
    border-radius: 5px;
    color: #f6f6f6;


    &.active {
        color: #9c5e70;
        background-color: rgba(255, 255, 255, 0.308);
    }

    &:hover {
        color: #797979;
        background-color: rgba(255, 255, 255, 0.664);
    }
}

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
</style>