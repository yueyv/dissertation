<script setup>
import { computed } from "vue";
import { VideoCamera, Monitor } from "@element-plus/icons-vue";
/**
 * ------------数据层------------
 */
const props = defineProps({
  videoingid: { type: String, required: true },
  desktopingid: { type: String, required: true }
});
const videoUsername = computed(() => {
  if (props.videoingid === "") {
    return "空闲";
  } else {
    return props.videoingid;
  }
});
const desktopUsername = computed(() => {
  if (props.desktopingid === "") {
    return "空闲";
  } else {
    return props.desktopingid;
  }
});
</script>

<template>
  
  <div class="tabs">
        <slot name="video"></slot>
        <slot name="desktop"></slot>
  </div>
</template>

<style lang="less" scoped>
.tabs {
  width: 100%;
  height: 100%;
}
</style>
