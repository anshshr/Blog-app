const express = require('express');
const blog_router = express.Router();
const blog = require("../models/blog_model");

blog_router.post("/api/createblog", async function (req, res) {
    try {
        const { name, age, title, description } = req.body;

        const created_blog = new blog({
            name: name,
            age: age,
            title: title,
            description: description,
        });

        await created_blog.save();

        return res.status(200).json(created_blog);
    } catch (error) {
        console.log(error);
        res.status(500).json({
            error: e.messasge,
            msg: " something error occured while creating a blog",
        });
    }

});

//reading the blogs present in the database;
blog_router.get('/api/getblogs', async function (req, res) {
    try {
        const user_posts = await blog.find();
        return res.status(200).json(user_posts);
    } catch (error) {
        console.log(error);
        res.status(500).json({ msg: 'something error occured while reading the posts', error: error.messasge });
    }
});

//reading the blogs by id
blog_router.get('/api/getblogs/:id', async function (req, res) {
    try {
        const blogs_by_id = await blog.findOne({ _id: req.params.id });
        return res.status(200).json(blogs_by_id);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ msg: 'something error occured while reading the posts', error: error.messasge });
    }
});

//updating the user
blog_router.post('/api/update', async function (req, res) {
    try {
        const { name, age, title, description, user_id } = req.body;

        const updated_user = await blog.findOneAndUpdate({ _id: user_id }, { name: name, age: age, title: title, description: description }, { new: true });
        return res.status(200).json(updated_user);
    } catch (error) {
        return res.status(500).json({msg : "unable to update", error : e.messasge});
    }
});

//delete a blog
blog_router.get('/api/delete/:id',async function(req,res){
   try {
    const deleting_blog_user = await blog.findOneAndDelete({_id : req.params.id});
   return res.status(200).json({deleting_blog_user,msg : "user deleted succesfully"});
   } catch (error) {
    return res.status(500).json({msg : "error eccoured while deleting the user",error:e.messasge});
   }
});

module.exports = blog_router;