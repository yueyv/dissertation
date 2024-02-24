<script setup>
import { ref,reactive} from 'vue'
import headerSearch from '../components/header/header.vue';
import search from '../components/search/index.vue'   

</script>

<template>
<headerSearch :active-nav="2"></headerSearch>
<div class="advs">检索岗位</div>
<div style="margin-top:50px">
<search></search>
<div>筛选</div>
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
</style>