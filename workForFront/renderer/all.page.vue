<template>
  <div class="main-bg-color">
    <router-view v-slot="{ Component }">
      <Suspense>
        <div>
          <component :is="Component" />
        </div>
      </Suspense>
    </router-view>
  </div>
</template>

<script >

</script>
<style lang="scss">
@import '@/assets/reset.css';
/* @import 'uno.css'; */
/* @import 'ant-design-vue/dist/antd.css'; */
.main-bg-color{
    display: block;
    min-height: 100vh;
    background-image: linear-gradient(200deg, #80d0c7, #13547a);
}
</style>
