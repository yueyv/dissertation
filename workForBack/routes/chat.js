var express = require('express');

const multer = require('multer');

var router = express.Router();

router.get('/test',(req,res)=>{
    res.send("sss")
})
module.exports = router;
// 弃用