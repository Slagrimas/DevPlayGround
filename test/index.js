const express = require('express');
const bodyParser = require('body-parser');
const PORT = 9000;

// INIT
const app = express();

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())

// READ
app.get('/', (req,res) => {
  // Serve Home Content here
  res.json({
    message: 'Read route',
    method: 'GET'
  });
});

// CREATE
app.post('/new', (req,res) => {
  let { email, password } = req.body;
  // Create new user here
  res.json({
    message: 'Create new route',
    method: 'POST',
    body: req.body
  });
});

// UPDATE
app.post('/edit', (req,res) => {
  let { email, password } = req.body;
  // Edit user here
  res.json({
    message: 'Edit route',
    method: 'POST',
    body: req.body
  });
});

// DELETE/ARCHIVE
app.post('/archive', (req,res) => {
  let { email, password } = req.body;
  // Archive user here
  res.json({
    message: 'Archive route',
    method: 'POST',
    body: req.body
  });
});

// LISTEN
app.listen(PORT, () => {
  console.log(`Listening on port: ${PORT}`)
});
