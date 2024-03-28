const { log } = require('../config')
const { update } = require('../models/jobs')
const User = require('../models/user')
const fs = require('fs');
const jwt = require('../utils/jwt');
const Job = require('../models/jobs')
const Mes = require('../models/message');
const useController = {
    getApplyJob: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let data = await User.getApplyJob(username)
                let resData = []
                if (data?.job_id !== undefined && data?.job_id !== "") {
                    const job_id = data?.job_id.split(",")
                    await Promise.all(job_id.map(async (item) => {
                        // console.log(item);
                        let jobData = await Job.select("job_id", item);
                        resData.push(...jobData);
                        // console.log(jobData);
                        // console.log(resData);
                    }));
                    // console.log(resData);
                    res.json({
                        code: 200,
                        message: "success",
                        data: resData
                    });
                } else {
                    res.json({
                        code: 200,
                        message: "success",
                        data: resData
                    });
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
    getChatId: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let IdData = await User.getChatId(username)
                // console.log(IdData.chat_id);
                let data = []
                if (IdData.chat_id != null) {
                    let chat_id = IdData.chat_id.split(",")
                    // console.log(chat_id);
                    await Promise.all(chat_id.map(async (item) => {
                        // console.log(item,IdData.user_id);
                        let chatUsername = await User.getUserName(item)
                        let readStatus = await Mes.selectUnreadChat(item,IdData.user_id)
                        // console.log(readStatus);
                        data.push([item, chatUsername.username,readStatus])
                        
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

            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getPermission: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let data = await User.isPermission(username)
                // if(data.Permission==1)
                res.json({
                    code: 200,
                    message: "success",
                    data: data
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    isExistUpload: async function (req, res, next) {
        // console.log(req.headers.authorization);
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let userData = await User.searchIsUpload(username)
                let isExistUpload
                if (userData.apply_filename != null) {
                    isExistUpload = true
                } else {
                    isExistUpload = false
                }
                res.json({
                    code: 200,
                    message: "success",
                    isExistUpload: isExistUpload
                    // ss,sanitizedUserData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    // IM 使用文件系统
    upload_apply: async function (req, res, next) {
        // console.log(req.headers.authorization);
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            try {
                await User.update(username, {
                    apply_filename: req.file.originalname
                })
                const returnData = await User.searchId(username)
                // console.log(returnData.user_id);
                // console.log(req.file);
                // const bufferData = Buffer.from(req.file.butter, 'binary');
                // console.log(bufferData);
                // const convertedString = bufferData.toString('utf-8');
                // console.log(convertedString);
                try {
                    fs.writeFileSync(`./file/${returnData.user_id}_${req.file.originalname}`, req.file.buffer);
                    // console.log(233);
                } catch (err) {
                    console.error('Error saving file:', err);
                }
                // console.log(req.file);
                res.json({
                    code: 200,
                    message: "success",
                    data: null
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            console.log(e);
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    showUser: async function (req, res, next) {
        // console.log(req.headers.authorization);
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let userData = await User.safeInquire(username)

                res.json({
                    code: 200,
                    message: "success",
                    data: userData
                    // ss,sanitizedUserData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    showUserFromId: async function (req, res, next) {
        // console.log(req.headers.authorization);
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                console.log(req.body.user_id);
                let userData = await User.select("user_id", req.body.user_id)

                res.json({
                    code: 200,
                    message: "success",
                    data: userData
                    // ss,sanitizedUserData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    updateUser: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            try {
                let updateDate = req.body
                // console.log(updateDate);
                await User.update(username, updateDate)
                res.json({
                    code: 200,
                    message: "success",
                })
            } catch (e) {
                res.json({ code: -1, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    login: async function (req, res, next) {
        try {
            // console.log(req);

            let username = req.body.account
            let pwd = req.body.password
            let userData = await User.inquire(username)
            let data = JSON.parse(JSON.stringify(userData))
            const newData = { ...data }['0']
            // console.log(newData);
            if (newData.password == pwd) {
                const params = {
                    username: `${username}`,
                    password: `${pwd}`,
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
    register: async function (req, res, next) {
        try {
            // console.log(req);
            let username = req.body.account
            let pwd = req.body.password
            // console.log(req.query.id)
            const params = {
                username: `${username}`,
                password: `${pwd}`,
                Permission: '0'
            }
            await User.insert(params)
            let jwtToken = jwt.sign(params)
            // console.log(jwtToken);
            res.json({
                code: 200,
                message: "success",
                data: `${jwtToken}`,
            })
        } catch (e) {
            console.log(e)
            res.json({ code: 202, message: "iderror,已存在", data: {} })
        }
    }
}
module.exports = useController