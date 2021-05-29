const Product = require('../models/product');

exports.getAddProduct = (req, res, next) => {
  res.render('admin/add-product', {
    pageTitle: 'Add New Product',
    path: '/admin/add-product',
    activeAddProduct: true,
    formsCSS: true,
    productCSS: true
  });
};

exports.postAddProduct = (req, res, next) => {
  const { title, imageurl, description, price } = req.body;

  const product = new Product(title, imageurl, description, price);
  product.save();

  res.redirect('/');
};

exports.getProducts = (req, res, next) => {
  Product.fetchAll(function renderProducts(products) {
    res.render('admin/products', {
      products: products,
      pageTitle: 'Admin Products',
      path: '/admin/products'
    });
  });
};
