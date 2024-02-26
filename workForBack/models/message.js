const Base=require('./base')
class Message extends Base{
    constructor(props='messages'){
        super(props);
    }
}
module.exports=new Message()