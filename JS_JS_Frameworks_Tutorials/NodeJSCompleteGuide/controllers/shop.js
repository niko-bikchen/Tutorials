const Product = require('../models/product');

exports.getProducts = (req, res, next) => {
  Product.fetchAll(function renderProducts(products) {
    res.render('shop/product-list', {
      products: products,
      pageTitle: 'All Products',
      path: '/products'
    });
  });
};

exports.getProduct = (req, res, next) => {
  const productId = req.params.productId;

  Product.getById(productId, (product) => {
    res.render('shop/product-detail', {
      pageTitle: product.title,
      path: '/products',
      product
    });
  });
};

exports.getIndex = (req, res, next) => {
  Product.fetchAll(function renderProducts(products) {
    res.render('shop/index', {
      products: products,
      pageTitle: 'Shop',
      path: '/'
    });
  });
};

exports.getCart = (req, res, next) => {
  res.render('shop/cart', {
    path: '/cart',
    pageTitle: 'Cart'
  });
};

exports.getOrders = (req, res, next) => {
  res.render('shop/orders', {
    path: '/orders',
    pageTitle: 'Your Orders'
  });
};

exports.getCheckout = (req, res, next) => {
  res.render('shop/checkout', {
    path: '/checkout',
    pageTitle: 'Checkout'
  });
};
