<script setup lang='ts'>
import { message } from 'ant-design-vue'
import { ref, reactive } from 'vue'
const search_content = ref<string>()
const search_start = (e: KeyboardEvent) => {
    if (e.key === 'Enter') {
        const searchUrl = `https://www.bing.com/?q=${search_content.value}`
        window.open(searchUrl, '_blank')
    }
}   
// const auto_fit=()=>{
//     message.info(window.innerWidth)
// }
</script>

<template>
    <div class="searchbox">
        <input v-model="search_content" type="text" placeholder="站内搜索" class="search_input" @keypress="search_start">
    </div>
</template>

<style scoped lang='less'>
.searchbox {
    width: 100%;
    // width: 80vw;
    display: grid;
    justify-content: center;
    margin-bottom: 20px;
    // grid-template-columns: min(80vw,700px);
}
.search_input{
    height: 50px;
    width: 60vw;
    
    max-width: 600px;
    border-radius: 20px;
    border: none;
    text-align: center;
    width: max-content(700px);
    display: block;
    font-size: 18px;
    background-color: rgba(255, 255, 255, 0.5);
    &:focus{
        border: none;
        outline: none;
        background-color: rgba(255, 255, 255, 0.8);
        box-shadow: 0px 5px 1px 1px rgba(255, 255, 255, 0.2);
    }
}
// @media(min-width: 700px){
//     .search_input{
//         min-width: 80vw;
//     }
// }
</style>