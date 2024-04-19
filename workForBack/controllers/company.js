const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const Company = require('../models/company')
const Admin = require('../models/admin')
const Mes = require('../models/message');
const useController = {
    uploadCompany:async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                
                let data = await User.isPermission(username)
                if (data.permission == 1) {
                    let userIdData = await User.searchId(username)
                    // console.log(req.body.introduction,userIdData.user_id);
                    let companyData=await Company.select('user_id',userIdData.user_id).first()
                    // console.log(companyData);
                    if(companyData.company_id){
                        await Company.updateCompany(userIdData.user_id,{introduction:req.body.introduction})
                    }else{
                        await Company.insert({introduction:req.body.introduction,user_id:userIdData.user_id})
                    }
                    // await Job.insert()
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
    GetCompany:async function (req, res, next) {
            try {
                // console.log(req.body);
                let companyData
                if(req.body?.user_id){
                    companyData=await Company.select('user_id',req.body.user_id).first()
                }else{
                    companyData=await Company.select('company_id',req.body.company_id).first()
                }
                    res.json({
                        code: 200,
                        message: "success",
                        data:companyData
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