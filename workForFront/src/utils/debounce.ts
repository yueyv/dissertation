export function debounce(func: Function, delay: number): Function {
  // 计时器
  let time: ReturnType<typeof setTimeout> | undefined;

  return function(this:unknown) {
    const context = this;
    const args = arguments;
    // 如果存在就清除计时器
    if (time) {
      clearTimeout(time);
    }
    // 设定计时器
    time = setTimeout(() => {
      func.apply(context, args);
    }, delay);
  };
}


