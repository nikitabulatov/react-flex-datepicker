webpack = require('webpack')
CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  devtool: 'eval-cheap-module-source-map'
  entry:
    main: './src/index.coffee'
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: './'
    filename: 'datepicker.js'
  module:
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
      { test: /\.css$/, loader: 'style!css' }
    ]
  plugins: [
    new CopyWebpackPlugin([context: 'src/', from: '*.html', to: './'])
  ]
}
