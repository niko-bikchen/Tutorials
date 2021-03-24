const path = require('path');

const express = require('express');

const rootDir = require('../helpers/path');
const adminData = require('./admin');

const router = express.Router();

router.get('/', (req, res, next) => {
  // Sending out static HTML files.
  // console.log(adminData.products);
  // res.sendFile(path.join(rootDir, 'views', 'shop.html'));
  // Sending out rendered HTML template.
  const products = adminData.products;
  res.render('shop', {
    products,
    pageTitle: 'Shop',
    path: '/',
    activeShop: true,
    productCSS: true,
  });
});

module.exports = router;
