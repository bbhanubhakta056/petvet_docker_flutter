const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./src/config/db');

// Load environment variables from .env file
dotenv.config();
// Connect to MongoDB
connectDB();

// Initialize Express app
const app = express();
// Middleware to parse JSON requests
app.use(express.json());

// Enable CORS
app.use(cors());

//routes 
app.use('/api/user', require('./src/routes/userRoute'));
app.use('/api/pets', require('./src/routes/petRoute'));
// Add other routes as needed
// Example: app.use('/api/anotherRoute', require('./src/routes/anotherRoute'));

// Test route to verify backend is running
app.get('/', (req, res) => {
  res.json({ message: 'backend is working!' });
});

// Example route to test CORS
app.get('/api/test-cors', (req, res) => {
  res.json({ message: 'CORS is working!' });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

// Set the port from environment variable or default to 5000
// This allows for flexibility in different environments (development, production, etc.)
const PORT = process.env.PORT || 3000;

// Start the server
app.listen(PORT, () => {
  console.log(`✅ Backend running at http://localhost:${PORT}`);
});
