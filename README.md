# 已完成模块

## 加密与传输安全模块

- JWT TOKEN 身份验证模块，包括访问拦截器将token加入请求header
- 加盐md5加密，base64编码
- 传输文件采用二进制form-data传输方式

## 交流模块

- 使用socket协议实现实时交流功能，包括成功发送或接收消息的提示
- 反向代理
- 确认用户在线状态的功能
- 实现未读消息功能
- 聊天对象的CRUD操作，包括创建、读取、更新、删除

## 用户模块

- 实现注册和登录功能，包括身份验证和访问控制
- 个人信息模块，允许用户查看和编辑个人信息
- 上传和下载简历功能
- 权限申请及审核模块，允许用户申请权限并管理员审核

## 管理员模块

- 实现管理员权限管理功能，包括审查用户权限和岗位发布权限
- 支持管理员与用户的聊天功能
- 允许管理员删除违规岗位信息

## 招聘模块

- 实现招聘信息的编辑和删除功能
- 支持增加和删除候选人信息
- 审核模块，包括招聘信息和候选人信息的审核功能
- 实现上传和审查文件的功能

## FAQ模块

- 提示模块，用于展示操作提示信息
- 联系方式模块，允许用户复制联系方式
- 联系客服模块，提供与客服人员联系的功能

## 搜索模块

- 结果反馈模块，展示搜索结果并提供反馈
- 加载动画，增加搜索过程中的动画效果
- 搜索结果分页模块，支持对搜索结果的分页显示
- 懒加载，优化搜索结果的加载速度
- 搜索提示模块，提供搜索关键词的自动补全和提示功能

## 推荐模块

- 分页功能，允许用户对推荐内容进行分页浏览
- 获取用户IP并定位城市，用于个性化推荐
- 岗位详情模块，提供岗位详细信息的展示功能
- 懒加载，优化推荐内容的加载速度
- 跳转沟通，允许用户通过推荐内容直接跳转到沟通页面

## 数据存储模块

- 使用localstorage和sessionstorage存储token、permission等用户信息
- 使用pinia进行状态管理，提高数据存储和管理效率
- 使用socket连接池记录在线用户的状态信息

## 安全和隐私模块

- 敏感词过滤功能，保护用户免受不良信息的干扰
- 隐藏个人信息功能，保护用户的个人隐私
- 注销账号功能，允许用户注销账号并删除相关信息

## 日志模块

- 在系统运行中加入反馈
- 重写console.log
- 日志存储，将日志信息存储在数据库或文件中，便于后续的查看和分析

## 视频聊天

## 屏幕共享



## 性能优化

- 路由懒加载，提高页面加载速度，减少首次加载时间
- 防抖节流，优化用户输入等事件的响应速度和效率
- 图片懒加载，采用base64编码图片和异步加载等方式，减少页面加载时间
- 异步加载，优化页面加载速度，提高用户体验
- 控制渲染，通过控制DOM元素的渲染来优化页面性能
- 错误页面，提供友好的错误页面，增强用户体验
- SSR，实现服务器端渲染，提高页面加载速度和SEO效果

## 页面优化模块

- 响应式布局，采用vh、vw、rem等单位，适配不同设备的屏幕尺寸
- 媒体查询，根据不同设备的屏幕尺寸和分辨率，提供不同的页面布局和样式
- 优化滚动条，通过样式设置，美化滚动条，提升页面美观度
- 操作反馈模块，提供用户操作的实时反馈，增强用户体验
- 骨架屏，提供页面加载时的骨架屏效果，增加用户等待时的视觉效果
- 加载动画，增加页面元素加载时的动画效果，提高用户体验
- UI优化

## 部署模块

- SSR和SPA渲染模块，实现服务器端渲染和单页面应用渲染，提高页面加载速度和SEO效果
- nginx反向代理，用于负载均衡和请求转发，提高系统的稳定性和性能
- docker容器模块，实现应用的容器化部署，简化部署流程，提高系统的可维护性和可扩展性
- 后端跨域处理，socket
- CA证书、域名和服务器http通信模块，保证系统与客户端之间的安全通信，防止信息被窃取和篡改
- http2 gzip
- 正向代理及反向代理
- ACME模块，用于自动化管理和更新SSL证书，提高系统的安全性和稳定性
- 端口 8080（SPA_ADMIN) 80(SSR_FRONT) 443(SPA_ADMIN SSL) 3306(MYSQL) 3000(BACK)
