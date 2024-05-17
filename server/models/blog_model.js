const mongoose = require('mongoose');

const blog_schema = mongoose.Schema({
    name:{
        required : true,
        type : String
    },
    age : {
        required : true,
        type : Number
    },
    title : {
        required : true,
        type : String
    },
    description : {
        required : true,
        type : String
    }
});

module.exports = mongoose.model("Blog",blog_schema);