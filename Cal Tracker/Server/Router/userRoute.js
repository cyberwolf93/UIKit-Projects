const express = require('express')
const uuid = require('uuid')
const jwt = require('jsonwebtoken');
const userRoute = express.Router()
const userModel = require('../Model/user')


// generate JWT
function getJWT(email, id) {
    let jwtSecretKey = process.env.JWT_KEY;
    let data = {
        email: email,
        userId: id,
    }

    return jwt.sign(data, jwtSecretKey)
}

// Create user
userRoute.post("/create", async (req, res) => {
    const userId = uuid.v4()
    const userToken = getJWT(req.body.email, userId)
    const user = new userModel({
        id: userId,
        name: req.body.name,
        email: req.body.email,
        password: req.body.password,
        token: userToken,
        isAdmin: req.body.is_admin,
        cal_limit: req.body.cal_limit
    })

    try {
        await user.save()
        res.json({"token": userToken}).status(200)
    } catch (err) {
        res.json({message : err}).status(400)
    }


})

// Sign in user and return user data with token for authentication
userRoute.post("/signin", async (req, res) => {

    try {
        const user = await userModel.findOne({email: req.body.email})
        if (user && user.password === req.body.password) {
            res.status(200).json({"id": user.id,
                    "token": user.token,
                    "name": user.name,
                    "isAdmin": user.isAdmin,
                    "cal_limit": user.cal_limit,
                    "email": user.email}) 
        } else {
            res.status(404).json({})
        }
        
    } catch (err) {
        res.json({message : err}).status(400)
    }


})

// Return all users for admin except admin user 
userRoute.get("/get", async (req, res) => {
    
    try {
        if (req.headers.authorization === process.env.ADMIN_TOKEN) {
            const users = await userModel.find({token: {$ne: process.env.ADMIN_TOKEN}}, {password: 0})
            console.log(users)
            res.status(200).json(users)
        } else {
            console.log("error")
            res.status(404).json([])
        }
        
    } catch (err) {
        console.log(err)
        res.json({message : err}).status(400)
    }


})

// Update user limit
userRoute.put('/update/:limit', async (req, res) => {
    try {
        if ( req.headers.authorization &&  req.headers.authorization.length > 0 ) {
            const updatedEntry = await userModel.updateOne({token: req.headers.authorization}, {$set: { cal_limit: req.params.limit}})
            const item = await userModel.findOne({token: req.headers.authorization})
            if (item) {
                res.status(200).json(item);
            } else {
                res.sendStatus(404)
            }   
        } else {
            res.status(401).json({})
        }
        
    } catch (err) {
        res.json({message : err}).status(400)
    }
    
});


// validate user 
userRoute.get('/validate/:id', async (req, res) => {
    try {
        if ( req.headers.authorization &&  req.headers.authorization.length > 0 ) {
            const user = await userModel.findOne({id: req.params.id})
            
            if (user && user.token === req.headers.authorization) {
                res.sendStatus(200)
            } else {
                res.sendStatus(404)
            }   
        } else {
            res.status(401).json({})
        }
        
    } catch (err) {
        res.json({message : err}).status(400)
    }
    
});

// refresh  user  token
userRoute.get('/refresh/:id', async (req, res) => {
    try {
        if ( req.headers.authorization &&  req.headers.authorization.length > 0 ) {
            const user = await userModel.findOne({id: req.params.id})
            
            if (user && user.token === req.headers.authorization) {
                const userToken = getJWT(user.email, req.params.id)
                const updatedEntry = await userModel.updateOne({id: req.params.id}, {$set: { token: userToken}})
                res.sendStatus(200)
            } else {
                res.sendStatus(404)
            }   
        } else {
            res.status(401).json({})
        }
        
    } catch (err) {
        res.json({message : err}).status(400)
    }
    
});


module.exports = userRoute
