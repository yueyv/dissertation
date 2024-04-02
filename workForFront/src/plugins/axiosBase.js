import axios from 'axios';
const productionURL=()=>{
    if(process.env.NODE_ENV === 'production'){
        return  {
            baseURL: "http://20.213.10.238:3000/api",
            timeout: 20000
        }
    }else{
        return {
            baseURL: "/api",
            timeout: 20000
        }
    }
}
const axiosBase = axios.create(productionURL());

// 请求拦截器
axiosBase.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) {
        config.headers.Authorization = JSON.parse(token);
    }
    console.log('配置请求拦截器....');
    return config;
}, (error) => {
    return Promise.reject(error);
});

// 响应拦截器
axiosBase.interceptors.response.use(
    response => {
        if (response.status === 200) {
            return response.data;
        } else {
            return Promise.reject();
        }
    },
    error => {
        console.log(error);
        return Promise.reject();
    }
);

export default axiosBase;
export {axiosBase}
