! Part 2 !
• Installign webpack
* npm i --save-dev webpack webpack-cli
* (If you add "start" script to npm calling webpack it will run defaul webpack configuration.
   Default entry point is index.js in src dir
   Default output is main.js in dist dir
   Default mode - production)
* Webpack wraps our code in some "webpack majic code" when bundling, cause webpack doesn't just append our code to the bundle.
! Part 3 !
* By using import statements we show what files depend on what.
* From entry point react start resolving dependencies and later bundling
! Part 4 !
• Webpack config
* output: {
    filename: just the name of the bundle
    path: where to put a bundle
  }
* --config "name of the config file" - tells the webpack to use a certain config file
* devTool prop set to none removes evals from bundles
* creates webpack modules when bundling (kinda wraps file contents in a function)
* replaces import s tatement with __webpack_require__("path to the import source")
! Part 5 !
• Loaders
* css-loader - takes css and turns it into valid js
* style-loader - injects css into DOM
! Part 6 !
• Cache Busting & plugins
* Place [contentHash] inside a file name to generate hash based on the file contents
* When we are using cache busting we no longer can put script tag in our html since script file
  has hash in it which can change. Thus we can tell webpack to make html for us.
npm i --save-dev html-webpack-plugin
* plugins - prop which contains array of plugin instances
* HtmlWebpackPlugin() - generates html from a template and inserts script tag there
* HtmlWebpackPlugin({
    template: "path to your template, may be html file"
})
! Part 7 !
* npm i --save-dev webpack-merge - Merges two webpack config files.
* npm i --save-dev webpack-dev-server
"start": "webpack-dev-server --config webpack.dev.js --open" - starts a webpack dev server and opens a browser window
! Part 8 !
* npm i --save-dev html-loader - Html loader finds src attributes in img in the html and requires them in js
* npm i --save-dev file-loader 
* Image compression may be required
* npm i --save-dev clean-webpack-plugin - Removes unnecessary (old, the one you generated earlier and don't use) .js files from dist folder
! Part 10 !
npm i --save-dev mini-css-extract-plugin
* MiniCssExtractPlugin extracts css into separate file instead of style tags
npm i --save-dev optimize-css-assets-webpack-plugin