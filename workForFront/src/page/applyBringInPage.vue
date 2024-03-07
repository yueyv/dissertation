<script setup>
import { ref, reactive } from 'vue'
import myHeader from '@/components/header/header.vue';
import { InboxOutlined } from '@ant-design/icons-vue';
import { message } from 'ant-design-vue';
import axios from '@/plugins/axiosBase.js';
import { useRouter } from 'vue-router'
// 上传提示框
const existUpload = ref(false)
const router = useRouter()
// MARK改为axios上传
const fileList = ref([]);
const status = ref(false)

// 拖拽
function handleDrop(e) {
    console.log(e);
}
const headleUpload = (info) => {
    const formData = new FormData()
    // console.log(fileList.value);
    fileList.value.forEach((file) => {
        console.log(file.originFileObj);
        
        formData.append("file", file.originFileObj)
    })
    // test
    status.value = true
    message.info(`${info.file.name} 上传中.`);
    axios.post('upload_apply', formData, {
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    }).then(response => {
        fileList.value = []
        status.value = false
        message.success(`${info.file.name} 上传成功.`);
        console.log('上传成功', response.data);
    }).catch(error => {
        status.value = false
        console.error('上传失败', error);
        message.error(`${info.file.name} 上传失败.`);
    });
}
const beforeUpload = file => {
    fileList.value = [...(fileList.value || []), file];
    return true;
};
const back = () => {
    router.back()
}
const reApply = () => {
    existUpload.value = false
}
</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="advs">申请招聘</div>
    <div class="auth" v-show="existUpload">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">已经上传文件</h1>
            <a-button @click="reApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">重新上传</a-button>
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">返回</a-button>
        </div>
    </div>
    <div class="upload-contain">
        <!-- SSR选项 -->
        <a-upload-dragger :before-upload="beforeUpload" :supportServerRender="false" :maxCount="1"
            v-model:fileList="fileList" :loading="status" :customRequest="headleUpload" name="file" :multiple="true"
            @drop="handleDrop">
            <p class="ant-upload-drag-icon" style="margin-top: 10vh;">
                <inbox-outlined></inbox-outlined>
            </p>
            <p class="ant-upload-text">点击这个区域上传相关证明</p>
            <p class="ant-upload-hint">
                包括但不限与各种证明
            </p>
        </a-upload-dragger>
    </div>
</template>

<style scoped lang='scss'>
.auth {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: #0000008c;
    z-index: 1;

    .auth-box {
        font-size: 30px;
        background-color: rgba(240, 248, 255, 0.904);
        width: 20vw;
        height: 20vw;
        display: flex;
        justify-items: center;
        flex-direction: column;
        align-items: center;
        border-radius: 30px;
        position: fixed;
        left: 50%;
        top: 40%;
        transform: translate(-50%, -50%);
        ;
    }
}

.upload-contain {
    border-radius: 20px;
    margin-top: 20px;
    text-align: center;
    align-items: center;
    width: 40vw;
    position: relative;
    left: 50%;
    height: 40vh;
    transform: translate(-50%);
    background-color: #ffffffad;

    :hover {
        background-color: #ffffff;
        border-radius: 20px;
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
</style>
