const express = require('express');

const app = express();

// app.use(function handleRequest1(req, res, next) {
//   console.log('Hello from handler #1!');
//   next();
// });

// app.use(function handleRequest2(req, res, next) {
//   console.log('Hello from handler #2!');
//   res.send('<h1>Hello there!</h1>');
// });

app.use('/users', function handleUsers(req, res, next) {
  res.send('<h1>Welcome to "/users"!</h1>');
});

app.use('/', function handleRoot(req, res, next) {
  res.send('<h1>Welcome to "/"!</h1>');
});

app.listen(3000);
