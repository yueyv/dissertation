// IM jwt
// server > utils > jwt.js
const jwt = require('jsonwebtoken')

function sign(option) {
  return jwt.sign(option, 'yueyv', {
    expiresIn: 6000000 // 设定过期时间
  })
}

module.exports = {
  sign
}
