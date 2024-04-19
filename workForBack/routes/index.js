const express = require('express');
const fs = require('fs');
const path = require('path');
const useControllerUser = require('../controllers/user');
const useControllerJob = require('../controllers/job');
const useControllerMes = require('../controllers/message');
const useControllerAdmin = require('../controllers/admin');
const useControllerCompany = require('../controllers/company');
const useControllerVideoChat = require('../controllers/video_chat');
// mark 过滤文件
const multer = require('multer');
const upload = multer();
const { Server } = require("socket.io")
// const { log } = require('../config');
const useGetCity = require("../utils/getCity")
var router = express.Router();
router.get('/', function (req, res, next) {
  res.render('index', { title: 'Express' });
});

/* GET home page. */

// 个人信息
router.post('/api/get_user', useControllerUser.showUser)
router.post('/api/get_user_other', useControllerUser.showUserFromId)
router.post('/api/update_user', useControllerUser.updateUser)
router.get('/api/getApplyJob', useControllerUser.getApplyJob)
router.post('/api/deleteApplyJob', useControllerUser.deleteApplyJob)
// 登录
router.post('/api/login', useControllerUser.login)
router.post('/api/register', useControllerUser.register)
// 上传材料
router.post('/api/upload_apply', upload.single('file'), useControllerUser.upload_apply)
router.post('/api/upload_resume', upload.single('file'), useControllerUser.upload_resume)
// 判定上传
router.get('/api/get_isExistUpload', useControllerUser.isExistUpload)
router.get('/api/getPermission', useControllerUser.getPermission)
router.get('/api/getChatId', useControllerUser.getChatId)
// 公司
router.post('/api/uploadCompany', useControllerCompany.uploadCompany)
router.post('/api/GetCompany', useControllerCompany.GetCompany)
router.post('/api/searchCompany', useControllerCompany.searchCompany)
// IM JOB
router.post('/api/addJob', useControllerJob.addJob)
router.post("/api/getMyEditJob", useControllerJob.getMyEditJob)
router.post("/api/getAllJob", useControllerJob.getAllJob)
router.post("/api/getCommendJob", useControllerJob.getCommendJob)
router.post("/api/getAllPreJob", useControllerJob.getAllPreJob)
router.post("/api/getHomeJob", useControllerJob.getHomeJob)
router.post("/api/getHomeJob2", useControllerJob.getHomeJob2)
router.post("/api/getHomeJob3", useControllerJob.getHomeJob3)
router.post("/api/getHomeJob4", useControllerJob.getHomeJob4)
router.post("/api/getJobInfo", useControllerJob.getJobInfo)
router.post("/api/deleteJob", useControllerJob.deleteJob)
router.post("/api/searchJob", useControllerJob.searchJob)
router.post("/api/deleteApplicant", useControllerJob.deleteApplicant)

// MARK 多表插入
router.post("/api/addChatAndJob", useControllerMes.addChatAndJob)
// IM聊天系统
router.post("/api/get_chat", useControllerMes.getChat)
router.post("/api/searchUnreadMes", useControllerMes.searchUnreadMes)

router.post("/api/chatDelete", useControllerMes.chatDelete)
router.post("/api/chatToadmin", useControllerMes.chatToadmin)
router.post("/api/chatToApplicant", useControllerMes.chatToApplicant)
// TODO admin
router.post("/api/adminLogin", useControllerAdmin.adminLogin)
router.post("/api/adminChatTo", useControllerAdmin.adminChatTo)
// BUG
router.post("/api/get_chat_admin", useControllerAdmin.getChatAdmin)
router.post('/api/get_admin', useControllerAdmin.showAdmin)
router.post("/api/getAllUser", useControllerAdmin.getAllUser)
router.post("/api/getAllJobAdmin", useControllerAdmin.getAllJob)
router.get("/api/getChatIdAdmin", useControllerAdmin.getChatIdAdmin)
router.post("/api/changePermission", useControllerAdmin.changePermission)
router.post("/api/changevaild", useControllerAdmin.changevaild)
// 视频聊天
router.post("/api/videoChatTo", useControllerVideoChat.videoChatTo)
router.post("/api/videoChatSearch", useControllerVideoChat.videoChatSearch)
router.post("/api/videoChatOver", useControllerVideoChat.videoChatOver)

// MARK 获取城市
router.get('/api/get_city', (req, res, next) => {
  // const token = req.headers.authorization;
  const ip = req
  // console.log(req.query);
  // console.log(ip);
  // console.log(token);
  useGetCity(ip).then((city) => {
    res.json({
      code: 200, message: "success",
      city: `${city}`
    })
  }).catch((e) => {
    res.json({
      code: 401, message: "default", data: {
        e: e
      }
    })
  })

})
// MARK 文件系统
router.get('/api/file', (req, res) => {
  // console.log(req);
  const filename = req.query.filename;
  // console.log(filename);
  const currentDir = __dirname;
  // console.log(currentDir);
  const parentDir = path.dirname(currentDir);
  const folderPath = path.join(parentDir, 'file');
  // console.log(folderPath,filename);
  const filePath = path.join(folderPath, filename);
  console.log(filePath);
  // 使用 Node.js 的文件系统模块读取文件内容
  fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
      // 如果读取文件时发生错误，则向客户端发送错误响应
      res.status(500).send('Failed to read file');
      return;
    }

    // 向客户端发送文件内容作为响应
    res.set('Content-Type', 'application/octet-stream'); 
    res.send(data);
  });
});
router.get('/api/resume', (req, res) => {
  // console.log(req);
  const filename = req.query.filename;
  // console.log(encodeURIComponent(filename));
  const currentDir = __dirname;
  // console.log(currentDir);
  const parentDir = path.dirname(currentDir);
  const folderPath = path.join(parentDir, 'resume');
  // console.log(folderPath,filename);
  const filePath = path.join(folderPath, filename);
  console.log(filePath);
  // 使用 Node.js 的文件系统模块读取文件内容
  fs.readFile(filePath,  (err, data) => {
    if (err) {
      // 如果读取文件时发生错误，则向客户端发送错误响应
      res.status(500).send('Failed to read file');
      return;
    }
    // 向客户端发送文件内容作为响应
    res.set('Content-Type', 'application/octet-stream'); 
    res.send(data);
  });
});
module.exports = router;