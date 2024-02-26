<script setup>
import { ref,reactive} from 'vue'
import myHeader from '@/components/header/header.vue';
import searchHome from '@/components/search/index.vue';
const commendTags=[
    {
        title:"Java",
        link:"",
    },
    {
        title:"PHP",
        link:"",
    },
    {
        title:"JS",
        link:"",
    },
    {
        title:"TS",
        link:"",
    }
]

</script>

<template>
    <myHeader :active-nav="0"></myHeader>
    <div class="advs">毕业设计火热制作中</div>
    <div style="margin-top:50px">
        <searchHome></searchHome>
        <div class="commend-tag">
            <p style="color: #9E9E9E;">热招岗位:</p>
            <p v-for="item in commendTags" class="smart-tag">{{ item.title }}</p>
        </div>
    </div>
    
</template>

<style scoped lang='scss'>
.advs{
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
.commend-tag{
    font-size: 20px;
    display: flex;
    margin-left: 20vw;
}
.smart-tag{
    margin:0px 10px;
    padding:0px 10px;
    background-color: 06bdbc;
    color: rgba(255,255,255,.8);
    border-radius: 5px;
    &:hover{
        background-color: rgba(255,255,255,.8);
        color: 06bdbc;
    }
}
</style>
