<script setup>
import { computed } from "vue";
/**
 * ------------数据层------------
 */
const props = defineProps({
  isShow: { type: Boolean, required: true },
  // 请求弹框类型
  type: { type: String, required: true },
  // 请求者的用户名
  username: { type: String, required: true }
});
const emit = defineEmits(["videoResolve", "videoReject", "desktopResolve", "desktopReject"]);
// 显示的信息
const message = computed(() => {
  let msg = "";
  if (props.type === "video") {
    msg = "对方发起视频会话请求";
  } else if (props.type === "desktop") {
    msg = "对方请求控制您的桌面";
  } else {
    throw new Error("unknow type.");
  }
  return msg;
});

/**
 * ------------事件处理层------------
 */
// 接听视频会话请求
const videoResolveHandler = () => {
  emit("videoResolve");
};
// 挂断视频会话请求
const videoRejectHandler = () => {
  emit("videoReject");
};

// 接受桌面分享请求
const desktopResolveHandler = () => {
  emit("desktopResolve");
};
// 拒绝桌面分享请求
const desktopRejectHandler = () => {
  emit("desktopReject");
};
</script>

<template>
  <div class="dialog-passive">
    <el-dialog :modelValue="props.isShow" width="30%" :close-on-click-modal="false" :show-close="false">
      <p class="name">{{ props.username }}</p>
      <p class="msg">{{ message }}</p>
      <!-- 桌面 -->
      <div v-if="props.type === 'desktop'" class="desktop-btns">
        <div class="reject-btn" @click="desktopRejectHandler">拒绝</div>
        <div class="resolve-btn" @click="desktopResolveHandler">接受</div>
      </div>
      <!-- 视频 -->
      <div v-else class="video-btns">
        <div class="reject-btn" @click="videoRejectHandler">
          <span class="iconfont icon-reject"></span>
          <span>挂断</span>
        </div>
        <div class="resolve-btn" @click="videoResolveHandler">
          <span class="iconfont icon-resolve"></span>
          <span>接听</span>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<style lang="less" scoped>
.dialog-passive {
  :deep(.el-dialog) {
    .el-dialog__header {
      margin: 0;
      padding: 0;
    }

    .el-dialog__body {
      display: flex;
      flex-direction: column;
      align-items: center;
      padding: 2.6042vw 0;
      img {
        width: 9.375vw;
        height: 9.375vw;
        border-radius: 100%;
        box-sizing: border-box;
        box-shadow: 0 0 0.1563vw #666;
      }

      .name {
        font-size: 2.0833vw;
        margin: 1.5625vw 0 0.5208vw 0;
      }

      .msg {
        font-size: 1.25vw;
      }

      .desktop-btns {
        margin-top: 2.6042vw;
        display: flex;
        justify-content: center;
        gap: 3.125vw;
        font-size: 1.25vw;
        color: #fff;

        div {
          padding: 0.5208vw 2.0833vw;
          cursor: pointer;
          box-sizing: border-box;
          border: 0.1042vw solid #000;
          transition: all 0.2s;
        }
        .reject-btn {
          background-color: #ff0000;
        }

        .reject-btn:hover {
          background-color: #ff5555;
        }

        .resolve-btn {
          background-color: #008000;
        }

        .resolve-btn:hover {
          background-color: #558055;
        }
      }

      .video-btns {
        margin-top: 2.6042vw;
        display: flex;
        justify-content: center;
        gap: 5.2083vw;
        font-size: 1.25vw;

        > div {
          cursor: pointer;
          display: flex;
          flex-direction: column;
          text-align: center;
          gap: 0.4167vw;
          font-size: 1.25vw;
        }
        .iconfont {
          font-size: 2.0833vw;
          color: #fff;
          box-shadow: 0 0 3px #666;
          transition: all 0.2s;
          width: 4.5833vw;
          height: 4.5833vw;
          display: flex;
          justify-content: center;
          align-items: center;
          border-radius: 100%;
        }

        .icon-reject {
          background-color: #ff0000;
        }

        .icon-reject:hover {
          background-color: #ff5555;
        }

        .icon-resolve {
          background-color: #008000;
        }

        .icon-resolve:hover {
          background-color: #558055;
        }
      }
    }
  }
}
</style>
