<script setup>
import { ref, reactive, onBeforeMount } from 'vue'
import myHeader from '@/components/header/header.vue';
import axios from '../plugins/axiosBase.js';
import { useRouter } from 'vue-router';
import { UploadOutlined, DownloadOutlined, CustomerServiceOutlined, CommentOutlined, AlignCenterOutlined } from '@ant-design/icons-vue';
const router = useRouter()
import {
    EditOutlined
} from '@ant-design/icons-vue';
const userData = ref({
    email: null,
    phone: null,
    college: null,
    address: null,
    name: null,
    city: null,
    salary: null,
    other: null
});

const permission = ref(0);
const isShow = ref(false)
onBeforeMount(() => {
    axios.post('get_user').then((res) => {
        userData.value = res.data
        console.log(userData.value);
    }
    ).catch((e) => {
        console.log("查询失败");
        console.log(e);
    })
    axios.get("getPermission").then((res) => {
        if (res.code == 200) {
            permission.value = res.data.permission
            isShow.value = true
            console.log(permission.value);
            sessionStorage.setItem("permission", JSON.stringify(res.data.permission))
        }
    }
    )
})
const back = () => {
    router.push("/bringInPage/myEdit")
}
</script>

<template>
    <myHeader></myHeader>

    <div class="auth" v-if="permission == 1">
        <div class="auth-box">
            <h1 style="margin-top: 3vw;">您是招聘人员</h1>
            <!-- <a-button @click="moveToApply()" style="margin-top: 3vw; width: 10vw;height: 3vw;">申请</a-button> -->
            <a-button @click="back()" style="margin-top: 3vw; width: 10vw;height: 3vw;">前往招聘页面</a-button>
        </div>
    </div>
    <div class="appointment-w3" v-if="isShow && permission != 1">
        <form action="#" method="post">
            <div class="personal">
                <h2>个人信息</h2>
                <div class="form-left-w3l">
                    <p>姓名</p>
                    <input type="text" name="name" :placeholder="userData.name" required="" disabled>
                </div>
                <div class="form-right-w3ls ">
                    <p>毕业院校</p>
                    <input type="text" name="collage" :placeholder="userData.college" required="" disabled>
                    <div class="clear"></div>
                </div>
                <div class="form-left-w3l">
                    <p>邮箱</p>
                    <input type="email" name="email" :placeholder="userData.email" required="" disabled>
                </div>
                <div class="form-right-w3ls ">
                    <p>电话</p>
                    <input class="buttom" type="text" name="phone number" :placeholder="userData.phone" required=""
                        disabled>
                </div>
                <div class="clear"></div>
            </div>
            <div class="information">
                <h3>求职信息</h3>
                <div class="form-add-w3ls">
                    <p>现住地</p>
                    <input type="text" name="address" :placeholder="userData.address" required="" disabled>
                </div>
                <div class="form-left-w3l">
                    <p>期望城市</p>
                    <input type="text" name="city" :placeholder="userData.city" required="" disabled>
                </div>
                <div class="form-right-w3ls">
                    <p>期望薪资</p>
                    <select class="form-control" v-model="userData.salary" disabled>
                        <option value="">5k以下</option>
                        <option value="1">5-8k</option>
                        <option value="2">8-15k</option>
                        <option value="2">15k以上</option>
                        <option value="2">面谈</option>
                    </select>
                </div>
                <div class="clear"></div>
            </div>

            <div class="other">
                <h3>其他</h3>
                <div class="clear"></div>
                <div class="form-control-w3l">
                    <textarea name="text" :placeholder="userData.other" disabled></textarea>
                </div>
            </div>
        </form>
    </div>
    <a-float-button-group trigger="click" type="primary" :style="{ right: '8vw' }" tooltip="编辑个人信息">
        <template #icon>
            <EditOutlined />
        </template>
        <a-float-button tooltip="上传简历">
            <template #icon>
                <router-link to="uploadResume">
                    <UploadOutlined />
                </router-link>
            </template>
        </a-float-button>
        <a-float-button tooltip="下载简历">
            <template #icon>
                <a :href="'/api/resume?filename='+`${userData.user_id}`+`_`+`${encodeURIComponent(userData.resume)}` " :download="userData.user_id + '_' + userData.resume">
                    <DownloadOutlined />
                </a>
            </template>
        </a-float-button>
        <a-float-button tooltip="编辑个人信息">
            <template #icon>
                <router-link to="editPersonMesPage">
                    <EditOutlined />
                </router-link>
            </template>
        </a-float-button>

    </a-float-button-group>
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

.edit {
    color: black;
    position: fixed;
    border-radius: 50%;
    font-size: 80px;
    left: 80vw;
    overflow: hidden;
    top: 40vh;
    background-color: #ffffff5e;

    :hover {
        color: rgba(0, 0, 0, 0.521);
        background-color: #ffffffb9;
        border-radius: 50%;
    }
}

.appointment-w3 {
    width: 42%;
    margin: 30px auto 30px;
    background-color: rgba(62, 88, 88, 0.79);
    padding: 40px 40px;
    box-shadow: 2px 3px rgba(0, 0, 0, 0.42);
}

