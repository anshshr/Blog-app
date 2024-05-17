const express = require('express');
const auth_router = express.Router();
const bcrypt = require('bcrypt');
const User = require('../models/user_model')
const { emit } = require('nodemon');
const jwt = require('jsonwebtoken');


//signup
auth_router.post('/api/signup', async function (req, res) {
    try {
        const { name, email, password } = req.body;
        console.log("hello");
        console.log('finding user');
        const existing_user = await User.findOne({ email });
        console.log("hru");

        if (existing_user) {
            return res.status(400).json({ msg: "user with the email already exist" });
        }

        console.log('fine');
        const hashed_pasword = await bcrypt.hash(password, 10);
        console.log('hasing done');
        const user = new User({
            name,
            email,
            password: hashed_pasword,
        });

        console.log('going to save');

        await user.save();
        console.log('user saved');
        res.status(200).json(user);
        console.log('returning the json response');
    } catch (e) {
        console.log(' throwing error');
        res.status(500).json({
            error: e.messsage,
            message: "unable to connect to server"
        });
    }
});

//signin
auth_router.post('/api/signin', async function (req, res) {
    try {
        const { email, password } = req.body;

        const user_data = await User.findOne({ email });
        if (!user_data) {
            console.log('user not found');
            return res.status(400).json({ msg: 'user with email do not exist' });
        }
        console.log('user found');
        console.log(user_data);

        console.log('after if');
        if (password != null && user_data.password != null) {
            const ismatch = await bcrypt.compare(password, user_data.password);
            if (!ismatch) {
                return res.status(400).json({
                    msg: 'incorreect password'
                });
            }
        }

        console.log('after the match');

        const token = jwt.sign({ id: user_data._id, name: user_data.name, email: user_data.email }, "ansh");
        console.log('token generated');
        console.log('sending result');
        return res.status(200).json({ token, ...user_data._doc });

    } catch (e) {
        console.log("error occured");
        res.status(500).json({ error: e.message, msg: "something error occured while login" })
    }
})

module.exports = auth_router;