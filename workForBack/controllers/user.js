const User = require('../models/user')
const jwt=require('../utils/jwt')
const useController = {
    showUser: async function (req, res, next) {
        try {
            let userData = await User.all()
            res.json({
                code: 200,
                message: "success",
                data: userData
            })
        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }

    },
    login: async function (req, res, next) {
        try {
            let id = req.body.account
            let pwd = req.body.password
            let userData = await User.inquire(id)
            let data = JSON.parse(JSON.stringify(userData))
            const newData = { ...data }['0']
            const useId = Buffer.from(newData.id, 'utf-8').toString('base64')
            if (newData.password == pwd) {
                res.json({
                    code: 200,
                    message: "success",
                    data: {
                        token: `${useId}`
                    }
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
            }
            await User.insert(params)
            let jwtToken=jwt.sign(params)
            console.log(jwtToken);
            res.json({
                code: 200,
                message: "success",
                data: {
                    username:`${username}`,
                    token: `${jwtToken}`
                }
            })
        } catch (e) {
            console.log(e)
            res.json({ code: 202, message: "iderror,已存在", data: {}})
        }
    }
}
module.exports = useController