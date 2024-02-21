// 获取虚拟长列表缓加载
export function handleScroll(func: Function){
    // 获取页面的滚动高度、视口高度和页面内容高度
    const scrollHeight = window.pageYOffset || document.documentElement.scrollTop;
    const windowHeight = window.innerHeight || document.documentElement.clientHeight;
    const contentHeight = document.documentElement.scrollHeight;
    console.log(233);
    
    // 判断是否滚动到页面底部
    if (scrollHeight + windowHeight >= contentHeight) {
      // 执行触发事件的逻辑
      return function(this:unknown){
      
        func.apply(this,arguments)
      }
    }
  }
  