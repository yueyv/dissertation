const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Company = require('../models/company')
const Admin = require('../models/admin')
const Mes = require('../models/message');
const Location = require('../models/location');
const useController = {
    uploadLocation:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                
                let data = await User.isPermission(username)
                if (data.permission == 1) {
                    let userIdData = await User.searchId(username)

                    await Location.insert({user_id:userIdData.user_id,lat:req.body.lat,lng:req.body.lng})
                    res.json({
                        code: 200,
                        message: "success",
                    })
                } else {
                    res.json({ code: -1, message: "权限不足", data: e })
                }

            } catch (e) {
                console.log(e);
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    GetLocation:async function (req, res, next) {
            try {
                // console.log(req.body);
               let locationData=await Location.select('user_id',req.body.user_id).orderBy('location_id', 'desc').first()
                    res.json({
                        code: 200,
                        message: "success",
                        data:locationData
                    })
            } catch (e) {
                console.log(e);
                res.json({ code: 0, message: "default", data: e })
            }
        
    },
    searchCompany:async function (req, res, next) {
        try {
            // console.log(req.body);
            let companyData=await Company.select('user_id',req.body.user_id).select("company_id").first()
            console.log(companyData);
                res.json({
                    code: 200,
                    message: "success",
                    data:companyData.company_id
                })
        } catch (e) {
            console.log(e);
            res.json({ code: 0, message: "default", data: e })
        }
    
},
}
module.exports = useController