h1 {
    padding-top: 31px;
}

h1.header-w3ls {
    text-align: center;
    font-size: 50px;
    font-weight: 600;
    text-transform: uppercase;
    color: #fff;
    letter-spacing: 11px;
    text-shadow: 2px 3px rgba(0, 0, 0, 0.42);
}

.personal h2,
.information h3,
.other h3 {
    font-size: 30px;
    color: #fff;
    text-align: center;
    margin: .5em 0;
    letter-spacing: 3px;
}



.form-right-w3ls {
    float: right;
    padding-right: 0px;
}

.form-left-w3l {
    float: left;
    padding-left: 0px;
}

.form-right-w3ls,
.form-left-w3l {
    width: 48%;
}

.form-left-w3l input[type="text"],
.form-right-w3ls input[type="text"],
.form-left-w3l input[type="email"],
.form-control-w3l textarea,
.form-right-w3ls input[type="date"],
.form-add-w3ls input[type="text"] {
    color: #000;
    outline: none;
    font-size: 1em;
    padding: .8em 1em;
    margin-bottom: 2em;
    border: none;
    margin: 5px 0px 16px;
    border-bottom: solid 2px #23b7bd;
    display: inline-block;
    background: rgba(255, 255, 255, 0.39);
    transition: all 0.5s ease-in-out;
    -webkit-transition: all 0.5s ease-in-out;
    -moz-transition: all 0.5s ease-in-out;
    -o-transition: all 0.5s ease-in-out;
    -ms-transition: all 0.5s ease-in-out;
    box-shadow: 2px 3px rgba(0, 0, 0, 0.42);
}

select.form-control {
    outline: none;
    font-size: 1em;
    padding: 0.8em 1em;
    width: 100%;
    height: 45.6px;
    margin: 5px 0px 16px;
    border-radius: 0;
    background: rgba(255, 255, 255, 0.39);
    color: #000;
    border: none;
    border-bottom: solid 2px #23b7bd;
    box-shadow: 2px 3px rgba(0, 0, 0, 0.42);
    transition: all 0.5s ease-in-out;
    -webkit-transition: all 0.5s ease-in-out;
    -moz-transition: all 0.5s ease-in-out;
    -o-transition: all 0.5s ease-in-out;
    -ms-transition: all 0.5s ease-in-out;
}

::-webkit-input-placeholder {
    /* Chrome/Opera/Safari */
    color: #000;
}

::-moz-placeholder {
    /* Firefox 19+ */
    color: #000;
}

:-ms-input-placeholder {
    /* IE 10+ */
    color: #000;
}

:-moz-placeholder {
    /* Firefox 18- */
    color: #000;
}

textarea {
    height: 134px;
    padding: 1em;
    overflow: hidden;
    resize: none;
}

.form-left-w3l p,
.form-right-w3ls p,
.form-control-w3l p,
.form-add-w3ls p {
    color: #23b7bd;
    font-size: 17px;
    letter-spacing: .5px;
    text-transform: capitalize;
}

.form-left-w3l input[type="text"]:hover,
.form-left-w3l input[type="text"]:focus,
.form-add-w3ls input[type="text"]:hover,
.form-add-w3ls input[type="text"]:focus,
.form-right-w3ls input[type="text"]:hover,
.form-right-w3ls input[type="text"]:focus,
.form-left-w3l input[type="email"]:hover,
.form-left-w3l input[type="email"]:focus,
.form-control-w3l textarea:hover,
.form-control-w3l textarea:focus,
.form-right-w3ls select:hover,
.form-right-w3ls select:focus,
.form-left-w3l select:hover,
.form-left-w3l select:focus {
    background: #ffffff;
    color: #000;
    outline: none;
}

input[type="submit"] {
    text-transform: uppercase;
    background: #fff;
    color: #000000;
    padding: .7em 0em;
    border: none;
    font-size: 1em;
    outline: none;
    width: 100%;
    letter-spacing: 1px;
    font-weight: 600;
    margin-top: 1em;
    cursor: pointer;
    -webkit-transition: 0.5s all;
    -moz-transition: 0.5s all;
    -o-transition: 0.5s all;
    -ms-transition: 0.5s all;
    transition: all 0.5s;
}

input[type="submit"]:hover {
    color: #fff;
    background: #23b7bd;
}

.copy {
    padding-bottom: 30px;
}

.copy p {
    margin: 0em;
    text-align: center;
    font-size: 14px;
    color: white;
    letter-spacing: 1px;
}

.copy p a {
    color: #33e8ff;
    text-decoration: none;
}

.copy p a:hover {
    color: #fff;
}

/*--responsive--*/
@media(max-width:1920px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 91.3%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 96%;
    }
}

@media(max-width:1680px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 90.3%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.3%;
    }
}

@media(max-width:1600px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 90%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95%;
    }
}

@media(max-width:1440px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 90.2%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.3%;
    }

    .appointment-w3 {
        width: 50%;
    }
}

