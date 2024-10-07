const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');
const mysql = require('mysql2');

// Initialize Express
const app = express();
app.use(bodyParser.json());
app.use(cors());

// MongoDB (NoSQL) connection
mongoose.connect('mongodb://localhost:27017/studentERP', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('MongoDB connected'))
  .catch(err => console.error(err));

// MySQL connection
const mysqlConnection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'studentERP'
});

mysqlConnection.connect(err => {
  if (err) throw err;
  console.log('MySQL connected');
});

// Test route
app.get('/', (req, res) => {
  res.send('Student ERP backend is running');
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
