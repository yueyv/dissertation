
const configs = {
    // IM 链接mysql
    mysql: {
        host: '20.213.10.238',
        user: 'root',
        password: '129218219',
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
