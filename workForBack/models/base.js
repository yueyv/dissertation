const knex = require('./knex')
class Base {
    constructor(props) {
        this.table = props
    }
    all() {
        return knex(this.table).select();
    }
    inquire(id) {
        return knex(this.table).where('username', '=', id)
    }
    select(param1, param2) {
        return knex(this.table).where(param1, '=', param2)
    }
    safeInquire(id) {
        return knex(this.table).select('user_id', 'username', 'permission', 'email', 'phone', 'college', 'address', 'name', 'city', 'salary', 'other').where('username', '=', id)
            .first();
    }
    insert(params) {
        return knex(this.table).insert(params)
    }
    update(id, params) {
        return knex(this.table).where('username', '=', id).update(params)
    }
    delete(param1,param2) {
        return knex(this.table).where(param1, '=', param2).del();
    }
    searchId(id) {
        return knex(this.table).select('user_id').where('username', '=', id).first()
    }
    selectTitle(title) {
        return knex(this.table).where('title', 'like', `%${title}%`).where('vaild','=','1')
    }
    searchIsUpload(id) {
        return knex(this.table).select('apply_filename').where('username', '=', id).first()
    }
    isPermission(id) {
        return knex(this.table).select('permission').where('username', '=', id).first();
    }
    homeJobSelect(param1, param2) {
        return knex(this.table).select().where(param1, '=', param2).orderBy('job_id', 'desc').limit(4)
    }
}
module.exports = Base