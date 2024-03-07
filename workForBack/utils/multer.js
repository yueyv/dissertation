const multer = require('multer');

// 配置 Multer
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/'); // 保存上传的文件到 uploads 目录
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname); // 使用原始文件名作为保存的文件名
    }
});
const upload = multer({ storage: storage });

// 上传文件处理函数
const upload_apply = async function (req, res, next) {
    try {
        // 在 req.file 中获取上传的文件信息
        const application = req.file;

        // 执行其他操作，例如将文件信息存储到数据库
        
        // 返回成功响应
        res.json({ code: 200, message: "File uploaded successfully", data: application });
    } catch (e) {
        console.error(e);
        res.status(500).json({ code: 500, message: "Internal Server Error", data: e });
    }
}

module.exports = {
    upload_apply: upload.single('file'), // 单文件上传，'file' 对应前端 FormData 中的文件字段名
};
