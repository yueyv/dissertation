<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import {
  AlignCenterOutlined, EditOutlined
} from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';
import axios from '@/plugins/axiosBase.js'
import { useRoute, useRouter } from 'vue-router';
import getCompanyMap from "@/components/map/getCompanyMap.vue";
// const valueHtml = ref('')
const router = useRouter()
const route = useRoute()
const isShowMap2 = ref(false)
console.log(route.params.id);
const companyData = ref({
  name: null,
  introduction: null,
})
// const userInformation=JSON.parse(sessionStorage.getItem("userInformation"))

onBeforeMount(() => {
  axios.post('GetCompany', { company_id: route.params.id }).then((res) => {
    if (res.code == 200) {
      //   message.success("拉取成功")
      //   console.log(res.data);
      //   valueHtml.value=res.data?.introduction
      companyData.value = res.data
      // console.log(companyData.value);
    }

  }).catch((e) => {
    console.log(e);
    message.error("上传失败")
  })
})
const showMap2 = () => { isShowMap2.value = !isShowMap2.value }
</script>

<template>
  <a-button v-if="isShowMap2" danger ghost @click="showMap2()" class="close-map">关闭地图</a-button>
  <getCompanyMap :user_id="companyData.user_id" v-if="isShowMap2"></getCompanyMap>
  <myHeader :active-nav="0"></myHeader>
  <div class="function-button">
    <a-button type="primary" @click="showMap2()">查看公司位置</a-button>
    <a-button type="primary">

      <a :href="`/chatFindPage/${companyData.user_id}`">查看招聘</a>
    </a-button>
  </div>
  <div class="company-container">
    <h1 style="font-size: 20px;line-height: 40px;text-align: center;">{{ companyData.name }}</h1>
    <div id="introduction">
      <div v-html="companyData.introduction"></div>
    </div>
  </div>
</template>

<style scoped lang='scss'>
.close-map {
  position: fixed;
  left: 75%;
  z-index: 9999;
  top: 15vh;
  transform: translate(-50%, 0);
}
.function-button {
  position: fixed;
  z-index: 100;
  // color: #e7cbc8;
  // background-color: #e7cbc8;
  // width: 50px;
  // height: 50px;
  line-height: 50px;
  text-align: center;
  border-radius: 50%;
  // width: 100px;
  text-decoration: none;
  left: 90vw;
  top: 40vh;
}
.to-job {
  position: fixed;
  top: 15vh;
  left: 92vw;
}

#introduction {
  margin: 20px;
}

.company-container {
  overflow: scroll;
  border-radius: 20px;
  margin: 5vh auto;
  width: 80vw;
  height: 80vh;
  background-color: rgba(240, 248, 255, 0.836);

  &::-webkit-scrollbar {
    display: none;
  }
}
</style>