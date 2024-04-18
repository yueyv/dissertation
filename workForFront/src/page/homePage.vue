<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import searchHome from '@/components/search/index.vue';
import homeNav from '@/components/nav/homeNav.vue';
import { useRouter } from 'vue-router';
import axios from '@/plugins/axiosBase';
import { LeftCircleOutlined, RightCircleOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';
import { useIPStore } from '../store/index'
import { storeToRefs } from 'pinia'
// import { getCity, getIP } from '../../hooks/useGetCity'
const router = useRouter()
const jobItem = ref([])
const jobItem2 = ref([])
const jobItem3 = ref([])
const jobItem4 = ref([])
const isShow = ref(false)
const isShow2 = ref(false)
const isShow3 = ref(false)
const isShow4 = ref(false)
const ipStore = useIPStore()
const { city } = storeToRefs(ipStore)


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
    axios.post("getHomeJob4").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // console.log(res.data);
            jobItem4.value = res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            isShow4.value = true
            // console.log(jobItem.value[0].title);
        } else {
            message.error("服务器返回错误")
        }
    }).catch((e) => {
        console.log(e);
        message.error("加载错误")
    })
    axios.post("getHomeJob2").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // console.log(res.data);
            jobItem2.value = res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            isShow2.value = true
            // console.log(jobItem.value[0].title);
        } else {
            message.error("服务器返回错误")
        }
    }).catch((e) => {
        console.log(e);
        message.error("加载错误")
    })
    axios.post("getHomeJob3").then((res) => {
        // console.log(res);
        if (res.code == 200) {
            // console.log(res.data);
            jobItem3.value = res.data
            // console.log(Array.isArray(jobItem.value) && jobItem.value.length !== 0);
            isShow3.value = true
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
    <el-backtop :right="100" :bottom="100" />
    <myHeader :active-nav="0"></myHeader>

    <a-carousel arrows autoplay>
        <template #prevArrow>
            <div class="custom-slick-arrow" style="left: 10px; z-index: 1">
                <left-circle-outlined />
            </div>
        </template>
        <template #nextArrow>
            <div class="custom-slick-arrow" style="right: 10px">
                <right-circle-outlined />
            </div>
        </template>
        <div class="advs bg1">
            <div>
                <h3>春季招聘火热进行中</h3>
            </div>
        </div>
        <div class="advs bg2">
            <div>
                <h3>热门活动进行中</h3>
            </div>
        </div>
        <div class="advs bg3">
            <div>
                <h3>这是一个毕设设计</h3>
            </div>
        </div>
        <div class="advs bg4">
            <div>
                <h3>广告位招租</h3>
            </div>
        </div>
    </a-carousel>

    <div style="margin-top:50px">
        <searchHome></searchHome>
        <!-- <div class="commend-tag">
            <p style="color: #9E9E9E;">热招岗位:</p>
            <p v-for="item in commendTags" class="smart-tag">{{ item.title }}</p>
        </div> -->
        <homeNav></homeNav>
        <h1 class="session-title">岗位在招</h1>
        <div>


            <a href="/searchPage" style="text-decoration: none;">
                <h1 class="job-title">
                    热门招聘
                </h1>
            </a>


            <div class="job-contain" v-if="isShow">
                <div class="job-item" v-for="item in jobItem.length"
                    @click="moveToJobMainPage(jobItem[item - 1].job_id)">
                    <a-card class="job-card" :title="jobItem[item - 1].title" :bordered="false"
                        style="width: 20vw;height: 30vh;">
                        <p>{{ jobItem[item - 1].company_name }}</p>
                        <p>{{ jobItem[item - 1].walfare }}</p>
                        <p>{{ jobItem[item - 1].description }}</p>
                    </a-card>
                </div>
            </div>
            <!-- 骨架屏 -->
            <div class="job-contain" v-if="!isShow">
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
                <div class="job-item">
                    <a-card style="width: 20vw;height: 30vh;">

                        <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                    </a-card>
                </div>
            </div>
        </div>
        <div>

            <a href="/searchPage" style="text-decoration: none;">
                <h1 class="job-title">
                    全职招聘
                </h1>
            </a>
            <div class="job-contain" v-if="isShow">
                <div class="job-item" v-for="item in jobItem2.length"
                    @click="moveToJobMainPage(jobItem2[item - 1].job_id)">
                    <a-card class="job-card" :title="jobItem2[item - 1].title" :bordered="false"
                        style="width: 20vw;height: 30vh;">
                        <p>{{ jobItem2[item - 1].company_name }}</p>
                        <p>{{ jobItem2[item - 1].walfare }}</p>
                        <p>{{ jobItem2[item - 1].description }}</p>
                    </a-card>
                </div>
            </div>
            <!-- 骨架屏 -->
            <div class="job-contain" v-if="!isShow">
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
                <div class="job-item">
                    <a-card style="width: 20vw;height: 30vh;">

                        <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                    </a-card>
                </div>
            </div>
        </div>
        <div>
            <a href="/searchPage" style="text-decoration: none;">
                <h1 class="job-title">
                    兼职招聘
                </h1>
            </a>

            <div class="job-contain" v-if="isShow">
                <div class="job-item" v-for="item in jobItem3.length"
                    @click="moveToJobMainPage(jobItem3[item - 1].job_id)">
                    <a-card class="job-card" :title="jobItem3[item - 1].title" :bordered="false"
                        style="width: 20vw;height: 30vh;">
                        <p>{{ jobItem3[item - 1].company_name }}</p>
                        <p>{{ jobItem3[item - 1].walfare }}</p>
                        <p>{{ jobItem3[item - 1].description }}</p>
                    </a-card>
                </div>
            </div>
            <!-- 骨架屏 -->
            <div class="job-contain" v-if="!isShow2">
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
                <div class="job-item">
                    <a-card style="width: 20vw;height: 30vh;">

                        <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                    </a-card>
                </div>
            </div>
        </div>
        <div>
            <a href="/searchPage" style="text-decoration: none;">
                <h1 class="job-title">
                    {{city}}招聘
                </h1>
            </a>
            <div class="job-contain" v-if="isShow3">
                <div class="job-item" v-for="item in jobItem.length"
                    @click="moveToJobMainPage(jobItem4[item - 1].job_id)">
                    <a-card class="job-card" :title="jobItem4[item - 1].title" :bordered="false"
                        style="width: 20vw;height: 30vh;">
                        <p>{{ jobItem4[item - 1].company_name }}</p>
                        <p>{{ jobItem4[item - 1].walfare }}</p>
                        <p>{{ jobItem4[item - 1].description }}</p>
                    </a-card>
                </div>
            </div>
            <!-- 骨架屏 -->
            <div class="job-contain" v-if="!isShow4">
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
                <div class="job-item">
                    <a-card style="width: 20vw;height: 30vh;">

                        <a-skeleton :loading="true" active :paragraph="{ rows: 4 }" />
                    </a-card>
                </div>
            </div>
        </div>
    </div>
    <h1 class="session-title">热门企业</h1>
    <div class="company">
        <div class="company-item">
            <el-card style="width: 100%;height: 100%;border-radius: 20px;text-align: center;">
                <template #header>
                    <div class="card-header">
                        <span>XXX有限公司</span>
                    </div>
                </template>
                <p v-for="o in 10" :key="o" class="text item">{{ 'List item ' + o }}</p>
                <template #footer>
                    <a-button ghost type="primary">立刻联系</a-button>
                </template>
            </el-card>
        </div>
        <div class="company-item">
            <el-card style="width: 100%;height: 100%;border-radius: 20px;text-align: center;">
                <template #header>
                    <div class="card-header">
                        <span>XXX外资企业</span>
                    </div>
                </template>
                <p v-for="o in 10" :key="o" class="text item">{{ 'List item ' + o }}</p>
                <template #footer>
                    <a-button ghost type="primary">立刻联系</a-button>
                </template>
            </el-card>
        </div>
        <div class="company-item">
            <el-card style="width: 100%;height: 100%;border-radius: 20px;text-align: center;">
                <template #header>
                    <div class="card-header">
                        <span>XXX集团</span>
                    </div>
                </template>
                <p v-for="o in 10" :key="o" class="text item">{{ 'List item ' + o }}</p>
                <template #footer>
                    <a-button ghost type="primary">立刻联系</a-button>
                </template>
            </el-card>
        </div>
    </div>
    <div class="footer">
        <div class="copyright">
            <div class="copyright">
                <p>
                    <span>Copyright © 2024 yueyvlunhui</span>
                </p>
            </div>
        </div>
    </div>


</template>

<style scoped lang='scss'>

.company-title {
    width: 100%;
}

.company {
    display: grid;
    margin-top: 10vh;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: 40px;
    margin: 0 auto;
    /* 使用 auto 值来使容器水平居中 */
    margin-top: 10vh;
    width: 90vw;
    /* 设置容器的宽度 */
}

.company-item {
    // display: flex;
    height: 25vw;
    width: 100%;
    border-radius: 20px;
    background-color: #fdffff;
    display: flex;
    justify-content: center;
    /* 水平居中 */
    align-items: center;
    /* 垂直居中 */
}

/* For demo */
:deep(.slick-slide) {
    text-align: center;
    //   height: 160px;
    //   line-height: 160px;
    //   background: #364d79;
    overflow: hidden;
}

:deep(.slick-arrow.custom-slick-arrow) {
    width: 25px;
    height: 25px;
    font-size: 25px;
    color: #fff;
    background-color: rgba(31, 45, 61, 0.11);
    transition: ease all 0.3s;
    opacity: 0.3;
    z-index: 1;
}

:deep(.slick-arrow.custom-slick-arrow:before) {
    display: none;
}

:deep(.slick-arrow.custom-slick-arrow:hover) {
    color: #fff;
    opacity: 0.5;
}

:deep(.slick-slide h3) {
    color: #fff;
}

.footer {
    color: aliceblue;
    text-align: center;
    line-height: 5vh;
    height: 5vh;
    border-radius: 10px;
    margin-top: 10vh;
    background-color: #313438;
}

.job-item {
    overflow: hidden;
}

.job-contain {
    margin-top: 5vh;
    // height: calc(100vh - 300px);
    display: grid;
    justify-items: center;
    grid-template-columns: 1fr 1fr 1fr 1fr;
    gap: 10px 10px;

}

.session-title {
    font-weight: 800;
    letter-spacing: 5px;
    font-size: 50px !important;
    // left: 50%;
    // transform: translate(-50%,-50%);
    margin-top: 5vh;
    font-size: 25px;
    margin-left: calc((100vw - 200px)/2);
    color: rgb(227, 251, 255);
}

.job-title {
    text-decoration: none;
    font-weight: 800;
    letter-spacing: 5px;
    font-size: 40px;
    margin-top: 10vh;
    font-size: 25px;
    margin-left: 40px;
    color: rgb(227, 251, 255);
}

// / .job-item {
// //     // overflow: hidden;

// // }
.job-card {
    &:hover {
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
    // background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}

.bg1 {
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}

.bg2 {
    background: linear-gradient(to top left, #9fffef, #9fffef, #9fffef);
}

.bg3 {
    background: linear-gradient(to top left, #e7cbc8, #e7cbc8, #e7cbc8);
}

.bg4 {
    background: linear-gradient(to top left, #71e3ff, #71e3ff, #71e3ff);
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
