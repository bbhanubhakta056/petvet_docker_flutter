const mongoose = require('mongoose');

const PetSchema = new mongoose.Schema({
    name: {
        type: String,
        // required: true,
    },
    age: {
        type: Number,
        // required: true,
    },
    species: {
        type: String,
        // required: true,
    },
    breed: {
        type: String,
        // required: true,
    },
    gender: {
        type: String,
    },
    color: {
        type: String,
    },
    weight: {
        type: Number,
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        // required: true,
    },
    medicalHistory: [{
        type: String,
    }],
    createdAt: {
        type: Date,
        default: Date.now,
    },
    updatedAt: {
        type: Date,
        default: Date.now,
    },
});

module.exports = mongoose.model('Pet', PetSchema);