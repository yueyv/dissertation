<script setup>
import { ref, reactive } from 'vue'
import myHeader from '../components/header/header.vue';
import search from '../components/search/index.vue'
import { router } from "../router/index";
const currentPage = ref(1);
const totalPage = 90
// TODO 发送请求
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// TODO 从后端返回
const jobItem = [
    {
        id: 1
    }
]
// TODO 到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/jobPage/${id}`)
    console.log(id);
}
// todo 筛选
const city = ref("所有城市");
const jobKind = ref('所有职位');
const salary = ref('薪资范围不限');
const character=ref("工作性质不限")
const cityOptions = ref([
    {
        value: 'jack',
        label: 'Jack',
    },
    {
        value: 'lucy',
        label: 'Lucy',
    },
    {
        value: 'disabled',
        label: 'Disabled',
        disabled: true,
    },
    {
        value: 'yiminghe',
        label: 'Yiminghe',
    },
]);
const jobKindOptions = ref([
    {
        value: 'lucy',
        label: 'Lucy',
    },
]);
const salaryOptions = ref([
    {
        value: 'lucy',
        label: 'Lucy',
    },
]);
const characterOptions = ref([
    {
        value: 'lucy',
        label: 'Lucy',
    },
]);
// IM更改条件
const handleChange = (value) => {
    console.log(`selected ${value}`);
};
</script>

<template>
    <myHeader :active-nav="2"></myHeader>
    <div class="advs">检索岗位</div>
    <div style="margin-top:50px">
        <search></search>
        <div class="sift-box">
            <a-select ref="select" v-model:value="city" style="width: 15vw;font-size: 20px;" :options="cityOptions"
                @change="handleChange"></a-select>
            <a-select v-model:value="jobKind" style="width: 15vw;font-size: 20px;"  :options="jobKindOptions" @change="handleChange"></a-select>
            <a-select v-model:value="salary" style="width: 15vw;font-size: 20px;"  :options="salaryOptions" @change="handleChange"></a-select>
            <a-select v-model:value="character" style="width: 15vw;font-size: 20px;"  :options="characterOptions" @change="handleChange"></a-select>
        </div>
    </div>
    <div class="job-contain">
        <div class="job-item" v-for="item in 4" @click="moveToJobMainPage(currentPage * 8 + item)">
            <a-card :title="currentPage * 8 + item" :bordered="false" style="width: 20vw;height: 30vh;">
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
.sift-box {
    justify-items: center;
    align-items: center;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    border-radius: 20px;
    background-color: #e7cbc8;
    margin-left: 20px;
    width: calc(100vw - 40px);
    height: 50px;
}

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
}
</style>