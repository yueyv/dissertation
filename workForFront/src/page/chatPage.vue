<script setup>
import myHeader from '@/components/header/header.vue';
import { h, ref } from 'vue';
import {
    MailOutlined,
    CloseOutlined,
    AlignLeftOutlined
} from '@ant-design/icons-vue';
const selectedKeys = ref([]);
const openKeys = ref([]);
const items = ref([
    {
        key: '1',
        icon: () => h(MailOutlined),
        label: '交流1',
        title: '交流1',
        children: [
            {
                key: 'find1',
                label: '查看资料',
                title: '查看资料',
                icon: () => h(AlignLeftOutlined),
            },
            {
                key: 'delete1',
                label: '删除',
                title: '删除',
                icon: () => h(CloseOutlined),
            },]
    }, {
        key: '2',
        icon: () => h(MailOutlined),
        label: '交流2',
        title: '交流2',
        popupClassName: "popup-box",
        children: [
            {
                key: 'find2',
                label: '查看资料',
                title: '查看资料',
            },
            {
                key: 'delete2',
                label: '删除',
                title: '删除',
            },]
    },

]);
const handleClick = menuInfo => {
    console.log('click ', menuInfo);
};
const mychat=ref("")
// MARK 发送信息
const handleEnter=()=>{

}
// TODO 获取聊天记录滚动到最底部
</script>

<template>
    <myHeader></myHeader>
    <div class="chat-contain">
        <div class="chat-box">
            <div class="menu-nav">
                <a-menu class="menu-item" v-model:openKeys="openKeys" v-model:selectedKeys="selectedKeys" mode="vertical"
                    :items="items" @click="handleClick" />
            </div>
            <div class="menu-content">
                <div class="chat-content">
                    <div class="chat-item-left">
                        22adwawddas22adwawddas22adwawddas22adwawddas22adwawddas22adwawddas22adwawddas22adwawddasd</div>
                    <div class="chat-item-right">22</div>
                </div>
                <div class="chat-input">
                    <a-textarea v-model:value="mychat"
                    @keyup.enter="handleEnter"
                        placeholder="在此输入聊天内容。输入回车发送"
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
    background-color: aqua;
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

.menu-content {

    overflow-x: hidden;

    &::-webkit-scrollbar {
        display: none;
    }

    // flex-grow: 1;
    max-width: 70%;
    min-height: 100%;
    background-color: rgba(240, 248, 255, 0.788);
}

.chat-item-left {
    max-width: 60%;
    border-radius: 10px;
    padding-top: 5px;
    padding-left: 20px;
    padding-right: 20px;
    margin-left: 10px;
    padding-bottom: 8px;
    background-color: aqua;
    text-align: left;
    font-size: 1.2rem;
    overflow-wrap: break-word;
    margin-bottom: 10px;
}

.chat-item-right {
    max-width: 60%;
    border-radius: 10px;
    padding-top: 5px;
    padding-left: 20px;
    padding-right: 20px;
    margin-left: 30%;
    padding-bottom: 8px;
    background-color: white;
    text-align: left;
    font-size: 1.2rem;
    overflow-wrap: break-word;
}

.chat-content {
    min-height: 80%;
}

.chat-input {
    margin-top: 3px;
    min-height: 20%;
    border-radius: 20px;
}</style>