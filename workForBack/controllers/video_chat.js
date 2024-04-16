const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Vc=require('../models/video_chat');
// const { promises } = require('dns');
const videoChatController = {
    videoChatTo:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
            //    console.log(username,req.body.to_name);
                try {
                   await Vc.insert({username:username,to_username:req.body.to_name,status:1})
                } catch (error) {
                    console.log(error);
                }
                
                // if(data.Permission==1)
                res.json({
                    code: 200, message: "success",
                  })
            } catch (e) {
                console.log(e);
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    videoChatSearch:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let videoChatStatus=await Vc.select('to_username',username).orderBy('rtc_id', 'desc').first()
                console.log(videoChatStatus?.status);
                if(videoChatStatus?.status==1){
                    res.json({
                        code: 200, message: "success",data:true,from_username:videoChatStatus.username,
                      })
                }else{
                    res.json({
                        code: 200, message: "success",data:false,
                      })
                }
                // if(data.Permission==1)
                
            } catch (e) {
                console.log(e);
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    videoChatOver:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
            //    console.log(username,req.body.to_name);
                try {
                   await Vc.updateVc(username,{status:0})
                } catch (error) {
                    console.log(error);
                }
                
                // if(data.Permission==1)
                res.json({
                    code: 200, message: "success",
                  })
            } catch (e) {
                console.log(e);
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
}
module.exports = videoChatController