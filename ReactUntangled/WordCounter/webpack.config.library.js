const path = require('path');

module.exports = {
    entry: { app: './src/index-library.js' },
    output: {
        path: path.resolve(__dirname),
        filename: 'library-bundle.js',
        libraryTarget: 'var',
        library: 'Wordcounter'
    },
    externals: {
        react: 'React',
        'react-dom': 'ReactDOM'
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                include: path.resolve(__dirname, 'src'),
                use: ['babel-loader']
            }
        ]
    }
};