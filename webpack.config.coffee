webpack = require('webpack')
ExtractTextPlugin = require('extract-text-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  devtool: 'eval-cheap-module-source-map'
  entry:
    main: ['./src/index.coffee', './src/scss/main.scss']
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: 'build/'
    filename: "datepicker.js"
    library: 'DatePicker'
    libraryTarget: 'umd'
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
    new ExtractTextPlugin("css/datepicker.css"),
    new CopyWebpackPlugin([context: 'src/', from: '*.html'])
  ]
}
