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
       ip:'127.0.0.1',
       city:"定位中",
    }),
    getters:{
 
    },
    actions:{
        async useGetIP(){
            this.ip=await getIP()
        },
        async useGetCity(){     
            this.city=await getCity(this.ip);
        },
        async manualUpdateCity(newCity){
            this.city=newCity
        },
    },
    // SSR 省略
    // persist: {
    //     storage: window.sessionStorage,
    //   },
})
const useChatStore=defineStore(Names.CHAT,{
    state:()=>({
       status:false,
    }),
    getters:{
 
    },
    actions:{
        async statusChangeFalse(){
            this.status=false
        },
        async statusChangeTrue(){
            this.status=true
        },
        async statusChange(){
            this.status=!this.status
        },
    },
    // SSR 省略
    // persist: {
    //     storage: window.sessionStorage,
    //   },
})
export {useIPStore,useUserStore,useChatStore}