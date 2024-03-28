<script>
import { ConfigProvider } from "ant-design-vue";
import zhCN from "ant-design-vue/lib/locale/zh_CN";

export default {
  components: {
    ConfigProvider
  },
  data() {
    return {
      locale: zhCN
    };
  }
};
</script>

<template>
  <ConfigProvider :locale="locale">
    <div class="main-bg-color">
      <router-view></router-view>
    </div>
  </ConfigProvider>
</template>

<style lang="scss">
.main-bg-color {
  display: block;
  min-height: 100vh;
  background-image: linear-gradient(200deg, #80d0c7, #13547a);
}
</style>
