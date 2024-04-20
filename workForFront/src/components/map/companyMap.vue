<script setup>
import { BMarker, BZoom, BMap, BLocation } from 'vue3-baidu-map-gl'
import { ref, reactive, onUnmounted, watch } from 'vue'
import { useIpLocation } from 'vue3-baidu-map-gl'
import { message } from 'ant-design-vue';
import { useBrowserLocation } from 'vue3-baidu-map-gl'
import axios from '@/plugins/axiosBase.js'
const map = ref()
const { get, location, isLoading, isError, status } = useBrowserLocation(null, () => {
    map.value.resetCenter()
})
const uploadMap=()=>{
    axios.post('uploadLocation',{lat:location.value.point?.lat,lng:location.value.point?.lng}).then((res)=>{
        if(res.code==200){
            message.success("上传成功")
        }
    })
}
</script>

<template>
    <div>
        <div id="container">
            <div class="state" v-if="!isLoading && !isError">
                <h5>定位:</h5>
                <span>
                    城市 - {{ location.address?.province }}-{{ location.address?.city }}-{{ location.address?.district
                    }}-{{
                        location.address?.street
                    }}
                </span>
                <span>纬度 - {{ location.point?.lat }}</span>
                <span>经度 - {{ location.point?.lng }}</span>
                <br />
                <span>定位精度 - {{ location.accuracy }}m</span>
                <br>
                <a-button v-if="!isLoading" class="myButton" style="margin-right: 20px; margin-top: 10px;" @click="get">重新获取</a-button>
                <a-button  type="primary" ghost @click="uploadMap()">上传定位</a-button>
            </div>
            <div class="state" v-else-if="isError">出错了，{{ status }}</div>
            <div class="state" v-else>定位中...</div>

            <BMap ak='fvXwhpXgSaG95X7jzIXeNv73USX3fvGJ' v-bind="$attrs" enableScrollWheelZoom ref="map" @initd="get"
                :center="location.point || undefined">
                <template v-if="!isLoading">
                    <BMarker :position="location.point"></BMarker>
                    <BCircle strokeStyle="solid" strokeColor="#0099ff" :strokeOpacity="0.8" fillColor="#0099ff"
                        :fillOpacity="0.5" :center="location.point" :radius="location.accuracy" />
                    <BLocation />
                    <BZoom />
                </template>

            </BMap>
        </div>
    </div>
</template>

<style scoped lang='scss'>

.state{
    padding-top: 10px;
    line-height: 20px;
    text-align: center;
    background-color: aliceblue;
}
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