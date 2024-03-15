const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Admin = require('../models/admin')
const Mes=require('../models/message');
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
                    username: `${username}`,
                    password: `${pwd}`,
                    admin:true
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
}
module.exports = useController