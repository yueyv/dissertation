import { def } from '@vue/shared'
import axios from 'axios'
const API=axios.create({
    baseURL:"http://114.132.50.228:3000",
    timeout:2000
})
export default API