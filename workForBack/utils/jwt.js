// IM jwt
const jwt = require('jsonwebtoken')

function sign(option) {
  return jwt.sign(option, 'yueyv', {
    expiresIn: 6000000 // 设定过期时间
  })
}
// TODO 后端鉴权
// isAdmin参数用于权限控制
let verify = (premission) => (ctx, next) => {
  // 获取到前端传递多来的token
  let jwtToken = ctx.req.headers.authorization
  if (jwtToken) {
    // 校验token的合法性
    jwt.verify(jwtToken, 'yueyv', function(err, decoded) {

      if (err) {
        ctx.body = {
          status: 401,
          message: 'token失效'
        }
      } else {
        if (isAdmin) {
          let { admin } = decoded
          if (admin) {
            next()
          } else {
            ctx.body = {
              status: 401,
              message: '你不是管理员!权限不够!'
            }
          }
        } else {
          next()
        }
      }
    });
  } else {
    ctx.body = {
      status: 401,
      message: '请提供token'
    }
  }
}
module.exports = {
  sign
}
