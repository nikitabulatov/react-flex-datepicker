webpack = require('webpack')
ExtractTextPlugin = require('extract-text-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')

prod = if 'production' == process.env.NODE_ENV then true else false

module.exports = {
  devtool: if prod then '' else 'eval-cheap-module-source-map'
  entry:
    main: ['./src/index.coffee', './src/scss/main.scss']
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: 'build',
    filename: '[name].bundle.js',
    publicPath: '/'
  module:
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
      { test: /\.(png|jpg|gif|svg)$/, loader: 'url-loader?limit=8192&name=images/[name].[ext]' }
      { test: /\.less$/, loader: 'style!css!less' }
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          'style'
          'css?sourceMap!sass?sourceMap'
          raw: true
        )
      }
    ]
  plugins: [
    new ExtractTextPlugin('css/[name].css')
    new CopyWebpackPlugin([context: 'src/', from: '*.html'])
  ]
}
