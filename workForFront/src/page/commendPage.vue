<script setup>
import { ref, reactive, onMounted } from 'vue'
import myHeader from '../components/header/header.vue';
import { useRouter } from 'vue-router';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
const router = useRouter()
const currentPage = ref(1)
const jobItem = ref([])
const totalPage = ref(2)
const isShow = ref(false)
// done 发送请求
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// done 从后端返回
const pullJob=()=>{
    axios.post('getCommendJob').then((res) => {
        // console.log(res);
        if (res.code == 200) {
            console.log(res.data);
            jobItem.value = res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            totalPage.value = res.data.length
            isShow.value = true
            // console.log(jobItem.value[0].title);
        } else {
            message.error("服务器返回错误")
        }
    }).catch((e) => {
        console.log(e);
        message.error("加载错误")
    })
}
onMounted(() => {
   pullJob()
})
// done 到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/jobPage/${id}`)
    console.log(id);
}
</script>
<!--  -->
<template>
    <myHeader :active-nav="1"></myHeader>
    <div class="advs">
        热招岗位
        <!-- <p style="margin-top: 80px;"></p> -->
        <br>
        <a-space style="">
            <a-button type="primary" ghost @click="pullJob()">重新推荐</a-button>
        </a-space>
    </div>
    <div class="job-contain" v-if="isShow">
        <div class="job-item" v-for="item in Math.min(8, jobItem.length - (currentPage - 1) * 8)"
            @click="moveToJobMainPage(jobItem[(currentPage - 1) * 8 + item - 1].job_id)">
            <a-card class="job-card" :title="jobItem[(currentPage - 1) * 8 + item - 1].title" :bordered="false"
                style="width: 20vw;height: 30vh;">
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].company_name }}</p>
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].walfare }}</p>
                <p>{{ jobItem[(currentPage - 1) * 8 + item - 1].description }}</p>
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
    <!-- <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :defaultPageSize="8" :hideOnSinglePage="true"
            :showSizeChanger="false" :total="totalPage" @change="onChange" />
        <br />
    </div> -->
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

.advs {
    padding-top: 40px;
    font-weight: 800;
    color: white;
    letter-spacing: 5px;
    line-height: 60px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 160px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
</style>
