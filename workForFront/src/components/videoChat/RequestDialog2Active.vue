<script setup>
import { computed } from "vue";
/**
 * ------------数据层------------
 */
const props = defineProps({
  isShow: { type: Boolean, required: true },
  // 请求弹框类型
  type: { type: String, required: true }
});
const emit = defineEmits(["close"]);
const message = computed(() => {
  if (props.type === "video") {
    return "您正在请求视频会话，等待对方回应...";
  } else if (props.type === "desktop") {
    return "您正在请求远程桌面，等待对方回应...";
  } else {
    throw new Error("unknow type.");
  }
});
/**
 * ------------事件监听处理------------
 */
const cancelBtnHandler = () => {
  emit("close");
};
</script>

<template>
  <div class="dialog-active">
    <el-dialog :modelValue="props.isShow" title="提示" width="30%" :close-on-click-modal="false" :show-close="false">
      <span>{{ message }}</span>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="cancelBtnHandler">取消</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style lang="less" scoped>
.dialog-active {
  :deep(.el-dialog) {
    .el-dialog__title {
      // color: red;
      font-size: 24px;
    }
    .el-dialog__body {
      // color: red;
      font-size: 18px;
    }
    .el-button {
      // color: red;
      font-size: 18px;
    }
  }
}
</style>
