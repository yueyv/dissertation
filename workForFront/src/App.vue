<script setup>
</script>

<template>
    <box class="main-bg-color">
        <router-view></router-view>
    </box>
</template>

<style lang="scss">
.main-bg-color{
    display: block;
    min-height: 100vh;
    background-image: linear-gradient(200deg, #80d0c7, #13547a);
}
</style>
