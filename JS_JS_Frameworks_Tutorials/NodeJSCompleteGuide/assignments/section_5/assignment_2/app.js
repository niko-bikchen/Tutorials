const path = require('path');

const express = require('express');

const rootDir = require('../../../helpers/path.js');

const app = express();
const currentFolderPath = rootDir;

app.use(express.static(path.join(currentFolderPath, 'public')));

app.get('/', function handleRoot(req, res, next) {
  res.sendFile(path.join(currentFolderPath, 'views', 'index.html'));
});

app.get('/users', function handleUsers(req, res, next) {
  res.sendFile(path.join(currentFolderPath, 'views', 'users.html'));
});

app.listen(3000);
