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
    <el-tabs type="border-card" class="demo-tabs">
      <el-tab-pane>
        <template #label>
          <span class="custom-tabs-label">
            <el-icon><VideoCamera /></el-icon>
            <span>视频会话</span>
            <span>({{ videoUsername }})</span>
          </span>
        </template>
        <slot name="video"></slot>
      </el-tab-pane>
      <el-tab-pane>
        <template #label>
          <span class="custom-tabs-label">
            <el-icon><Monitor /></el-icon>
            <span>桌面会话</span>
            <span>({{ desktopUsername }})</span>
          </span>
        </template>
        <slot name="desktop"></slot>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<style lang="less" scoped>
.tabs {
  height: calc(100vh - 82px);
  :deep(.el-tabs) {
    height: 100%;
    display: flex;
    flex-direction: column;
    .el-tabs__header {
      .el-tabs__item {
        padding: 30px;
        font-size: 24px;

        .custom-tabs-label {
          display: flex;
          align-items: center;
          gap: 10px;
        }
      }
    }

    .el-tabs__content {
      box-sizing: border-box;
      background-color: #008e59;
      padding: 10px;
      flex: 1;

      .el-tab-pane {
        width: 100%;
        height: 100%;
      }
    }
  }
}
</style>
