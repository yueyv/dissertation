const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Admin = require('../models/admin')
const Mes = require('../models/message');
const { promises } = require('dns');
const useController = {
    adminLogin: async function (req, res, next) {
        try {
            let username = req.body.account
            let pwd = req.body.password
            let userData = await Admin.inquire(username)
            // console.log(req.body);
            let data = JSON.parse(JSON.stringify(userData))
            const newData = { ...data }['0']
            // console.log(newData);
            if (newData.password == pwd) {
                const params = {
                    username: "客服",
                    adminName: `${username}`,
                    admin: true
                }
                let jwtToken = jwt.sign(params)
                res.json({
                    code: 200,
                    message: "success",
                    data: `${jwtToken}`
                })
            } else {
                res.json({
                    code: 202,
                    message: 'pwderrow',
                    data: {
                    }
                })
            }

        } catch (e) {
            res.json({ code: 300, message: "iderror,重试", data: e })
        }
    },
    getChatAdmin: async function (req, res, next) {
        jwt.adminVerify(req.headers.authorization).then(async admin => {
            if (admin) {
                try {
                    let userIdData = await User.searchId("admin")
                    let chatData = await Mes.selectChat(userIdData.user_id, req.body.chatWith)
                    // if(data.Permission==1)
                    res.json({
                        code: 200,
                        message: "success",
                        data: chatData
                    })
                } catch (e) {
                    res.json({ code: 300, message: "default", data: e })
                }
            } else {
                res.json({ code: 500, message: "验证错误", data: e })
            }

        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getChatIdAdmin: async function (req, res, next) {
        jwt.adminVerify(req.headers.authorization).then(async admin => {
            if (admin) {
                try {
                    let IdData = await User.getChatId("admin")
                    // console.log(IdData.chat_id);
                    let data = []
                    if (IdData.chat_id != null) {
                        let chat_id = IdData.chat_id.split(",")
                        // console.log(chat_id);
                        await Promise.all(chat_id.map(async (item) => {
                            let chatUsername = await User.getUserName(item)
                            data.push([item, chatUsername.username])
                        }))
                        res.json({
                            code: 200,
                            message: "success",
                            data: data
                        })
                    } else {
                        res.json({
                            code: 202,
                            message: "noChat",
                            data: data
                        })
                    }
                    // if(data.Permission==1)
                }
                catch (e) {
                    res.json({ code: 0, message: "default", data: e })
                }
            }
            else {
                res.json({ code: 500, message: "验证错误", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getAllUser: async function (req, res, next) {
        jwt.adminVerify(req.headers.authorization).then(async admin => {
            if (admin) {
                try {
                    let userData = await User.all()
                    // console.log(IdData.chat_id);

                    res.json({
                        code: 200,
                        message: "success",
                        data: userData
                    })
                }
                // if(data.Permission==1)

                catch (e) {
                    res.json({ code: 0, message: "default", data: e })
                }
            }
            else {
                res.json({ code: 500, message: "验证错误", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getAllJob: async function (req, res, next) {
        jwt.adminVerify(req.headers.authorization).then(async admin => {
            if (admin) {
                try {
                    let jobData = await Job.all()
                    // console.log(IdData.chat_id);

                    res.json({
                        code: 200,
                        message: "success",
                        data: jobData
                    })
                }
                // if(data.Permission==1)

                catch (e) {
                    res.json({ code: 0, message: "default", data: e })
                }
            }
            else {
                res.json({ code: 500, message: "验证错误", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    }
}
module.exports = useController