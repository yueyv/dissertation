
// 

// const { Logform } = require("winston")
// MARK记录在线 连接池
const users = {};
// 连接池
const USER_STATUS = ['ONLINE', 'OFFLINE'];
const User = require('../models/user')
const Mes = require('../models/message')
const {verify} =require('../utils/jwt')
module.exports = (socket) => {

    // console.log(socket.handshake.auth.token);
    socket.on('online', status => {
        // console.log(status);
        try {
            verify(socket.handshake.auth.token).then(async(username)=>{
                // console.log(username);
                socket.username=username
                let userIdData = await User.searchId(username)
                socket.user_id=userIdData.user_id
                users[userIdData.user_id] = {
                    user_id:userIdData.user_id,
                    socketId: socket.id,
                    status: USER_STATUS[0],
                };
                // console.log(users);
            }).catch((e)=>{
                console.log(e);
            })
        } catch (error) {
            console.log(error);
        }
        
        

    })

    socket.on('private_chat', async(params) => {
        // console.log({
        //         user_id:socket.user_id,
        //         to_id:params.to_id,
        //         content:params.text
        //     });
        try {
            await Mes.insert({
                user_id:socket.user_id,
                to_id:params.to_id,
                content:params.text
            })
            socket.emit('chat_success',true)
        } catch (error) {
            console.log(error);
        }

        // TODO 过滤敏感词 以后再说
        // 在content中识别过滤
        const receiver = users[params.to_id];
 
// 放弃状态管理
        if (receiver && receiver.status === USER_STATUS[0]) {
            console.log(receiver);
            socket.to(receiver.socketId).emit('reply_private_chat', {from_id:socket.user_id,content:params.text,from_username:socket.username});
        } else {
            console.log(`${params.to_id} 不在线`);
        }
    });

    socket.on('disconnect', reason => {
        console.log('disconnect: ', reason);
        console.log(socket.username);
        if (users[socket.username]) {
            users[socket.username].status = USER_STATUS[1];
            console.log(users);
        }
    });
}


