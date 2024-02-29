<script setup>
import { ref, reactive } from 'vue'
import myHeader from '../components/header/header.vue';
import { router } from "../router/index";
const currentPage = ref(1);
const totalPage = 90
// TODO 发送请求
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// TODO 从后端返回
const jobItem=[
    {
        id:1
    }
]
// TODO 到详情页面
const moveToJobMainPage=(id)=>{
    router.push(`/jobPage/${id}`)
    console.log(id);
}
</script>
<!--  -->
<template>
    <myHeader :active-nav="1"></myHeader>
    <div class="advs">热招岗位</div>
    <div class="job-contain">
        <div class="job-item" v-for="item in 8" @click="moveToJobMainPage(currentPage*8+item)">
            <a-card :title="currentPage*8+item" :bordered="false" style="width: 20vw;height: 30vh;">
                <p>Card content</p>
                <p>Card content</p>
            </a-card>
        </div>
    </div>
    <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :defaultPageSize="8" :showSizeChanger="false" :total="totalPage"
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

// .job-item {}

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
}</style>
