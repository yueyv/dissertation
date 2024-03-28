
import { onMounted } from "vue"

export default function (options) {
    const base64 = (el) => {
        const canvas = document.createElement('canvas')
        const ctx = canvas.getContext("2d")
        canvas.width = el.width
        canvas.height = el.height
        ctx?.drawImage(el, 0, 0, canvas.width, canvas.height)
        return canvas.toDataURL("/image/jpg")
    }
    return new Promise((resolve) => {
        onMounted(() => {
            let img= document.querySelector(options.el) 
            img.onload = () => {
                resolve({
                    baseUrl:base64(img)
                })
            }
        })
    })
    
}