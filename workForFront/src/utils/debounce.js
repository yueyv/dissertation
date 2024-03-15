export function debounce(func, delay) {
  // 计时器
  let time;

  return function() {
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
