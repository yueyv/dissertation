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
    insert(params){
        return knex(this.table).insert(params)
    }
    update(id,params) {
        return knex(this.table).where('username','=',id).update(params)
    }
    delete(id){
        return knex(this.table).where('id','=',id).del();
    }
}
module.exports=Base