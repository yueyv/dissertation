// import { def } from '@vue/shared'
import axios, { Axios } from 'axios'
const axiosBase=axios.create({
    baseURL:"/api",
    timeout:2000
})
export  {axiosBase}