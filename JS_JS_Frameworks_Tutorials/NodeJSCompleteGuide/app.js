const path = require('path');

const express = require('express');
const bodyParser = require('body-parser');
// const expressHbs = require('express-handlebars');

const app = express();

// Registering the Handlebars templating engine.
// app.engine(
//   'hbs',
//   expressHbs({
//     extname: 'hbs',
//     layoutsDir: 'views/layouts',
//     defaultLayout: 'main-layout'
//   })
// );

app.set('view engine', 'ejs');
app.set('views', 'views');

const adminData = require('./routes/admin');
const shopRoutes = require('./routes/shop');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

app.use('/admin', adminData.router);
app.use(shopRoutes);

app.use(function handleNotFound(req, res, next) {
  // res.status(404).sendFile(path.join(__dirname, 'views', '404.html'));
  res.status(404).render('404', {
    pageTitle: 'Page Not Found!',
  });
});

app.listen(3000);
