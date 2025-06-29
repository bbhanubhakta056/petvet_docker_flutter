const User = require('../models/user');

/** * Get all users
 * @route GET /api/users
 * @returns {Promise<Response>} - Returns a list of all users
 * @description This endpoint retrieves all users from the database.
 * It returns a JSON response containing an array of user objects.
 */
const getAllUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}

/** * Create a new user
 * @route POST /api/users
 * @param {Object} req.body - User data
 * @returns {Promise<Response>} - Returns the created user object
 * @description This endpoint creates a new user in the database.
 * It expects a JSON request body containing user data.
 */
const createUser = async (req, res) => {
  try {
    const newUser = new User(req.body);
    await newUser.save();
    res.status(201).json({ message: 'User Added', data: newUser });
  } catch (error) {
    console.error('Error creating user:', error);
    res.status(400).json({ message: 'Bad request', error: error.message });
  }
}

const authenticateUser = async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username, password });
    if (!user) {
      return res.status(401).json({ message: 'Invalid credentials' });
    }
    res.status(200).json({ message: 'Login successful', user });
  } catch (error) {
    console.error('Error authenticating user:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}



/** * Get a user by ID
 * @route GET /api/users/:id
 * @param {string} req.params.id - User ID
 * @returns {Promise<Response>} - Returns the user object if found
 * @description This endpoint retrieves a user by their ID.
 */
const getUserById = async (req, res) => {
  try {
    const user = await User.findById(req.params.id);
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json(user);
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}

/** * Update a user by ID
 * @route PUT /api/users/:id
 * @param {string} req.params.id - User ID
 * @param {Object} req.body - Updated user data
 * @returns {Promise<Response>} - Returns the updated user object
 * @description This endpoint updates a user by their ID.
 */
const updateUserById = async (req, res) => {
  try {
    const updatedUser = await User.findByIdAndUpdate(
        req.params.id,
        req.body,
        { new: true, runValidators: true }
    );
    if (!updatedUser) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json(updatedUser);
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(400).json({ message: 'Bad request', error: error.message });
  }
}

/** * Delete a user by ID
 * @route DELETE /api/users/:id
 * @param {string} req.params.id - User ID
 * @returns {Promise<Response>} - Returns a success message if deleted
 * @description This endpoint deletes a user by their ID.
 */
const deleteUserById = async (req, res) => {
  try {
    const deletedUser = await User.findByIdAndDelete(req.params.id);
    if (!deletedUser) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json({ message: 'User deleted successfully' });
  } catch (error) {
    console.error('Error deleting user:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
}


/**
 * User Controller
 * This module contains functions to handle user-related operations such as
 * fetching, creating, updating, and deleting users.
 * It interacts with the User model to perform database operations.
 */

/** * @module userController
 * @description This module exports functions to handle user-related operations.
 * It includes functions to get all users, create a new user, get a user by ID,
 * update a user by ID, and delete a user by ID.
 */


// Exporting the controller functions for use in routes
// This allows the functions to be imported in the routes file and used as middleware
module.exports = {
  getAllUsers,
  createUser,
  getUserById,
  updateUserById,
  deleteUserById,
  authenticateUser
};