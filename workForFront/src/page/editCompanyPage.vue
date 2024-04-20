<script setup>
import '@wangeditor/editor/dist/css/style.css' // 引入 css
import { onBeforeUnmount, ref, shallowRef, onMounted } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import myHeader from '@/components/header/header.vue';
import { message } from 'ant-design-vue';
import companyMap from "@/components/map/companyMap.vue";
import getCompanyMap from "@/components/map/getCompanyMap.vue";
import axios from '@/plugins/axiosBase.js'

// 编辑器实例，必须用 shallowRef
const editorRef = shallowRef()
const user_id=ref()
const userInformation=JSON.parse(sessionStorage.getItem("userInformation"))
const isShowMap=ref(false)
const isShowMap2=ref(false)
// 内容 HTML
const valueHtml = ref('')

// 模拟 ajax 异步获取内容


const toolbarConfig = {}
const editorConfig = {
  placeholder: '请输入内容...', 
  MENU_CONF: {}
}
editorConfig.MENU_CONF['uploadImage'] = {
  base64LimitSize: 1024 * 1024 // 5kb
}
// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
  const editor = editorRef.value
  if (editor == null) return
  editor.destroy()
})
axios.post('GetCompany',{user_id:userInformation.user_id}).then((res)=>{
    if(res.code==200){
      message.success("拉取成功")
      // console.log(res.data);
      valueHtml.value=res.data?.introduction
    }
   
  }).catch((e)=>{
    console.log(e);
    message.error("上传失败")
  })
const handleCreated = (editor) => {
  editorRef.value = editor // 记录 editor 实例，重要！
}
const pull = () => {
  message.info("拉取文件中...")
  // message.info(userInformation.user_id)
  user_id.value=userInformation.user_id
  axios.post('GetCompany',{user_id:userInformation.user_id}).then((res)=>{
    if(res.code==200){
      message.success("拉取成功")
      valueHtml.value=res.data?.introduction
    }
   
  }).catch((e)=>{
    console.log(e);
    message.error("上传失败")
  })
}
const upload = () => {
  message.info("上传文件中...")
  axios.post('uploadCompany',{introduction:valueHtml.value}).then((res)=>{
    message.success("上传成功")
  }).catch((e)=>{
    console.log(e);
    message.error("上传失败")
  })
  // console.log(valueHtml.value);
}
const showMap=()=>{isShowMap.value=!isShowMap.value}
const showMap2=()=>{isShowMap2.value=!isShowMap2.value}
</script>

<template>
      <a-button v-if="isShowMap2" danger ghost @click="showMap2()" class="close-map">关闭地图</a-button>
      <a-button v-if="isShowMap" danger ghost @click="showMap()" class="close-map">关闭地图</a-button>
  <companyMap v-if="isShowMap"></companyMap>
  <getCompanyMap :user_id="userInformation.user_id" v-if="isShowMap2"></getCompanyMap>
  <myHeader :active-nav="0"></myHeader>
  <div style="border: 1px solid #ccc" class="wangeditor-container">
    <Toolbar style="border-bottom: 1px solid #ccc" :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode" />
    <Editor style="height: 500px; overflow-y: hidden;" v-model="valueHtml" :defaultConfig="editorConfig" :mode="mode"
      @onCreated="handleCreated" />
  </div>
  <div class="function-button">
    <a-button type="primary" @click="showMap2()">查看公司位置</a-button>
    <a-button type="primary" @click="showMap()">上传公司位置</a-button>
    <br>
    <a-button @click="pull()">拉取</a-button>
    <br>
    <a-button @click="upload()">上传</a-button>
  </div>
</template>


<style scoped lang='scss'>

.close-map{
    position: fixed;
    left: 75%;
    z-index: 9999;
    top: 15vh;
    transform: translate(-50%,0);
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
  text-decoration: none;
  left: 90vw;
  top: 40vh;
}

.wangeditor-container {
  // margin-top: ;
  border-radius: 20px;
  overflow: hidden;
  width: 80vw;
  // height: 80vh;
  margin: 5vh auto;
}
</style>