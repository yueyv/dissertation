<script setup>
import { ref,reactive, onBeforeMount} from 'vue'
import myHeader from '@/components/header/header.vue';
import {
    AlignCenterOutlined,EditOutlined 
} from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';
import axios from '@/plugins/axiosBase.js'
import { useRoute, useRouter } from 'vue-router';
// const valueHtml = ref('')
const router = useRouter()
const route = useRoute()
console.log(route.params.id);
const companyData=ref({
    name:null,
    introduction:null,
})
// const userInformation=JSON.parse(sessionStorage.getItem("userInformation"))

  onBeforeMount(()=>{
    axios.post('GetCompany',{company_id:route.params.id}).then((res)=>{
    if(res.code==200){
    //   message.success("拉取成功")
    //   console.log(res.data);
    //   valueHtml.value=res.data?.introduction
    companyData.value=res.data
    console.log(companyData.value);
    }
   
  }).catch((e)=>{
    console.log(e);
    message.error("上传失败")
  })
  })
</script>

<template>
  <myHeader :active-nav="0"></myHeader>
  <div>
    <a-button type="primary" class="to-job">
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
.to-job{
  position: fixed;
  top:15vh;
  left:92vw;
}
#introduction{
    margin: 20px;
}
.company-container{
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