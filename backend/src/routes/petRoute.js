const express = require('express');
const router = express.Router();

const {
    getAllPets,
    createPet,
    // Add other pet-related functions as needed
    // For example: getPetById, updatePetById, deletePetById, etc.
} = require('../controllers/petController');

// Route to get all pets
router.get('/', getAllPets);

// Route to create a new pet
router.post('/', createPet);

// Add other routes as needed
// For example: router.get('/:id', getPetById);
// router.put('/:id', updatePetById);
// router.delete('/:id', deletePetById);

// Export the router to be used in the main app
module.exports = router;