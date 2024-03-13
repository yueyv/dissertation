<script setup>
import { ref, reactive, onMounted } from 'vue'
import myHeader from '@/components/header/header.vue';
import axios from '../plugins/axiosBase.js';
import { useRoute, useRouter } from 'vue-router';
import { message } from 'ant-design-vue';
const router = useRouter()
const route = useRoute()
const isShow = ref(false)
const formState = reactive([{
    title: '',
    company_name: '',
    city: undefined,
    salary_range: undefined,
    job_info: undefined,
    description: '',
    walfare: '',
}]);
console.log(route.params.id);
onMounted(() => {
    axios.post("getJobInfo", { job_id: route.params.id }).then((res) => {
        if (res.code == 200) {
            isShow.value = true
            formState.value = [...res.data]
            console.log(formState.value[0]);
        }

    }).catch((e) => {
        message.error("加载错误")
        console.log(e);
    })
})
// Todo跳转聊天 明天做
const clickButton = () => {
    const permission=JSON.parse(sessionStorage.getItem("permission"))
    if(permission==1){
        message.error("您是招聘人员")
    }
    if(permission==0){
        console.log(formState);
        
        axios.post("addChatAndJob",{user_id:formState.value[0].user_id,job_id:formState.value[0].job_id}).then((res)=>{
            message.success("已申请，前往聊天中")
            router.push('/chatPage')
        }).catch((e)=>{
            console.log(e);
            message.error("服务器出错")
        })
    }
    if(permission==null){
        message.error("请先登录")
    }
}
</script>

<template>
    <myHeader :active-nav="6"></myHeader>
    <div class="advs">
        <p style="padding-top: 40px;" v-if="!isShow">加载中</p>
        <!-- 传参 -->
        <p style="padding-top: 10px; font-size: 20px;" v-if="!isShow">加载中</p>
        <p style="padding-top: 40px;" v-if="isShow">{{formState.value[0].title}}</p>
        <!-- 传参 -->
        <p style="padding-top: 10px; font-size: 20px;" v-if="isShow">{{formState.value[0].city}}</p>
        <a-space style="">
            <a-button type="primary" ghost @click="clickButton">立刻沟通</a-button>
        </a-space>

    </div>
    <div class="job-content" v-if="isShow">
        <div class="job_title" style="padding-top: 40px;font-size: 1.5rem;">{{formState.value[0].title}}</div>
        <a-descriptions class="job-container"  :labelStyle="{ fontSize: '1.2rem' }" :contentStyle="{ fontSize: '1.2rem' }"   :column="2">
            <a-descriptions-item label="公司名称">{{formState.value[0].company_name}}</a-descriptions-item>
            <a-descriptions-item label="城市">{{formState.value[0].city}}</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-if="formState.value[0].salary_range==0">5k以下</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range==1">5-8k</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range==2">8-15k</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range==3">15k以上</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range==4">面谈</a-descriptions-item>
            <a-descriptions-item label="工作性质" v-if="formState.value[0].job_info=='0'">
                全职
            </a-descriptions-item>
            <a-descriptions-item label="工作性质" v-else-if="formState.value[0].job_info=='1'">
                劳务派遣
            </a-descriptions-item>
            <a-descriptions-item label="工作性质" v-else-if="formState.value[0].job_info=='2'">
                兼职
            </a-descriptions-item>
            <a-descriptions-item  label="工作信息" :span="2">{{formState.value[0].description}}</a-descriptions-item>
            <a-descriptions-item  label="工作福利" :span="2">{{formState.value[0].walfare}}</a-descriptions-item>
        </a-descriptions>
    </div>
</template>

<style scoped lang='scss'>

.advs {
    font-weight: 800;
    color: white;
    letter-spacing: 5px;
    line-height: 40px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 200px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}

.job-content {
    overflow: scroll;
    text-align: center;
    margin-top: 5vh;
    
    background-color: rgba(255, 255, 255, 0.61);
    height: 60vh;
    width: 80vw;
    margin-left: 10vw;
    border-radius: 20px;

    &::-webkit-scrollbar {
        display: none;
    }
}
.job-container{
    font-size: 1.5rem;
    padding: 30px 20px;
}


.job-detail {
    margin-left: 80px;
    padding-top: 40px;
    width: calc(80vw - 160px);
    line-height: 1.5rem;
    font-size: 1.2rem;
}
</style>
