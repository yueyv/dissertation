import axios from 'axios';

const axiosBase = axios.create({
    baseURL: "/api",
    timeout: 5000
});

// 请求拦截器
axiosBase.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) {
        config.headers.Authorization = token;
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
