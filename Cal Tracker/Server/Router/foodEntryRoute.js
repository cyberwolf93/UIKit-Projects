const express = require('express')
const foodEntryRoute = express.Router()
const uuid = require('uuid')
const foodModel = require('../Model/foodEntry')
const userModel = require('../Model/user')
const multer = require('multer')
const path = require('path')

// uploading image 
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/Images")
    }, 
    filename: (req, file, cb) => {
        req.imageName = Date.now() + path.extname(file.originalname)
        cb(null,req.imageName)
    }
})
const uplaod = multer({ storage: storage})

// create food entry
foodEntryRoute.post("/create", async (req, res) => {
    try {
        const user = await userModel.findOne({id: req.body.user_id}) 
        if (user && (user.token === req.headers.authorization || req.headers.authorization === process.env.ADMIN_TOKEN) ) {
            const foodEntry = new foodModel({
                id: uuid.v4(),
                userId: user.id,
                name: req.body.name,
                thumbUrl: "",
                date: req.body.date,
                time: req.body.time,
                timestamp: req.body.timestamp,
                cal_value: req.body.cal_value
            })
    
            await foodEntry.save()
            res.status(200).json(foodEntry)
        } else {
            res.status(401).json({})
        }
    } catch(err) {
        res.json({message : err}).status(400)
    }
    
})

// Upload image and save it to food entry item 
foodEntryRoute.post('/upload/:id',uplaod.single("image"), async (req, res) => {
    console.log(req.imageName)
    console.log(req.params.id)
    try {
        const updatedEntry = await foodModel.updateOne({id: req.params.id}, {$set: { thumbUrl: "/Images/" + req.imageName}})
        const item = await foodModel.findOne({id: req.params.id})
        if (item) {
            res.status(200).json(item);
        } else {
            res.sendStatus(404)
        }   
    } catch (err) {
        res.json({message : err}).status(400)
    }
    
});


// Update food entry 
foodEntryRoute.post('/update/:id', async (req, res) => {
    try {
        const user = await userModel.findOne({id: req.body.user_id}) 
        if (user && (user.token === req.headers.authorization || req.headers.authorization === process.env.ADMIN_TOKEN)) {
            const updatedEntry = await foodModel.updateOne({id: req.params.id}, {$set: { name: req.body.name, cal_value: req.body.cal_value}})
            const item = await foodModel.findOne({id: req.params.id})
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

// Delete food Entry 
foodEntryRoute.delete('/:id', async (req, res) => {
    try {
        const user = await userModel.findOne({id: req.body.user_id}) 
        if (user && (user.token === req.headers.authorization || req.headers.authorization === process.env.ADMIN_TOKEN)) {
            const updatedEntry = await foodModel.deleteOne({id: req.params.id})
            const item = await foodModel.findOne({id: req.params.id})
            if (item) {
                res.sendStatus(404)
            } else {
                res.sendStatus(200)
            }   
        } else {
            res.status(401).json({})
        }
        
    } catch (err) {
        res.json({message : err}).status(400)
    }
    
});

// Get all food Entry with User_id
foodEntryRoute.get('/get/:user_id', async (req, res) => {
    try {
        const user = await userModel.findOne({id: req.params.user_id}) 
        if (user && (user.token === req.headers.authorization || req.headers.authorization === process.env.ADMIN_TOKEN)) {
            const allEntries = await foodModel.find({userId: req.params.user_id})
            if (allEntries) {
                res.status(200).json(allEntries);
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

// Get all food Entry For Admin
foodEntryRoute.get('/get', async (req, res) => {
    try {
        if (req.headers.authorization === process.env.ADMIN_TOKEN) {
            const allEntries = await foodModel.find()
            if (allEntries) {
                res.status(200).json(allEntries);
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


module.exports = foodEntryRoute
