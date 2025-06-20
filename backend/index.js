const express = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

// Enable CORS
app.use(cors());

app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from Node backend!jksdfhjksdhgkjsd' });
});

app.listen(PORT, () => {
  console.log(`✅ Backend running at http://localhost:${PORT}`);
});
