const mongoose = require('mongoose')

// User schema
const userSchema = mongoose.Schema({
    id: String,
    name: String,
    email: String,
    password: String,
    token: String,
    isAdmin: Boolean,
    cal_limit: Number
})


module.exports = mongoose.model('user', userSchema)

