const mongoose = require('mongoose');

const  user_schema = mongoose.Schema({
    name :{
        required : true,
        type : String,
        trim : true
    },
    email : {
        required : true,
        type : String,
        trim : true,
        validate :{
            validator : (value) =>{
                const re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                return value.match(re);
            }
        },
        message : "enter  a valid email address",
    },
    password : {
        required : true,
        type : String
    }
    
});

const User = mongoose.model("User",user_schema);
module.exports = User;