type Options = {
    el: string
}
import { onMounted } from "vue"

export default function (options: Options):Promise<{baseUrl:string}> {
    const base64 = (el: HTMLImageElement) => {
        const canvas = document.createElement('canvas')
        const ctx = canvas.getContext("2d")
        canvas.width = el.width
        canvas.height = el.height
        ctx?.drawImage(el, 0, 0, canvas.width, canvas.height)
        return canvas.toDataURL("/image/jpg")
    }
    return new Promise((resolve) => {
        onMounted(() => {
            let img: HTMLImageElement = document.querySelector(options.el) as HTMLImageElement
            img.onload = () => {
                resolve({
                    baseUrl:base64(img)
                })
            }
        })
    })
    
}