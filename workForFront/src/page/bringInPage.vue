<script setup>
import { ref, reactive, onBeforeMount, toRaw } from 'vue'
import myHeader from '@/components/header/header.vue';
import { Dayjs } from 'dayjs';
import { useRouter } from 'vue-router'
import axios from '@/plugins/axiosBase.js';
import { message } from 'ant-design-vue';
const router = useRouter()
const permission = ref(1);
onBeforeMount(() => {
    axios.get("getPermission").then((res) => {
        if (res.code == 200) {
            permission.value = res.data.permission
            console.log(permission.value);
            sessionStorage.setItem("permission", JSON.stringify(res.data.permission))
        }
    }
    )
})
const back = () => {
    router.back()
}
const moveToApply = () => {
    router.push('/bringInPage/apply')
}
const moveToControl=()=>{
    router.push('/bringInPage/myEdit')
}


const formRef = ref();
const labelCol = { span: 8 };
const wrapperCol = { span: 8 };
const formState = reactive({
    title: '',
    company_name: '',
    city: undefined,
    salary_range: undefined,
    job_info: undefined,
    description: '',
    walfare: '',
});
const rules = {
    title: [
        { required: true, message: '输入职位名称', trigger: 'change' },
        { min: 0, max: 10, message: '在10个字以内', trigger: 'blur' },
    ],
    company_name: [
        { required: true, message: '输入职位名称', trigger: 'change' },
        { min: 0, max: 20, message: '在20个字以内', trigger: 'blur' },
    ],
    city: [{ required: true, message: '请选择城市', trigger: 'change' }],
    salary_range: [{ required: true, message: '请选择薪资范围', trigger: 'change' }],
    job_info: [{ required: true, message: '请选择薪资范围', trigger: 'change' }],
    resource: [{ required: true, message: 'Please select activity resource', trigger: 'change' }],
    description: [{ required: true, message: '请完成此空', trigger: 'blur' }],
    walfare: [{ required: true, message: '请完成此空', trigger: 'blur' }],
};
const onSubmit = () => {
    formRef.value
        .validate()
        .then(() => {
            axios.post("addJob", toRaw(formState)).then((res) => {
                if(res.code==200){
                    message.success("提交成功")
                }else{
                    message.error("请求出现错误,请重试")
                    console.log('error', res);
                }
            }

            ).catch((e) => {
                message.error("服务器出现错误,请重试")
                console.log('error', error);
            }

            )
            // console.log('values', formState, toRaw(formState));
        })
        .catch(error => {
            message.error("出现错误,请重试")
            console.log('error', error);

        });
};
const resetForm = () => {
    formRef.value.resetFields();
};
</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="auth" v-if="permission != 1">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">权限不足</h1>
            <a-button @click="moveToApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">申请</a-button>
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">返回</a-button>
        </div>
    </div>
    <div class="advs">编辑招聘详情
        <br>
        <a-button type="primary" @click="moveToControl()" ghost>前往我的招聘</a-button>
    </div>
    <div class="edit-job-contain" v-if="permission == 1">
        <a-form ref="formRef" :model="formState" :rules="rules" :label-col="labelCol" :wrapper-col="wrapperCol">
            <a-form-item ref="title" label="职位名称" name="title">
                <a-input v-model:value="formState.title" />
            </a-form-item>
            <a-form-item ref="company_name" label="公司名称" name="company_name">
                <a-input v-model:value="formState.company_name" />
            </a-form-item>
            <a-form-item label="城市" name="city">
                <a-select v-model:value="formState.city" placeholder="请选择城市">
                    <a-select-option value="南京">南京</a-select-option>
                    <a-select-option value="上海">上海</a-select-option>
                    <a-select-option value="深圳">深圳</a-select-option>
                    <a-select-option value="芜湖">芜湖</a-select-option>
                </a-select>
            </a-form-item>
            <a-form-item label="薪资" name="salary_range">
                <a-select v-model:value="formState.salary_range" placeholder="请选择薪资范围">
                    <a-select-option value="0">5k以下</a-select-option>
                    <a-select-option value="1">5-8k</a-select-option>
                    <a-select-option value="2">8-15k</a-select-option>
                    <a-select-option value="3">15k以上</a-select-option>
                    <a-select-option value="4">面谈</a-select-option>
                </a-select>
            </a-form-item>
            <a-form-item label="工作性质" name="job_info">
                <a-radio-group v-model:value="formState.job_info">
                    <a-radio value="0" name="type">全职</a-radio>
                    <a-radio value="1" name="type">劳务派遣</a-radio>
                    <a-radio value="2" name="type">兼职</a-radio>
                </a-radio-group>
            </a-form-item>
            <a-form-item label="工作信息及工作地点" name="description">
                <a-textarea v-model:value="formState.description" />
            </a-form-item>
            <a-form-item label="工作福利" name="walfare">
                <a-textarea v-model:value="formState.walfare" />
            </a-form-item>
            <a-form-item :wrapper-col="{ span: 14, offset: 8 }">
                <a-button type="primary" @click="onSubmit">提交</a-button>
                <a-button style="margin-left: 10vw; text-align: center;" @click="resetForm">清空表格</a-button>
            </a-form-item>
        </a-form>
    </div>
</template>

<style scoped lang='scss'>
.auth {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: #00000057;

    .auth-box {
        font-size: 30px;
        background-color: rgba(240, 248, 255, 0.76);
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

.edit-job-contain {
    width: 60vw;
    padding-left: 30px;
    padding-top: 5vh;
    margin-top: 5vh;
    margin-left: 20vw;
    align-items: center;
    padding-bottom: 40px;
    border-radius: 30px;
    background-color: #f5f5f583;
}

.advs {
    font-weight: 800;
    color: white;
    padding-top: 70px;
    letter-spacing: 5px;
    line-height: 40px;
    font-size: 40px;
    text-align: center;
    border-radius: 0px 0px 9px 9px;
    height: 130px;
    background: linear-gradient(to top left, #9fffef, #e7cbc8, #71e3ff);
}
</style>
