<script setup>
import { ref,reactive} from 'vue'
import headerHome from '../components/header/header.vue';
</script>

<template>
    <headerHome></headerHome>
    <box class="text">22</box>
</template>

<style scoped lang='scss'>
.text{
    color: aqua;
    height: 20vh;
    width: 20vw;
    background-color: green;
    position: fixed;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
}
</style>
