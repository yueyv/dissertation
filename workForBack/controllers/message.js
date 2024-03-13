const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Mes=require('../models/message')
const useController = {
    getChat:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let userIdData = await User.searchId(username)
                let chatData=await Mes.selectChat(userIdData.user_id, req.body.chatWith)
                // if(data.Permission==1)
                res.json({
                    code: 200,
                    message: "success",
                    data:chatData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    chatDelete: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            try {
                let IdData = await User.getChatId(username)
                console.log(req.body);

                if (IdData.chat_id != null) {
                    let chat_id = IdData.chat_id.split(",")
                    console.log(chat_id);
                    let new_chat_id=(chat_id.filter(item => item != req.body.delete_id)).toString();
                    console.log(new_chat_id);
                    await User.update(username,{chat_id:new_chat_id})
                    res.json({
                        code: 200,
                        message: "success",
                    })
                } else {
                    res.json({
                        code: 202,
                        message: "noChat",
                    })
                }
                // if(data.Permission==1)

            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
}
module.exports = useController