export function throttle(func, wait) {
  let lastTime = 0;
  let timer;
  
  return function(...args) {
    const now = performance.now();
    const elapsed = now - lastTime;
    const context = this;
    
    if (timer) {
      clearTimeout(timer);
    }
    
    if (!lastTime || elapsed >= wait) {
      func.apply(context, args);
      lastTime = now;
    } else {
      timer = setTimeout(() => {
        func.apply(context, args);
        lastTime = performance.now();
        timer = undefined;
      }, wait - elapsed);
    }
  }
}
