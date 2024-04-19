<script setup>
import { BMarker, BZoom, BMap, BLocation } from 'vue3-baidu-map-gl'
import { ref, reactive, onUnmounted,watch } from 'vue'
import { useIpLocation } from 'vue3-baidu-map-gl'
import { useIPStore } from '../../store/index.js'
import { message } from 'ant-design-vue';
const ipStore = useIPStore()
const { useGetIP, useGetCity, manualUpdateCity } = ipStore
const map = ref()
const { get, location, isLoading } = useIpLocation(() => {
    map.value.resetCenter()
    if (location.value) {
        message.info(`城市已切换为：${location.value.name}`)
        sessionStorage.setItem("userIP",JSON.stringify(location.value.name))
        manualUpdateCity(location.value.name)
    }
})
// watch(location, () => {
//     if (location.value) {
//         message.info(`城市已切换为：${location.value.name}`)
//         manualUpdateCity(location.value.name)
//     }

// })
// const closeTag =()=>{
//     manualUpdateCity(location.value.name)
//     // message.info(location.value.name)
// }
// const script = document.createElement('script');
// script.src = '//api.map.baidu.com/api?type=webgl&v=1.0&ak=fvXwhpXgSaG95X7jzIXeNv73USX3fvGJ';
// script.onload = () => {
// // 初始化地图
// let map = new BMapGL.Map('container');
// // 设置地图中心点和缩放级别
// map.centerAndZoom('上海市', 12);
// map.enableScrollWheelZoom(true); // 开启鼠标滚轮缩放
// 添加控件等其他操作
// };
// document.body.appendChild(script);

// onUnmounted(() => {
//     // 销毁地图
//     if (map) {
//         map.clearOverlays();
//         map = null;
//     }
// }) 
// const IPLocation = () => {
//     message.info(223)
// }
</script>

<template>
    <div>
        <!-- <a-button class="cityButton" @click="closeTag()" v-if="!isLoading">
            当前城市为：{{ location.name }},点击关闭
        </a-button> -->
        <BMap enableScrollWheelZoom ref="map" :center="location.point || undefined" @initd="get" id="container"
            ak='fvXwhpXgSaG95X7jzIXeNv73USX3fvGJ' :plugins="['TrackAnimation']">
            <BLocation />
            <BZoom />
            <div v-if="!isLoading">
                <BMarker :position="location.point"></BMarker>
            </div>
        </BMap>
    </div>
</template>

<style scoped lang='scss'>
// .cityButton {
//     position: fixed;
//     left: 50%;
//     z-index: 999;
//     top: 15vh;
//     transform: translate(-50%,0);
// }

#container {
    position: fixed;
    left: 50%;
    top: 50%;
    border-radius: 20px;
    overflow: hidden;
    z-index: 2000;
    transform: translate(-50%, -50%);
    // overflow: hidden;
    width: 60vw;
    // height: 60vh;
    // margin: 0;
    font-family: "微软雅黑";
}
</style>