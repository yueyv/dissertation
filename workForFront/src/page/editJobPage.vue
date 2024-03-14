<script setup>
import { ref, reactive, onMounted } from 'vue'
import myHeader from '@/components/header/header.vue';
import axios from '../plugins/axiosBase.js';
import { useRoute, useRouter } from 'vue-router';
import { message } from 'ant-design-vue';

const router = useRouter()
const route = useRoute()
const isShow = ref(false)
const applicant=ref()
const formState = reactive({
    title: '',
    company_name: '',
    city: undefined,
    salary_range: undefined,
    job_info: undefined,
    description: '',
    walfare: '',
});
console.log(route.params.id);
onMounted(() => {
    axios.post("getJobInfo", { job_id: route.params.id }).then((res) => {
        // console.log(res);
        if (res.code == 200) {
            isShow.value = true
            formState.value = [...res.data]
            applicant.value=res.applicant
            console.log(applicant.value);
        }

    }).catch((e) => {
        message.error("加载错误")
        console.log(e);
    })
})
// TODO跳转聊天
const clickButton = () => {

}
const open = ref(false)
const deleteJob = () => {
    open.value = true
}
const handleOk = () => {
    axios.post("deleteJob", { job_id: formState.value[0].job_id,user_id: formState.value[0].user_id }).then((res) => {
        if (res.code == 200) {
            message.success("删除成功")
            router.push("/bringInPage/myEdit")
        }else{
            message.error("服务器错误")
        }

    }).catch((e)=>{
        console.log(e);
        message.error("删除错误")
    })

}
const applicants = ref(false)
const openApplicants = () => {
    applicants.value = true
}
const handleApplicants = () => {
    applicants.value = false
}
const moveToApplicatPage = (id) => {
    router.push(`/applicantPage/${id}`)
}
// done 删除
const deleteApplicant=(applicant_id)=>{
    axios.post('deleteApplicant',{job_id:formState.value[0].job_id,applicant_id:applicant_id}).then(
        (res)=>{
            if(res.code==200){
                applicant.value=applicant.value.filter(item=>item.user_id!=applicant_id)
                message.success("删除成功")
            }else{
                message.error("删除失败")
            }
        }
    )
}
</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="advs">
        <p style="padding-top: 40px;" v-if="!isShow">加载中</p>
        <!-- 传参 -->
        <p style="padding-top: 10px; font-size: 20px;" v-if="!isShow">加载中</p>
        <p style="padding-top: 40px;" v-if="isShow">{{ formState.value[0].title }}</p>
        <!-- 传参 -->
        <p style="padding-top: 10px; font-size: 20px;" v-if="isShow">{{ formState.value[0].city }}</p>
        <a-space style="">
            <a-button type="primary" ghost @click="openApplicants()">查看申请者</a-button>
            <a-modal cancelText="取消" okText="确认" v-model:open="applicants" title="申请者" @ok="handleApplicants()">
                <a-space direction="vertical" style="display: flex;justify-content: center;align-items: center;">
                    <div v-if="!formState.value[0].applicant_id">
                        不存在
                    </div>
                    <div v-else-if="formState.value[0].applicant_id">
                        <!-- done -->
                        <div v-for="(item,key) in applicant" >
                            <a-button style=" margin-right: 40px;padding-bottom: 10px;" @click="moveToApplicatPage(item.user_id)">{{item.username }}</a-button>
                            <a-button style=" margin-right: 40px;padding-bottom: 10px; float: right;" danger @click="deleteApplicant(item.user_id)">删除</a-button>
                        </div>     
                    </div>
                </a-space>
            </a-modal>
            <a-button type="primary" danger @click="deleteJob()">删除这个招聘</a-button>
            <a-modal cancelText="取消" okText="确认" v-model:open="open" title="删除招聘" @ok="handleOk">
                <a-space direction="vertical">
                    请确认删除
                </a-space>
            </a-modal>

        </a-space>

    </div>
    <div class="job-content" v-if="isShow">
        <div class="job_title" style="padding-top: 40px;font-size: 1.5rem;">{{ formState.value[0].title }}</div>
        <a-descriptions class="job-container" :labelStyle="{ fontSize: '1.2rem' }"
            :contentStyle="{ fontSize: '1.2rem' }" :column="2">
            <a-descriptions-item label="公司名称">{{ formState.value[0].company_name }}</a-descriptions-item>
            <a-descriptions-item label="城市">{{ formState.value[0].city }}</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-if="formState.value[0].salary_range == 0">5k以下</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range == 1">5-8k</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range == 2">8-15k</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range == 3">15k以上</a-descriptions-item>
            <a-descriptions-item label="薪资范围" v-else-if="formState.value[0].salary_range == 4">面谈</a-descriptions-item>
            <a-descriptions-item label="工作性质" v-if="formState.value[0].job_info == '0'">
                全职
            </a-descriptions-item>
            <a-descriptions-item label="工作性质" v-else-if="formState.value[0].job_info == '1'">
                劳务派遣
            </a-descriptions-item>
            <a-descriptions-item label="工作性质" v-else-if="formState.value[0].job_info == '2'">
                兼职
            </a-descriptions-item>
            <a-descriptions-item label="工作信息" :span="2">{{ formState.value[0].description }}</a-descriptions-item>
            <a-descriptions-item label="工作福利" :span="2">{{ formState.value[0].walfare }}</a-descriptions-item>
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

.job-container {
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
