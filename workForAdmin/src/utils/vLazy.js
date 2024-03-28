
export const vLazy = {
    mounted:(el, imgPath)=> {
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const imageUrl = new URL(`${imgPath.value}`, import.meta.url).href
                el.src = imageUrl;
                observer.unobserve(el);
            }
        });
    });

    observer.observe(el);
}
}