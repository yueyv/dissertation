<script setup>
import { h, ref, reactive, onMounted, nextTick, onUpdated, watch, onBeforeMount, onUnmounted } from 'vue';
import axios from '@/plugins/axiosBase.js'
import { message } from "ant-design-vue"
import { useRoute, useRouter } from 'vue-router';
import zh_CN from "ant-design-vue/lib/locale/zh_CN";
import { SmileOutlined, DownOutlined } from '@ant-design/icons-vue';
const isShow = ref(false)
const columns = [
    {
        title: 'username',
        dataIndex: 'username',
        key: 'username',
    },
    {
        title: '人员类别',
        dataIndex: 'permission',
        key: 'permission',
        filters: [
            {
                text: '普通用户',
                value: 0,
            }, {
                text: '招聘人员',
                value: 1,
            }, {
                text: '申请人员',
                value: -1,
            },

        ],
        filterMode: 'tree',
        onFilter: (value, jobData) => jobData.permission == value,
    },
    {
        title: '姓名',
        key: 'name',
        dataIndex: 'name',
    },
    {
        title: '城市',
        dataIndex: 'city',
        key: 'city',
    },
    {
        title: '地址',
        dataIndex: 'address',
        key: 'address',
    },
    {
        title: '邮箱',
        key: 'email',
        dataIndex: 'email',
    }, {
        title: "操作",
        key: "action"
    }

];
let jobData = []
onBeforeMount(() => {
    axios.post("getAllJobAdmin").then((res) => {
        if (res.code == 200) {
            isShow.value = true
            jobData = res.data
            console.log(jobData);
        } else {
            message.info("返回错误")
        }
    })

})

// todo 聊天
const chat = (user_id) => {

}
// todo 查看文档（下载）
const inquire = (user_id,apply_filename) => {

}
// todo 变更权限
const changePermission = (user_id,permission) => {

}
</script>

<template>
    <div class="user-contain">
        <a-table :locale="zh_CN" class="user-table" v-if="isShow" :columns="columns" :data-source="jobData"
            :pagination="{ position: '[bottomRight]', hideOnSinglePage: true }">
            <template #headerCell="{ column }">
                <template v-if="column.key === 'username'">
                    <span>
                        <smile-outlined />
                        用户名
                    </span>
                </template>
            </template>
            <template #bodyCell="{ column, record }">
                <template v-if="column.key === 'username'">
                    {{ record.username }}
                </template>
                <template v-else-if="column.key === 'permission'">
                    <span>
                        <a-tag
                            :color="record.permission == '0' ? 'volcano' : record.permission == '1' ? 'geekblue' : 'green'">
                            {{ record.permission == '0' ? '普通用户' : record.permission == '1' ? '招聘人员' : '申请人员' }}
                        </a-tag>
                    </span>
                </template>
                <template v-else-if="column.key === 'action'">
                    <span>
                        <a @click="chat(record.user_id)">聊天</a>
                        &nbsp;
                        <a @click="inquire(record.user_id,record.apply_filename)" v-if="record.permission != '0'">查看申请文件</a>
                        <br>
                        <a @click="changePermission(record.user_id,1)" v-if="record.permission == '-1'">同意申请</a>
                        <a @click="changePermission(record.user_id,0)" v-if="record.permission == '1'">取消权限</a>
                    </span>
                </template>
            </template>
        </a-table>
    </div>
</template>

<style scoped lang='scss'>
.user-table {
    width: 100%;
    margin-top: 4vh;
    border-radius: 20px;
    background-color: #ffffff00;
    overflow: scroll;

    &::-webkit-scrollbar {
        display: none;
    }

    text-align: center !important;
}

.ant-table-pagination-right {
    float: none !important;
    text-align: center;
}

.user-contain {
    justify-content: center;
    display: flex;
    padding-right: 10px;
    // align-items: center;
    padding-left: 10px;
    border-radius: 20px;
    margin-top: 5vh;
    margin-left: 10vw;
    width: 80vw;
    height: 80vh;
    background-color: rgba(255, 255, 255, 0.589);
}
</style>