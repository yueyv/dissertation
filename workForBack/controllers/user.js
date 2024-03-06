const { log } = require('../config')
const { update } = require('../models/jobs')
const User = require('../models/user')
const jwt = require('../utils/jwt')
const useController = {


    showUser:async function (req, res, next) {
        // console.log(req.headers.authorization);
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let userData = await User.safeInquire(username)

                res.json({
                    code: 200,
                    message: "success",
                    data:userData
                    // ss,sanitizedUserData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "超时", data: e })
        })
    },
    updateUser:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            try {
                let updateDate=req.body
                // console.log(updateDate);
                await User.update(username,updateDate)
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
            console.log(newData);
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
            res.json({ code: 202, message: "iderror", data: e })
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
                Permission:'0'
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