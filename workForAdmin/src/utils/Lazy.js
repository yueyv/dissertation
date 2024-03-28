// 获取所有带有 "lazy" 类的图片元素
const lazyImages = document.querySelectorAll('.lazy');
// 当图片加载完成
const imgOnLoad=(img)=>{
    img.style="opacity:1";
    img.parentNode.classList.remove("double-ringed");
    console.log(img.parentNode);
}
// 懒加载事件
const observer = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const img = entry.target;
      img.src = img.dataset.src;
    //   console.log(img.dataset.src);
      img.classList.remove('lazy');
      img.onload=()=>{
        imgOnLoad(img);
      }
      observer.unobserve(img);
      
    }
  });
});
const option={
    root:document,
    // 提前观察可以使用这个参数
    // rootMargin:'',
    threshold:[0.2],
}
// 遍历所有图片元素并开始观察
lazyImages.forEach(img => {
  observer.observe(img);
});
