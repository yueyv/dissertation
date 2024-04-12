import { defineStore } from "pinia";
import {getCity,getIP} from '../hooks/useGetCity.js'
import {message} from 'ant-design-vue'
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
const useVideoChatStore = defineStore(Names.VIDEOCHAT, {
  state: () => ({
    // 多媒体管理器
    multimediaManager: null,
    // 是否与服务器连接
    isServerConnect: false
  }),
  actions: {
    // 初始化多媒体管理器
    initMultimediaManager() {
      GlobalUtil.setUseWss(true);
      this.multimediaManager = MultimediaManagerFactory.GetSingleton();
      this.multimediaManager.SetCameraVideoSize(1280, 720);
      this.multimediaManager.SetMaxCameraFrameRate(15);
      this.multimediaManager.SetCameraEncodeQuality(15);
      // 设置与媒体服务器连接断开事件
      this.multimediaManager.ConnectionInterrupted = () => {
        console.log("设置与媒体服务器连接断开事件");
        this.isServerConnect = false;
      };
      // 设置与媒体服务器连接重连成功事件
      this.multimediaManager.ConnectionRebuildSucceed = () => {
        console.log("设置与媒体服务器连接重连成功事件");
        this.isServerConnect = true;
      };
      this.multimediaManager.SetBeingKickedOut(() => {
        message.info("你已被强制下线");
        localStorage.removeItem("H5MediaUser");
        location.reload();
      });
      this.multimediaManager.SetBeingPushedOut(() => {
        message.info("在别处登录");
        localStorage.removeItem("H5MediaUser");
        location.reload();
      });
    },
    // 更新与服务器连接状态
    updateServerConnect(value) {
      this.isServerConnect = value;
    },
    // 设置自定义消息处理回调
    setCustomMessageReceivedCallback(callback) {
      this.multimediaManager.SetCustomMessageReceivedCallback(callback);
    }
  }
});

export {useIPStore,useUserStore,useVideoChatStore}