@media(max-width:1366px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 91%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.8%;
    }

    .appointment-w3 {
        width: 57%;
    }
}

@media(max-width:1280px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 91.2%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.9%;
    }

    .appointment-w3 {
        width: 61%;
    }
}

@media(max-width:1080px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 89.5%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95%;
    }

    h1.header-w3ls {
        font-size: 47px;
        letter-spacing: 7px;
    }

    .appointment-w3 {
        width: 61%;
    }
}

@media(max-width:1050px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 89.9%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.2%;
    }

    .appointment-w3 {
        width: 66%;
    }

}

@media(max-width:1024px) {
    .appointment-w3 {
        width: 70%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 90.2%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.5%;
    }
}

@media(max-width:991px) {
    h1.header-w3ls {
        font-size: 45px;
        letter-spacing: 6px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 90.2%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95.2%;
    }
}

@media(max-width:900px) {
    .appointment-w3 {
        width: 73%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 95%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 89.5%;
    }
}

@media(max-width:800px) {
    h1.header-w3ls {
        font-size: 42px;
        letter-spacing: 4px;
    }

    .appointment-w3 {
        width: 75%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 88.5%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 94.5%;
    }
}

@media(max-width:768px) {
    .appointment-w3 {
        padding: 31px 31px;
        width: 75%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 88%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 94.2%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-control-w3l textarea,
    .form-right-w3ls input[type="date"],
    .form-add-w3ls input[type="text"] {
        padding: .5em 1em;
    }

    select.form-control {
        height: 36px;
        padding: .5em 1em;
    }

    .form-right-w3ls {
        padding-left: 0em;
    }

    .form-left-w3l {
        padding-right: 0em;
    }
}

@media(max-width:767px) {
    .appointment-w3 {
        width: 80%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 89%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 94.5%;
    }
}

@media(max-width:736px) {

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-control-w3l textarea,
    .form-right-w3ls input[type="date"] {

        margin: 5px 0px 11px;
    }

    select.form-control {

        margin: 5px 0px 11px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 88%;
    }

    textarea {
        height: 115px;
    }

}

@media(max-width:667px) {
    h1.header-w3ls {
        font-size: 38px;
        letter-spacing: 3px;
        padding: 27px 10px 0px;
    }

    .personal h2,
    .information h3,
    .education h3 {
        font-size: 28px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 87%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 93.8%;
    }
}

@media(max-width:640px) {
    .appointment-w3 {
        width: 85%;
    }
}

@media(max-width:600px) {
    h1.header-w3ls {
        font-size: 36px;
    }

    .appointment-w3 {
        padding: 26px 26px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"] {
        width: 86.5%;
    }

    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 93.5%;
    }
}

@media(max-width:568px) {

    .form-right-w3ls,
    .form-left-w3l {
        float: none;
        width: 100%;
    }

    h1.header-w3ls {
        font-size: 32px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 93%;
    }

    .personal h2,
    .information h3,
    .education h3 {
        font-size: 26px;
    }

    .appointment-w3 {
        width: 87%;
    }

    .copy p {
        padding: 0 9px;
        line-height: 31px;
    }
}

@media(max-width:480px) {
    h1.header-w3ls {
        font-size: 32px;
    }

    .personal h2,
    .information h3,
    .education h3 {
        font-size: 22px;
    }

    .form-left-w3l p,
    .form-right-w3ls p,
    .form-control-w3l p {
        font-size: 15px;
    }

    h1.header-w3ls {
        line-height: 40px;
        padding: 27px 20px 0px;
    }

    .appointment-w3 {
        width: 81%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 91.2%;
    }

    .copy p {
        padding: 0px 16px;
    }
}

@media(max-width:440px) {
    h1.header-w3ls {
        font-size: 30px;
    }

    .appointment-w3 {
        width: 81%;
    }

    textarea {
        height: 109px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 90.5%;
    }

    .copy p {
        padding: 0px 20px;
    }
}

@media(max-width:414px) {

    h1.header-w3ls {
        letter-spacing: 2px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 89.5%;
    }
}

@media(max-width:384px) {
    h1.header-w3ls {
        letter-spacing: 1px;
    }

    .education h3 {
        font-size: 19px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 89%;
    }

    .appointment-w3 {
        width: 75%;
    }
}

@media(max-width:375px) {
    .appointment-w3 {
        width: 75%;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 88%;
    }
}

@media(max-width:320px) {

    .personal h2,
    .information h3,
    .education h3 {
        font-size: 17px;
        letter-spacing: 2px;

    }

    .form-left-w3l p,
    .form-right-w3ls p,
    .form-control-w3l p {
        font-size: 13px;
    }

    h1.header-w3ls {
        font-size: 25px;
    }

    .form-left-w3l input[type="text"],
    .form-right-w3ls input[type="text"],
    .form-left-w3l input[type="email"],
    .form-right-w3ls input[type="date"],
    .form-control-w3l textarea,
    .form-add-w3ls input[type="text"] {
        width: 86%;
    }
}

/*--//responsive--*/
</style>