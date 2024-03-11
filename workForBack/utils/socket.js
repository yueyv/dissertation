
// 

// const { Logform } = require("winston")
// 记录在线
const users = {};
const USER_STATUS = ['ONLINE', 'OFFLINE'];
const {verify} =require('../utils/jwt')
module.exports = (socket) => {

    // console.log(socket.handshake.auth.token);
    socket.on('online', status => {
        // console.log(status);
        verify(socket.handshake.auth.token).then((username)=>{
            // console.log(username);
            socket.username=username
            users[username] = {
                socketId: socket.id,
                status: USER_STATUS[0],
            };
            // console.log(users);
        }).catch(
            // socket.emit('disConnect',"验证错误")
        )
        

    })

    socket.on('private_chat', (params, fn) => {
        // console.log('Receive message: ', JSON.stringify(params));
        // const receiver = users[params.receiver];
        // params.createTime = moment().format('YYYY-MM-DD HH:mm:ss');
        // const senderData = _.findWhere(userData, { username: params.sender });
        // params.senderPhoto = (senderData || {}).photo;

        // if (!params.senderPhoto) {
        //     const senderLen = params.sender.length;
        //     params.senderPhotoNickname = params.sender.substr(senderLen - 2)
        // }

        // fn(params);

        // if (receiver && receiver.status === USER_STATUS[0]) {
        //     socket.to(users[params.receiver].socketId).emit('reply_private_chat', params);
        // } else {
        //     console.log(`${params.receiver} 不在线`);
        // }
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


