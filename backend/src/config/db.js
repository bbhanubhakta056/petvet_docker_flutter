const mongoose = require('mongoose');

/** * Connect to MongoDB using Mongoose
 * @returns {Promise<void>}
 * @description This function connects to the MongoDB database using Mongoose.
 * It reads the MongoDB URI from environment variables or defaults to a local MongoDB instance.
 * It logs a success message if the connection is established or an error message if it fails.
 */
const connectDB = async () => {
  try {
    // Read MongoDB URI from environment variable or use default
    // This allows for flexibility in different environments (development, production, etc.)
    const mongoURI = process.env.MONGO_URI || 'mongodb://localhost:27017/petvet';
    await mongoose.connect(mongoURI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('✅ MongoDB connected successfully');
  } catch (error) {
    console.error('❌ MongoDB connection failed:', error.message);
    process.exit(1); // Exit the process with failure
  }
}

module.exports = connectDB;
