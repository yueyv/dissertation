// IM jwt
const jwt = require('jsonwebtoken');
const { log } = require('../config');

function sign(option) {
  return jwt.sign(option, 'yueyv', {
    expiresIn: 60000000 // 设定过期时间
  })
}
// TODO 后端鉴权
// isAdmin参数用于权限控制
let verify = (jwtToken) => {
  return new Promise((resolve, reject) => {
    jwt.verify(jwtToken, 'yueyv', function(err, decoded) {
      if (err) {
        reject(err);
        console.log("超时");
      } else {
        let {username} = decoded;
        resolve(username);
      }
    });
  });
}
module.exports = {
  sign,verify
}
