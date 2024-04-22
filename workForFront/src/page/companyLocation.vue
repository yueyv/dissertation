<script setup>
import { ref,reactive} from 'vue'
import getCompanyMap from "@/components/map/getCompanyMap.vue";
import myHeader from '@/components/header/header.vue';
const isShowMap2=ref(false)
import { useRoute, useRouter } from 'vue-router';
const route = useRoute()
const router = useRouter()
const user_id=ref(route.params.id)
const showMap2 = () => { 
    isShowMap2.value = !isShowMap2.value
    router.go(-1)
 }
</script>

<template>
      <myHeader :active-nav="0"></myHeader>
    <a-button  danger ghost @click="showMap2()" class="close-map">关闭地图并返回</a-button>
    <getCompanyMap :user_id="user_id"></getCompanyMap>
</template>

<style scoped lang='scss'>
.close-map {
  position: fixed;
  left: 75%;
  z-index: 9999;
  top: 15vh;
  transform: translate(-50%, 0);
}
</style>