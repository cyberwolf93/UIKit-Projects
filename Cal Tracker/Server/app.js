//mongodb+srv://toptalCalTracker:<password>@cluster0.iaaroje.mongodb.net/test

const express = require('express')
require("dotenv").config();
const app = express()
const mongoose = require('mongoose')
const bodyParser = require('body-parser')
const path = require('path');


//Import Routes
const userRoute = require('./Router/userRoute')
const foodEntryRoute = require('./Router/foodEntryRoute')

//Middle 
app.use(bodyParser.json())
app.use('/user', userRoute)
app.use('/foodentry', foodEntryRoute)
app.use(express.static(path.join(__dirname, 'public')));

//Connect to DB
mongoose.connect('mongodb+srv://toptalCalTracker:KIxGws755IqcWzE9@cluster0.iaaroje.mongodb.net/test', () => {
    console.log("connected DB!")
})



app.listen(3000)