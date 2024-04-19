const Job = require('../models/jobs')
const fs = require('fs');
const jwt = require('../utils/jwt');
const User = require('../models/user')
const useController = {
    addJob: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let data = await User.isPermission(username)
                if (data.permission == 1) {
                    let userIdData = await User.searchId(username)
                    // console.log(userIdData.user_id);
                    const params = {
                        user_id: userIdData.user_id, ...req.body, vaild: 0
                    }
                    await Job.insert(params)
                    console.log(params);
                    // await Job.insert()
                    res.json({
                        code: 200,
                        message: "success",
                    })
                } else {
                    res.json({ code: -1, message: "权限不足", data: e })
                }

            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getMyEditJob: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {

            try {
                let data = await User.isPermission(username)
                if (data.permission == 1) {
                    let userIdData = await User.searchId(username)
                    const user_id = userIdData.user_id
                    const jobData = await Job.select("user_id", user_id)
                    // console.log(jobData);
                    // await Job.insert()
                    res.json({
                        code: 200,
                        message: "success",
                        data: jobData
                    })
                } else {
                    res.json({ code: -1, message: "权限不足", data: e })
                }

            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    getAllJob: async function (req, res, next) {

        try {
            let jobData = await Job.select("vaild", "1")
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getCommendJob: async function (req, res, next) {

        try {
            let jobData = await Job.select("vaild", "1").orderByRaw('RAND()').limit(8);
            // console.log(jobData);
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getAllPreJob: async function (req, res, next) {

        try {
            let jobData = await Job.selectJob("1", req.body?.user_id)
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getHomeJob: async function (req, res, next) {
        try {
            let jobData = await Job.homeJobSelect("vaild", "1")
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getHomeJob2: async function (req, res, next) {
        try {
            let jobData = await Job.homeJobSelect2({type:"vaild", value:"1"},{type:"job_info", value:"0"})
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getHomeJob3: async function (req, res, next) {
        try {
            let jobData = await Job.homeJobSelect2({type:"vaild", value:"1"},{type:"job_info", value:"2"})
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getHomeJob4: async function (req, res, next) {
        try {
            let jobData = await Job.homeJobSelect2({type:"vaild", value:"1"},{type:"city", value:"南京"})
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    getJobInfo: async function (req, res, next) {
        try {
            // console.log(req.body);
            let jobData = await Job.select("job_id", req.body.job_id)
            // console.log(jobData[0].applicant_id);
            let applicant = []
            if (jobData[0].applicant_id != null) {

                let applicant_id = jobData[0].applicant_id.split(",")
                // console.log(applicant_id);
                await Promise.all(applicant_id.map(async (item) => {
                    // console.log(item);
                    let applicantData = await User.select("user_id", item);
                    applicant.push(...applicantData);
                    // console.log(jobData);
                    // console.log(resData);
                }));
                res.json({
                    code: 200,
                    message: "success",
                    data: jobData,
                    applicant: applicant
                })
            } else {
                res.json({
                    code: 200,
                    message: "success",
                    data: jobData,
                    applicant: applicant
                })
            }
        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    deleteJob: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            //IM 访问别人的需要重新
            try {
                let data = await User.isPermission(username)
                if (data.permission == 1) {
                    let userIdData = await User.searchId(username)
                    // console.log(userIdData.user_id);
                    if (userIdData.user_id == req.body.user_id) {
                        console.log(req.body);
                        await Job.delete("job_id", req.body.job_id)
                        res.json({
                            code: 200,
                            message: "success",
                        })
                    } else {
                        res.json({ code: -1, message: "权限不足" })
                    }

                } else {
                    res.json({ code: -1, message: "权限不足" })
                }

            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
    searchJob: async function (req, res, next) {
        try {
            console.log(req.body);
            let jobData = await Job.selectTitle(req.body.title)
            console.log(jobData);
            res.json({
                code: 200,
                message: "success",
                data: jobData
            })

        } catch (e) {
            res.json({ code: 0, message: "default", data: e })
        }
    },
    deleteApplicant: async function (req, res, next) {
        jwt.verify(req.headers.authorization).then(async username => {
            // console.log(username);
            try {
                    console.log(req.body);
                    let jobData = await Job.select('job_id', Number(req.body.job_id)).first()
                    // console.log(jobData);
                    let applicant_id = (jobData.applicant_id.split(',').filter(item=>item!=req.body.applicant_id)).join(',')
                    // console.log(applicant_id);
                    await Job.updateJob(jobData.job_id, { applicant_id: applicant_id })
                    // console.log(applicant_id);
                // if(data.Permission==1)
                res.json({
                    code: 200,
                    message: "success",
                    // data:chatData
                })
            } catch (e) {
                res.json({ code: 0, message: "default", data: e })
            }
        }).catch((e) => {
            res.json({ code: 100, message: "登录超时", data: e })
        })
    },
}
module.exports = useController