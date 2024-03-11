<script setup >
import { message } from 'ant-design-vue'
import { ref, reactive } from 'vue'
import { useRoute, useRouter } from 'vue-router';
import { DownOutlined } from '@ant-design/icons-vue';
const search_content = ref()
const router = useRouter()
const route = useRoute()
//TODO 搜索页面
const search_start = () => {
       if(search_content.value){
        router.push({ path:'/searchPage',  query:{ title:search_content.value  } }).then((e)=>{
            router.go(0)
        }
        
        )
       
       }else{
        message.info("请输入值")
       }

        // window.open(searchUrl, '_blank')

}   
// const auto_fit=()=>{
//     message.info(window.innerWidth)
// }
const searchHead = [
    "软件工程师","销售", "财务"
]
const searchHeadValue = ref("类型")
const clickSearchHeadItem=(item)=>{
    search_content.value=item
}
</script>

<template>
    <div class="searchbox">
        <div class="search-head">
            <a-dropdown>
                <a class="ant-dropdown-link" @click.prevent>
                    {{ searchHeadValue }}
                    <DownOutlined />
                </a>
                <template #overlay>
                    <a-menu>
                        <a-menu-item v-for="item in searchHead" :key="item" @click="clickSearchHeadItem(item)">
                            {{ item }}
                        </a-menu-item>
                    </a-menu>
                </template>
            </a-dropdown>
        </div>
        <input v-model="search_content" type="text" placeholder="搜索职位" class="search-input" @keypress="search_start">
        <div class="search-enter" @click="search_start()">搜索</div>
    </div>
</template>

<style scoped lang='less'>
.searchbox {
    margin-right: 15vw;
    padding:5px;
    margin-left: 15vw;
    background-color: #00BCD4;
    border-radius: 20px;
    // margin-top: 50px;
    // width: 100%;
    // width: 80vw;
    display: flex;
    justify-content: center;
    margin-bottom: 20px;
    // grid-template-columns: min(80vw,700px);
}

.search-input {
    width: 40vw;
    max-width: 600px;
    border: none;
    padding-left: 20px;
    text-align: left;
    width: max-content(700px);
    display: block;
    font-size: 18px;
    border-radius: 0px 20px 20px 0px;
    background-color: rgba(255, 255, 255, 0.5);

    &:focus {
        border: none;
        outline: none;
        background-color: rgba(255, 255, 255, 0.8);
        // box-shadow: 0px 5px 1px 1px rgba(255, 255, 255, 0.2);
    }
}

.search-head {
    font-weight: 600;
    color: #212121;
    line-height: 50px;
    text-align: center;
    display: inline-flexbox;
    height: 50px;
    width: 15vw;
    font-size: 18px;
    border-radius: 20px 0px 0px 20px;
    background-color: rgba(255, 255, 255, 0.5);
}

.search-enter {
    font-weight: 600;
    color:#FFFFFF;
    line-height: 50px;
    text-align: center;
    display: inline-flexbox;
    height: 50px;
    width: 15vw;
    font-size: 20px;
    background-color: #00BCD4;
    &:hover{
        color: antiquewhite;
    }
}

// @media(min-width: 700px){
//     .search-input{
//         min-width: 80vw;
//     }
// }</style>