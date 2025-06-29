const mongoose = require('mongoose');
const UserSchema = new mongoose.Schema({
    name: String,
    phone: String,
    email: String,
    address: String,
    username: String,
    password: String,
    userType: {
        type: String,
        enum: ['user', 'business', 'admin'],
        default: 'user',
    },
    hasClub: {
        type: Boolean,
        default: false,
    },
    isVet: {
        type: Boolean,
        default: false,
    },
    hasShop: {
        type: Boolean,
        default: false,
    },
    profilePic: String,
    dob: Date,
});
module.exports = mongoose.model('User', UserSchema);
