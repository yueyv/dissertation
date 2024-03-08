<script setup>
import { ref, reactive,onMounted } from 'vue'
import myHeader from '../components/header/header.vue';
import search from '@/components/search/index.vue';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
import { useRouter } from 'vue-router';
const router = useRouter()
const currentPage=ref(1)
const jobItem=ref([])
const totalPage = ref(2)
const isShow=ref(false)
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// TODO 从后端返回
onMounted(() => {
    axios.post('getAllJob').then((res)=>{
        // console.log(res);
        if(res.code==200){
            console.log(res.data);
            jobItem.value=res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            totalPage.value=res.data.length
            isShow.value=true
            // console.log(jobItem.value[0].title);
        }else{
            message.error("服务器返回错误")
        }
    }).catch((e)=>{
        console.log(e);
        message.error("加载错误")
    })
})
// TODO 到详情页面
const moveToJobMainPage=(id)=>{
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
    <div class="job-contain" v-if="isShow">
        <div class="job-item" v-for="item in Math.min(4, jobItem.length - (currentPage-1) * 4)" @click="moveToJobMainPage(jobItem[(currentPage-1) * 4 + item-1].job_id)">
            <a-card :title="jobItem[(currentPage-1) * 4 + item-1].title" :bordered="false" style="width: 20vw;height: 30vh;">
                <p v-if="jobItem[(currentPage-1) * 4 + item-1].vaild=='0'" style="color: red;font-size: 20px;">未通过审核</p>
                <p>{{jobItem[(currentPage-1) * 4 + item-1].company_name}}</p>
                <p>{{jobItem[(currentPage-1) * 4 + item-1].walfare}}</p>
                <p>{{jobItem[(currentPage-1) * 4 + item-1].description}}</p>
            </a-card>
        </div>
    </div>
    <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :hideOnSinglePage="true" :defaultPageSize="4" :showSizeChanger="false" :total="totalPage"
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