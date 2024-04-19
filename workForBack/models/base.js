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
    selectJob(param1, param2,) {
        return knex(this.table).where((builder) => {
            builder.where("vaild", '=', param1)
                .andWhere("user_id", '=', param2);
        })
    }
    safeInquire(id) {
        return knex(this.table).select('user_id', 'username', 'permission', 'email', 'phone', 'college', 'address', 'name', 'city', 'salary', 'other', "updated_at", "resume").where('username', '=', id)
            .first();
    }
    adminInquire(id) {
        return knex(this.table).select('admin_id', 'username', "updated_at").where('username', '=', id)
            .first();
    }
    insert(params) {
        return knex(this.table).insert(params)
    }
    update(id, params) {
        return knex(this.table).where('username', '=', id).update(params)
    }
    updateCompany(id, params) {
        return knex(this.table).where('user_id', '=', id).update(params)
    }
    updateVc(id, params) {
        return knex(this.table).where('to_username', '=', id).update(params)
    }
    updateJob(id, params) {
        return knex(this.table).where('job_id', '=', id).update(params)
    }
    delete(param1, param2) {
        return knex(this.table).where(param1, '=', param2).del();
    }
    searchId(id) {
        return knex(this.table).select('user_id').where('username', '=', id).first()
    }
    selectTitle(title) {
        return knex(this.table).where('title', 'like', `%${title}%`).where('vaild', '=', '1')
        // .orderBy('job_id', 'desc');
    }
    searchIsUpload(id) {
        return knex(this.table).select('apply_filename').where('username', '=', id).first()
    }
    isPermission(id) {
        return knex(this.table).select('permission').where('username', '=', id).first();
    }
    getApplyJob(id) {
        return knex(this.table).select('job_id').where('username', '=', id).first();
    }
    getChatId(id) {
        return knex(this.table).select('user_id', 'chat_id').where('username', '=', id).first();
    }
    getUserName(id) {
        return knex(this.table).select('username').where('user_id', '=', id).first();
    }
    homeJobSelect(param1, param2) {
        return knex(this.table).select().where(param1, '=', param2).orderBy('job_id', 'desc').limit(4)
    }
    homeJobSelect2(param1, param2) {
        return knex(this.table).select().where((builder) => {
            builder.where(param1.type, '=', param1.value)
                .andWhere(param2.type, '=',param2.value);
        }).orderBy('job_id', 'desc').limit(4)
    }
    selectChat(id1, id2) {
        return knex(this.table)
            .select()
            .where((builder) => {
                builder.where("user_id", '=', id1)
                    .andWhere("to_id", '=', id2);
            })
            .orWhere((builder) => {
                builder.where("user_id", '=', id2)
                    .andWhere("to_id", '=', id1);
            })
            .orderBy('message_id', 'asc');
    }
    selectUnreadChatAll(id) {
        return knex(this.table)
            .select()
            .where((builder) => {
                builder.where("to_id", '=', id)
            })
            .orderBy('message_id', 'desc').first();
    }
    selectUnreadChat(from_id, to_id) {
        return knex(this.table)
            .select('read')
            .where((builder) => {
                builder.where("user_id", '=', from_id)
                    .andWhere("to_id", '=', to_id);
            })
            .orderBy('message_id', 'desc').first();
    }
    readMes(from_id, to_id) {
        return knex(this.table).where((builder) => {
            builder.where("user_id", '=', from_id)
                .andWhere("to_id", '=', to_id);
        }).update({ read: 1 })
    }
}
module.exports = Base