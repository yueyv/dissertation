<script setup>
import { h, ref, reactive, onMounted, nextTick, onUpdated, watch, onBeforeMount, onUnmounted } from 'vue';
import axios from '@/plugins/axiosBase.js'
import { message } from "ant-design-vue"
import { useRoute, useRouter } from 'vue-router';
import zh_CN from "ant-design-vue/lib/locale/zh_CN";
import { SmileOutlined, DownOutlined, SearchOutlined } from '@ant-design/icons-vue';
const isShow = ref(false)
const columns = [
    {
        title: '用户序号',
        dataIndex: 'user_id',
        key: 'user_id',
        customFilterDropdown: true,
        onFilter: (value, record) => record.user_id == value,
        onFilterDropdownOpenChange: visible => {
            if (visible) {
                setTimeout(() => {
                    searchInput.value.focus();
                }, 100);
            }
        },
    },
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
        onFilter: (value, userData) => userData.permission == value,
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
let userData = []
const state = reactive({
    searchText: '',
    searchedColumn: '',
});

const searchInput = ref();
onBeforeMount(() => {
    axios.post("getAllUser").then((res) => {
        if (res.code == 200) {
            isShow.value = true
            userData = res.data
            console.log(userData);
        } else {
            message.info("返回错误")
        }
    })

})
const handleSearch = (selectedKeys, confirm, dataIndex) => {
    confirm();
    state.searchText = selectedKeys[0];
    state.searchedColumn = dataIndex;
};

const handleReset = clearFilters => {
    clearFilters({ confirm: true });
    state.searchText = '';
};
// todo 聊天
const chat = (user_id) => {

}
// todo 查看文档（下载）
const inquire = (user_id, apply_filename) => {

}
// todo 变更权限
const changePermission = (user_id, permission) => {

}
</script>

<template>
    <div class="user-contain">
        <a-table :locale="zh_CN" class="user-table" v-if="isShow" :columns="columns" :data-source="userData"
            :pagination="{ position: '[bottomRight]', hideOnSinglePage: true }">
            <template #headerCell="{ column }">
                <template v-if="column.key === 'username'">
                    <span>
                        <smile-outlined />
                        用户名
                    </span>
                </template>
            </template>
            <template #customFilterDropdown="{ setSelectedKeys, selectedKeys, confirm, clearFilters, column }">
                <div style="padding: 8px">
                    <a-input ref="searchInput" :placeholder="`Search ${column.dataIndex}`" :value="selectedKeys[0]"
                        style="width: 188px; margin-bottom: 8px; display: block"
                        @change="e => setSelectedKeys(e.target.value ? [e.target.value] : [])"
                        @pressEnter="handleSearch(selectedKeys, confirm, column.dataIndex)" />
                    <a-button type="primary" size="small" style="width: 90px; margin-right: 8px"
                        @click="handleSearch(selectedKeys, confirm, column.dataIndex)">
                        <template #icon>
                            <SearchOutlined />
                        </template>
                        搜索
                    </a-button>
                    <a-button size="small" style="width: 90px" @click="handleReset(clearFilters)">
                        重置
                    </a-button>
                </div>
            </template>
            <template #customFilterIcon="{ filtered }">
                <search-outlined :style="{ color: filtered ? '#108ee9' : undefined }" />
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
                        <a @click="inquire(record.user_id, record.apply_filename)"
                            v-if="record.permission != '0'">查看申请文件</a>
                        <br>
                        <a @click="changePermission(record.user_id, 1)" v-if="record.permission == '-1'">同意申请</a>
                        <a @click="changePermission(record.user_id, 0)" v-if="record.permission == '1'">取消权限</a>
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