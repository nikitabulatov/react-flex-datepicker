webpack = require('webpack')
ExtractTextPlugin = require('extract-text-webpack-plugin')

module.exports = {
  entry:
    main: './src/datepicker.coffee'
    css: './src/scss/main.scss'
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: 'dist/'
    filename: 'datepicker.min.js'
    library: 'DatePicker'
    libraryTarget: 'umd'
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
    new ExtractTextPlugin('css/datepicker.min.css')
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin(minimize: true,  compress: warnings: false)
  ]
}
