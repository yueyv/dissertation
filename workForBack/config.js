
const configs = {
    // IM 链接mysql
    mysql: {
        host: 'localhost',
        user: 'root',
        password: 'yueyv',
        port: '3306',
        database: 'schoolWork'
    },
    log:{
        error(message){
            console.log("连接mysql失败");
            console.log('[knex error]',message)
        }
    }
};
module.exports=configs
