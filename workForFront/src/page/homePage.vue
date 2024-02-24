<script setup>
import { ref,reactive} from 'vue'
import headerHome from '../components/header/header.vue';
import searchHome from '../components/search/index.vue'
</script>

<template>
    <headerHome :active-nav="0"></headerHome>
    <searchHome></searchHome>
</template>

<style scoped lang='scss'>

</style>
