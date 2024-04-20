<script setup>
import { BMarker, BZoom, BMap, BLocation } from 'vue3-baidu-map-gl'
import { ref, reactive, onUnmounted,watch } from 'vue'
import { useIpLocation } from 'vue3-baidu-map-gl'
import { useIPStore } from '../../store/index.js'
import { message } from 'ant-design-vue';
import axios from '@/plugins/axiosBase.js'
const map = ref()
const { user_id } = defineProps(['user_id']) 
const location=ref({
    point:{
        lat:0,
        lng:0
    }
})
axios.post('GetLocation',{user_id:user_id}).then((res)=>{
    if(res.code==200){
        location.value.point.lat=res.data.lat
        location.value.point.lng=res.data.lng
    }
})
</script>

<template>
    <div>

        <BMap enableScrollWheelZoom ref="map" :center="location.point || undefined"  id="container"
            ak='fvXwhpXgSaG95X7jzIXeNv73USX3fvGJ' :plugins="['TrackAnimation']">
            <BLocation  />
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