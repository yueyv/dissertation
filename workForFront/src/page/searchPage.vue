<script setup>
import { ref, reactive, onMounted, watch } from 'vue'
import myHeader from '../components/header/header.vue';
import search from '@/components/search/index.vue';
import axios from '@/plugins/axiosBase';
import { message } from 'ant-design-vue';
import { useRoute, useRouter } from 'vue-router';
const router = useRouter()
const route = useRoute()
// console.log(route.query);
const currentPage = ref(1)
const jobItem = ref([])
let allJob = []
const totalPage = ref(2)
const isShow = ref(false)
const onChange = (pageNumber) => {
    console.log('Page: ', pageNumber);
};
// done 从后端返回
onMounted(() => {
    if (JSON.stringify(route.query) === '{}') {
        axios.post('getAllJob').then((res) => {
            // console.log(res);
            if (res.code == 200) {
                allJob = res.data
                console.log(allJob);
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
    } else {
        // console.log(JSON.stringify(route.query));
        axios.post('searchJob', route.query).then((res) => {
            if (res.code == 200) {
                console.log(res.data);
                jobItem.value = res.data
                totalPage.value = res.data.length
                isShow.value = true
                if(!res.data.length){
                    message.info("找不到")
                }
            }
            else{
                message.error("服务器错误")
            }
        }).catch((e) => {
            console.log(e);
            message.error("加载错误")
        })
    }

})
// done到详情页面
const moveToJobMainPage = (id) => {
    router.push(`/jobPage/${id}`)
    console.log(id);
}
// done 筛选
const city = ref("所有城市");
const jobKind = ref('所有职位');
const salary = ref('薪资范围不限');
const character = ref("工作性质不限")
const cityOptions = ref([
    {
        value: '上海',
        label: '上海',
    },
    {
        value: '南京',
        label: '南京',
    },
    {
        value: '北京',
        label: '北京',
    },
    {
        value: '所有城市',
        label: '所有城市',
    }
]);
const jobKindOptions = ref([
    {
        value: '销售',
        label: '销售',
    },
    {
        value: '软件',
        label: '软件',
    },
    {
        value: '财务',
        label: '财务',
    },
    {
        value: '所有职位',
        label: '所有职位',
    }
]);
const salaryOptions = ref([
    {
        value: '0',
        label: '5k以下',
    },
    {
        value: '1',
        label: '5-8k',
    },
    {
        value: '2',
        label: '8-15k',
    },
    {
        value: '3',
        label: '15k以上',
    },
    {
        value: '4',
        label: '面谈',
    },{
        value: '薪资范围不限',
        label: '薪资范围不限',
    }
]);
const characterOptions = ref([
    {
        value: '0',
        label: '全职',
    },
    {
        value: '1',
        label: '劳务派遣',
    },
    {
        value: '2',
        label: '兼职',
    },
    {
        value: '工作性质不限',
        label: '工作性质不限',
    }
]);
// IM更改条件
const handleChange = (value) => {
    console.log(`selected ${value}`);
};
// 监听筛选
const watchTargets = [city, jobKind, salary, character];
watch(watchTargets, () => {
    let watchItem = []
    if (city.value == "所有城市") {
        watchItem.push('-1')
    } else {
        watchItem.push(city.value)
    }
    if (jobKind.value == '所有职位') {
        watchItem.push('-1')
    } else {
        watchItem.push(jobKind.value)
    }
    if (salary.value == '薪资范围不限') {
        watchItem.push('-1')
    } else {
        watchItem.push(salary.value)
    }
    if (character.value == "工作性质不限") {
        watchItem.push('-1')
    } else {
        watchItem.push(character.value)
    }
    // console.log(watchItem);
    // IM 过滤筛选
    jobItem.value = allJob.filter((item) => {
        if ((item.city == watchItem[0] || watchItem[0] == '-1') && (item.title.includes(watchItem[1]) || watchItem[1] == '-1') && (item.salary_range == watchItem[2] || watchItem[2] == '-1') && (item.job_info == watchItem[3] || watchItem[3] == '-1')) {
            return true
        }
        // console.log(item);
    })
    console.log(jobItem.value);
    totalPage.value = jobItem.value.length
    // console.log( totalPage.value);
    if (totalPage.value == undefined) {
        message.info("找不到")
    }
})
</script>

<template>
    <myHeader :active-nav="2"></myHeader>
    <div class="advs">检索岗位</div>
    <div style="margin-top:50px">
        <search></search>
        <div class="sift-box">
            <a-select ref="select" v-model:value="city" style="width: 15vw;font-size: 20px;" :options="cityOptions"
                @change="handleChange"></a-select>
            <a-select v-model:value="jobKind" style="width: 15vw;font-size: 20px;" :options="jobKindOptions"
                @change="handleChange"></a-select>
            <a-select v-model:value="salary" style="width: 15vw;font-size: 20px;" :options="salaryOptions"
                @change="handleChange"></a-select>
            <a-select v-model:value="character" style="width: 15vw;font-size: 20px;" :options="characterOptions"
                @change="handleChange"></a-select>
        </div>
    </div>
    <div class="job-contain" v-if="isShow">
        <div class="job-item" v-for="item in Math.min(4, jobItem.length - (currentPage - 1) * 4)"
            @click="moveToJobMainPage(jobItem[(currentPage - 1) * 4 + item - 1].job_id)">
            <a-card class="job-card" :title="jobItem[(currentPage - 1) * 4 + item - 1].title" :bordered="false"
                style="width: 20vw;height: 30vh;">
                <p v-if="jobItem[(currentPage - 1) * 4 + item - 1].vaild == '0'" style="color: red;font-size: 20px;">
                    未通过审核</p>
                <p>{{ jobItem[(currentPage - 1) * 4 + item - 1].company_name }}</p>
                <p>{{ jobItem[(currentPage - 1) * 4 + item - 1].walfare }}</p>
                <p>{{ jobItem[(currentPage - 1) * 4 + item - 1].description }}</p>
            </a-card>
        </div>
    </div>
    <div class="job-contain" v-if="!isShow">
        <div class="job-item" v-for="item in 4">
            <a-card style="width: 20vw;height: 30vh;">
                <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
            </a-card>
        </div>
    </div>
    <div class="pagination-box">
        <a-pagination v-model:current="currentPage" :hideOnSinglePage="true" :defaultPageSize="4"
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
    &:hover{
        box-shadow: 0px 5px 0px 0px rgba(255, 255, 255, 0.4);
        transition: all ease 0.5s;
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