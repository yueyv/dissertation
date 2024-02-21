import { defineStore } from "pinia";
import {getCity,getIP} from '../hooks/useGetCity.js'
import  Names  from "./store-name";


function login(){
    if ((sessionStorage.getItem("userId")?.length ?? 1) <= 2 || (sessionStorage.getItem("userId")?.length ?? 51) >= 50) {
        if (sessionStorage.getItem('userId')) {
            sessionStorage.removeItem("userId")
        }
    }

    return window.atob(JSON.parse(sessionStorage.getItem("userId") ?? JSON.stringify({ "token": `${window.btoa("Not logined in")}` })).token)
}
const useUserStore = defineStore(Names.USER, {
    state: () => {
        return {
            id:"未登录"
        }
    },
    //computed 计算修饰
    getters: {
        getUserId(){
            return this.user.id
        }
    },
    //mothods 做同步和异步 
    actions: {
        async setUser() {
            const result= await login()         
            this.setUserId(result)
        },
        setUserId(userId){        
            this.user.id=userId
        }
    }
})
const useIPStore=defineStore(Names.IP,{
    state:()=>({
       ip:'127.0.0.1'
    }),
    getters:{
 
    },
    actions:{
        async useGetIP(){
            this.ip=await getIP()
        }
    },
    persist: {
        // 修改存储中使用的键名称，默认为当前 Store的 id
        // key: 'storekey',
        // 修改为 sessionStorage，默认为 localStorage
        storage: window.sessionStorage,
        // 部分持久化状态的点符号路径数组，[]意味着没有状态被持久化(默认为undefined，持久化整个状态)
        // paths: ['nested.data'],
      },
})
export {useIPStore,useUserStore}