<template>
  <div>
    <router-view v-slot="{ Component }">
      <Suspense>
        <div>
          <component :is="Component" />
        </div>
      </Suspense>
    </router-view>
  </div>
</template>

<script  setup>
</script>
<style lang="scss">
@import '@/assets/reset.css';
/* @import 'uno.css'; */
/* @import 'ant-design-vue/dist/antd.css'; */

</style>
