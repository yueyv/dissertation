<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import searchHome from '@/components/search/index.vue';
import { useRouter } from 'vue-router';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
const router = useRouter()
const jobItem = ref([])
const isShow = ref(false)
// import.meta.env.SSR?false:message.info("222")
const commendTags = [
    {
        title: "Java",
        link: "",
    },
    {
        title: "PHP",
        link: "",
    },
    {
        title: "JS",
        link: "",
    },
    {
        title: "TS",
        link: "",
    }
]
// done 到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/jobPage/${id}`)
    console.log(id);
}
onBeforeMount(() => {
    axios.post("getHomeJob").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // console.log(res.data);
            jobItem.value = res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            isShow.value = true
            // console.log(jobItem.value[0].title);
        } else {
            message.error("服务器返回错误")
        }
    }).catch((e) => {
        console.log(e);
        message.error("加载错误")
    })
})
</script>

<template>
    <myHeader :active-nav="0"></myHeader>
    <div class="advs">毕业设计火热制作中</div>
    <div style="margin-top:50px">
        <searchHome></searchHome>
        <!-- <div class="commend-tag">
            <p style="color: #9E9E9E;">热招岗位:</p>
            <p v-for="item in commendTags" class="smart-tag">{{ item.title }}</p>
        </div> -->
        <h1 class="job-title">最新岗位</h1>
        <div class="job-contain" v-if="isShow">
            <div class="job-item" v-for="item in jobItem.length" @click="moveToJobMainPage(jobItem[item - 1].job_id)">
                <a-card class="job-card" :title="jobItem[item - 1].title" :bordered="false" style="width: 20vw;height: 30vh;">
                    <p>{{ jobItem[item - 1].company_name }}</p>
                    <p>{{ jobItem[item - 1].walfare }}</p>
                    <p>{{ jobItem[item - 1].description }}</p>
                </a-card>
            </div>
        </div>
        <!-- 骨架屏 -->
        <div class="job-contain" v-if="!isShow">
            <div class="job-item">
                <a-card style="width: 20vw;height: 30vh;" >

                    <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />

                </a-card>
            </div>
            <div class="job-item">
                <a-card style="width: 20vw;height: 30vh;">
                    <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                </a-card>
            </div>
            <div class="job-item">
                <a-card style="width: 20vw;height: 30vh;">
                    <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                </a-card>
            </div>
            <div class="job-item">
                <a-card style="width: 20vw;height: 30vh;">

                    <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                </a-card>
            </div>
        </div>
    </div>

</template>

<style scoped lang='scss'>
.job-contain {
    margin-top: 5vh;
    // height: calc(100vh - 300px);
    display: grid;
    justify-items: center;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap: 10px 10px;

}
.job-title{
    font-weight: 800;
    letter-spacing: 5px;
    font-size: 40px;
    margin-top: 15vh;
    font-size: 25px;
    margin-left: 40px;
    color: rgb(227, 251, 255);
}
// / .job-item {
// //     // overflow: hidden;
    
// // }
.job-card{
    &:hover{
        box-shadow: 0px 5px 0px 0px rgba(255, 255, 255, 0.4);
        transition: all ease 0.5s;
    }
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

.commend-tag {
    font-size: 20px;
    display: flex;
    margin-left: 20vw;
}

.smart-tag {
    margin: 0px 10px;
    padding: 0px 10px;
    background-color: 06bdbc;
    color: rgba(255, 255, 255, .8);
    border-radius: 5px;

    &:hover {
        background-color: rgba(255, 255, 255, .8);
        color: black;
    }
}
</style>
