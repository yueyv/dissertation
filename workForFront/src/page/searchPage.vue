<script setup>
import { ref,reactive} from 'vue'
import headerSearch from '../components/header/header.vue';
import search from '../components/search/index.vue'   

</script>

<template>
<headerSearch :active-nav="2"></headerSearch>
<search></search>
</template>

<style scoped lang='scss'>

</style>