const mongoose = require('mongoose')

//Food Entry Schema 
const foodEntrySchema = mongoose.Schema({
    id: String,
    userId: String,
    name: String,
    thumbUrl: String,
    date: String,
    time: String,
    timestamp: Number,
    cal_value: Number
})

module.exports = mongoose.model('foodEntry', foodEntrySchema);
