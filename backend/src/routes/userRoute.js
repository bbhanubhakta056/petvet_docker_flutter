const express = require('express');
const router = express.Router();
const { getAllUsers, createUser, getUserById, updateUserById, deleteUserById, authenticateUser } = require('../controllers/userController');

// Route to get all users
router.get('/', getAllUsers);

// Route to create a new user
router.post('/', createUser);

// Route to authenticate a user (login)
// This route is used for user login and should validate the user's credentials
router.post('/auth/login', authenticateUser);


// Route to get a user by ID
router.get('/:id', getUserById);

// Route to update a user by ID
router.put('/:id', updateUserById);

// Route to delete a user by ID
router.delete('/:id', deleteUserById);

// Export the router to be used in the main app
module.exports = router;