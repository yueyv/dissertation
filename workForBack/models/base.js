const knex = require('./knex')
class Base {
    constructor(props) {
        this.table = props
    }
    all() {
        return knex(this.table).select();
    }
    inquire(id){
        return knex(this.table).where('username','=',id)
    }
    safeInquire(id){
        return     knex(this.table).select('user_id', 'username', 'permission', 'email', 'phone', 'college', 'address', 'name', 'city', 'salary', 'other').where('username', '=', id)
        .first();
    }
    insert(params){
        return knex(this.table).insert(params)
    }
    update(id,params) {
        return knex(this.table).where('username','=',id).update(params)
    }
    delete(id){
        return knex(this.table).where('id','=',id).del();
    }
    searchId(id){
        return knex(this.table).select('user_id').where('username', '=', id).first()
    }
}
module.exports=Base