const express = require('express');
const mongoose = require('mongoose');
const auth_router = require('./router/auth');
const blog_router = require('./router/blog');
const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(express.urlencoded({extended : true}));

mongoose.connect("mongodb://127.0.0.1:27017/auth_practice").then(()=>{
    console.log('connection created');
}).catch((e)=>{
    console.log('databse connection error');
});

app.use(auth_router);
app.use(blog_router)


app.listen(3000,()=>{
    console.log("port is connected to " + port);
})

