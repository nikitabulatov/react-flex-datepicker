webpack = require('webpack')
ExtractTextPlugin = require('extract-text-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  devtool: 'eval-cheap-module-source-map'
  entry:
    main: './src/index.coffee'
    css: './src/scss/main.scss'
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: 'build/'
    filename: 'datepicker.js'
  module:
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          'style'
          'css!sass'
          raw: true
        )
      }
    ]
  plugins: [
    new ExtractTextPlugin('css/datepicker.css'),
    new CopyWebpackPlugin([context: 'src/', from: '*.html'])
  ]
}
