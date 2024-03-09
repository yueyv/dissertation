var express = require('express');
const useControllerUser = require('../controllers/user');
const useControllerJob = require('../controllers/job');
const multer = require('multer');
const upload = multer();
const { log } = require('../config');
const useGetCity=require("../utils/getCity")
var router = express.Router();
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

/* GET home page. */

// 个人信息
router.post('/api/get_user', useControllerUser.showUser)
router.post('/api/update_user', useControllerUser.updateUser)
// 登录
router.post('/api/login',useControllerUser.login)
router.post('/api/register',useControllerUser.register)
// 上传材料
router.post('/api/upload_apply',upload.single('file'),useControllerUser.upload_apply)
// 判定上传
router.get('/api/get_isExistUpload',useControllerUser.isExistUpload)
router.get('/api/getPermission',useControllerUser.getPermission)

// IM JOB
router.post('/api/addJob',useControllerJob.addJob)
router.post("/api/getMyEditJob",useControllerJob.getMyEditJob)
router.post("/api/getAllJob",useControllerJob.getAllJob)
router.post("/api/getHomeJob",useControllerJob.getHomeJob)
router.post("/api/getJobInfo",useControllerJob.getJobInfo)




// MARK 获取城市
router.get('/api/get_city',(req,res,next)=>{
  // const token = req.headers.authorization;
  const ip=req
  // console.log(req.query);
  // console.log(ip);
  // console.log(token);
  useGetCity(ip).then((city)=>{
    res.json({code:200,message:"success",
      city:`${city}`
    })
  }).catch((e)=>{
    res.json({code:401,message:"default",data:{
      e:e
    }})
  })
  
})
module.exports = router;