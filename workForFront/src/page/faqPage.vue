<script setup>
import { ref,reactive} from 'vue'
import myHeader from '../components/header/header.vue';

</script>

<template>
    <myHeader :active-nav="5"></myHeader>
    <div class="advs">使用说明及反馈</div>
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
</style>
