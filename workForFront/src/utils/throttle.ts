export function throttle(func: Function, wait: number): Function {
    let lastTime = 0;
    let timer: ReturnType<typeof setTimeout> | undefined;
    
    return function(this: unknown, ...args: any[]) {
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
  