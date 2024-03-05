module.exports = {
    apps : [{
      kill_timeout: 5000,
      wait_ready: true,
      watch: false, // 是否监听文件改动，而重新启动服务
      name   : "SSR", // 启动项目的别名
      // interpreter:"./node_modules/.bin/ts-node",
      args : "./server/index.js", // 项目的启动文件
      env:{
        NODE_ENV:"production",
        PORT:3000,
      }
    }]
  }