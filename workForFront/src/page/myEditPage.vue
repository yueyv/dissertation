<script setup>
import { ref, reactive, onBeforeMount, toRaw,onMounted } from 'vue'
import myHeader from '@/components/header/header.vue';
import { useRouter } from 'vue-router'
import axios from '@/plugins/axiosBase.js';
import { message } from 'ant-design-vue';
const router = useRouter()
const permission = ref(1);
const currentPage=ref(1)
const jobItem=ref([])
const totalPage = ref(2)
const isShow=ref(false)
onBeforeMount(() => {
    axios.get("getPermission").then((res) => {
        if (res.code == 200) {
            permission.value = res.data.permission
            // console.log(permission.value);
            sessionStorage.setItem("permission", JSON.stringify(res.data.permission))
        }
    }
    )
})
onMounted(() => {
    axios.post('getMyEditJob').then((res)=>{
        if(res.code==200){
            // console.log(res.data);
            jobItem.value=res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            totalPage.value=res.data.length
            isShow.value=true
            // console.log(jobItem.value[0].title);

        }else{
            message.error("权限不足")
            setTimeout(() => {
                isShow.value=true
            }, 1000);
            // message.error("服务器返回错误")
        }
    }).catch((e)=>{
        console.log(e);
        message.error("加载错误")
    })
})
const back = () => {
    router.back()
}
const moveToApply = () => {
    router.push('/bringInPage/apply')
}
const moveToBringIn = () => {
    router.push('/bringInPage')
}


// DONE 发送请求
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// done 到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/editJobPage/${id}`)
    console.log(id);
}


</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="auth" v-show="permission == 0">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">权限不足</h1>
            <a-button @click="moveToApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">申请</a-button>
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">返回</a-button>
        </div>
    </div>
    <div class="advs">管理我的招聘
        <br>
        <a-button type="primary" @click="moveToBringIn()" ghost>前往招聘详情</a-button>
    </div>
    <div class="job-contain" v-if="isShow">
        <div class="job-item" v-for="item in Math.min(8, jobItem.length - (currentPage-1) * 8)" @click="moveToJobMainPage(jobItem[(currentPage-1) * 8 + item-1].job_id)">
            <a-card class="job-card" :title="jobItem[(currentPage-1) * 8 + item-1].title" :bordered="false" style="width: 20vw;height: 30vh;">
                <p v-if="jobItem[(currentPage-1) * 8 + item-1].vaild=='0'" style="color: red;font-size: 20px;">审核中</p>
                <p v-if="jobItem[(currentPage-1) * 8 + item-1].vaild=='-1'" style="color: red;font-size: 20px;">未通过审核</p>
                <p>{{jobItem[(currentPage-1) * 8 + item-1].company_name}}</p>
                <p>{{jobItem[(currentPage-1) * 8 + item-1].walfare}}</p>
                <p>{{jobItem[(currentPage-1) * 8 + item-1].description}}</p>
            </a-card>
        </div>
    </div>
    <div class="job-contain" v-if="!isShow">
        <div class="job-item" v-for="item in 8">
            <a-card style="width: 20vw;height: 30vh;">
                <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
            </a-card>
        </div>
    </div>
    <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :defaultPageSize="8"  :hideOnSinglePage="true" :showSizeChanger="false" :total="totalPage"
            @change="onChange" />
        <br />
    </div>
</template>

<style scoped lang='scss'>
.job-contain {
    margin-top: 20px;
    height: calc(100vh - 300px);
    display: grid;
    justify-items: center;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap: 10px 10px;

}
.job-card{
    &:hover{
        box-shadow: 0px 5px 0px 0px rgba(255, 255, 255, 0.4);
        transition: all ease 0.5s;
    }
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



.advs {
    font-weight: 800;
    color: white;
    padding-top: 70px;
    letter-spacing: 5px;
    line-height: 40px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 130px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
</style>
