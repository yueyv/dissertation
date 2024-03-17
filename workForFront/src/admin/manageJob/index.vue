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
        title: '职位序号',
        dataIndex: 'job_id',
        key: 'job_id',
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
        title: '状态',
        dataIndex: 'vaild',
        key: 'vaild',
        filters: [
            {
                text: '申请中',
                value: 0,
            }, {
                text: '已通过',
                value: 1,
            }, {
                text: '申请失败',
                value: -1,
            },

        ],
        filterMode: 'tree',
        onFilter: (value, userData) => userData.vaild == value,
    },{
        title: '申请者',
        key: 'user_id',
        dataIndex: 'user_id',
    },
    {
        title: '职位名称',
        key: 'title',
        dataIndex: 'title',
    },
    {
        title: '城市',
        dataIndex: 'city',
        key: 'city',
    },
    {
        title: '公司名称',
        dataIndex: 'company_name',
        key: 'company_name',
    },
    {
        title: '描述',
        key: 'description',
        dataIndex: 'description',
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
    axios.post("getAllJobAdmin").then((res) => {
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
const chat = (user_id) => {
    axios.post("adminChatTo", { to_id: user_id }).then((res) => {
        if (res.code == 200) {
            message.info("跳转聊天")
            nav_choosed(2)
        } else {
            message.info("服务器错误")
        }
    })
}
const emit = defineEmits(['nav_choose'])
function nav_choosed(key) {
    emit('nav_choose', key)
}

// todo 变更权限
const changevaild = (job_id, vaild) => {
    axios.post("changevaild", { job_id: job_id, vaild: vaild }).then((res) => {
        console.log(res);
        if (res.code == 200) {
            message.info("更改成功，请刷新")
        } else {
            message.info("服务器错误")
        }
    })
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
                <template v-else-if="column.key === 'vaild'">
                    <span>
                        <a-tag
                            :color="record.vaild == '0' ? 'volcano' : record.vaild == '1' ? 'geekblue' : 'green'">
                            {{ record.vaild == '0' ? '申请中' : record.vaild == '1' ? '已通过' : '申请失败' }}
                        </a-tag>
                    </span>
                </template>
                <template v-else-if="column.key === 'action'">
                    <span>
                        <a @click="chat(record.user_id)">聊天</a>
                        &nbsp;
                        <br>
                        <a @click="changevaild(record.job_id, 1)">同意申请</a>
                        &nbsp;
                        <a @click="changevaild(record.job_id, -1)">拒绝申请</a>
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
    margin-top: 2vh;
    margin-left: 10vw;
    width: 80vw;
    height: 80vh;
    background-color: rgba(255, 255, 255, 0.589);
}
</style>