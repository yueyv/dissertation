const configs=require('../config')
module.exports=require('knex')({
    client:'mysql',
    connection:{
        host:configs.mysql.host,
        port:configs.mysql.port,
        user:configs.mysql.user,
        password:configs.mysql.password,
        database:configs.mysql.database
    },
    log:{
        error(message){
            console.log("连接失败knex");
            console.log('[knex error]',message)         
        }
    }
})