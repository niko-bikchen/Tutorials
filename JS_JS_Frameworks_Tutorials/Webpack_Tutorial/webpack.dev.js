const path = require("path");
const common = require("./webpack.common");
const merge = require("webpack-merge");

module.exports = merge(common, {
    mode: "development",
    output: {
        filename: "[name].bundle.js",
        path: path.resolve(__dirname, "dist")
    },
    module: {
        rules: [
            {
                test: /\.scss$/,
                use: [
                    "style-loader", // 3. Inject js css into <style> in the DOM
                    "css-loader", // 2. Turn css into js
                    "sass-loader" // 1. Turn sass into css
                ]
            }
        ]
    }
});