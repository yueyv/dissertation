const Base=require('./base')
class admin extends Base{
    constructor(props='admins'){
        super(props);
    }
}
module.exports=new admin()