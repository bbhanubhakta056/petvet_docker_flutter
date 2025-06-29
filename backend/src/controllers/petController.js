const Pet = require('../models/pet');

/** * Get all pets
 * @route GET /api/pets
 * @returns {Promise<Response>} - Returns a list of all pets
 * @description This endpoint retrieves all pets from the database.
 * It returns a JSON response containing an array of pet objects.
 */
const getAllPets = async (req, res) => {
  try {
    const pets = await Pet.find();
    res.status(200).json(pets);
  } catch (error) {
    console.error('Error fetching pets:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}

/** * Create a new pet
 * @route POST /api/pets
 * @param {Object} req.body - Pet data
 * @returns {Promise<Response>} - Returns the created pet object
 * @description This endpoint creates a new pet in the database.
 * It expects a JSON request body containing pet data.
 */
const createPet = async (req, res) => {
  try {
    const newPet = new Pet(req.body);
    await newPet.save();
    res.status(201).json({ message: 'Pet Added', data: newPet });
  } catch (error) {
    console.error('Error creating pet:', error);
    res.status(400).json({ message: 'Bad request', error: error.message });
  }
}

module.exports = {
    getAllPets,
    createPet,
    // Add other pet-related functions as needed
    // For example: getPetById, updatePetById, deletePetById, etc.
};
