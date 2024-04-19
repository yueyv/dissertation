<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
import { useRouter } from 'vue-router';
const router = useRouter()
const isShow = ref(false)
const currentPage = ref(1);
const totalPage = ref(2)
const permission = ref(0);
const jobItem = ref([])
onBeforeMount(() => {
    axios.get("getPermission").then((res) => {
        if (res.code == 200) {
            permission.value = res.data.permission
            console.log(permission.value);
            sessionStorage.setItem("permission", JSON.stringify(res.data.permission))
        }
    }
    )
    axios.get("getApplyJob").then((res) => {
        if (res.code == 200) {
            // console.log(res);
            jobItem.value = res.data
            totalPage.value = res.data.length
            isShow.value = true
        } 
        else if (res.code == 201) {
            // console.log(res);
            jobItem.value = res.data
            totalPage.value = res.data.length
            setTimeout(() => {
                isShow.value = true
            }, 1000);
            
        } 
        else {
            console.log(res);
            message.error("服务器返回错误")
        }
    }).catch((e) => {
        console.log(e);
        message.error("加载错误")
    })
}
)

// done发送请求
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// done 从后端返回

// done 到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/jobPage/${id}`)
    console.log(id);
}
const back = () => {
    router.push("/bringInPage/myEdit")
}
const deleteJob=(job_id)=>{
   
    axios.post("deleteApplyJob",{job_id:job_id}).then((res)=>{
        if(res.code==200){
            message.success("删除成功")
            window.location.reload();
        }
    })
}
</script>

<template>
    <div class="auth" v-if="permission == 1">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">您是招聘人员</h1>
            <!-- <a-button @click="moveToApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">申请</a-button> -->
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">前往招聘页面</a-button>
        </div>
    </div>
    <myHeader :active-nav="6"></myHeader>
    <div class="advs">已投递岗位</div>
    <div class="job-contain" v-if="isShow&&permission!=1">
        <div class="job-item" v-for="item in Math.min(8, jobItem.length - (currentPage - 1) * 8)"
            @click="moveToJobMainPage(jobItem[(currentPage - 1) * 8 + item - 1].job_id)">
            <a-card class="job-card" :title="jobItem[(currentPage - 1) * 8 + item - 1].title" :bordered="false"
                style="width: 20vw;height: 30vh;">
                <a-button type="primary" danger ghost style="left: 60%;" @click.stop="deleteJob(jobItem[(currentPage - 1) * 8 + item - 1].job_id)">删除</a-button>
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].company_name }}</p>
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].walfare }}</p>
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].description }}</p>
            </a-card>
        </div>
    </div>
    <div class="job-contain" v-if="!isShow||permission == 1">
        <div class="job-item" v-for="item in 8">
            <a-card style="width: 20vw;height: 30vh;">
                <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
            </a-card>
        </div>
    </div>
    <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :defaultPageSize="8" :hideOnSinglePage="true"
            :showSizeChanger="false" :total="totalPage" @change="onChange" />
        <br />
    </div>
</template>

<style scoped lang='scss'>
.job-card{
    &:hover{
        box-shadow: 0px 5px 0px 0px rgba(255, 255, 255, 0.4);
        transition: all ease 0.5s;
    }
}
.auth {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: #00000057;
    z-index: 99;
    .auth-box {
        font-size: 30px;
        background-color: rgba(240, 248, 255, 0.76);
        width: 20vw;
        height: 20vw;
        display: flex;
        justify-items: center;
        flex-direction: column;
        align-items: center;
        border-radius: 30px;
        position: fixed;
        left: 50%;
        top: 40%;
        transform: translate(-50%, -50%);
        ;
    }
}

.job-contain {
    margin-top: 20px;
    height: calc(100vh - 300px);
    display: grid;
    justify-items: center;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap: 10px 10px;

}

.job-item {
    overflow: hidden;
}

.pagination-box {
    position: fixed;
    left: 50%;
    bottom: 10px;
    transform: translate(-50%, 0);
    ;
}

.advs {
    font-weight: 800;
    color: white;
    letter-spacing: 5px;
    line-height: 180px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 200px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
</style>
