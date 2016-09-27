webpack = require('webpack')
ExtractTextPlugin = require('extract-text-webpack-plugin')
CopyWebpackPlugin = require('copy-webpack-plugin')

prod = if 'production' == process.env.NODE_ENV then true else false

path = if prod then 'dist/' else 'build/'
entry = if prod then 'datepicker' else 'index'
min = if prod then '.min' else ''

plugins = [new ExtractTextPlugin("css/datepicker#{min}.css")]
if prod
  plugins = plugins.concat([
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin(minimize: true,  compress: warnings: false)
  ])
else
  plugins = plugins.concat([new CopyWebpackPlugin([context: 'src/', from: '*.html'])])

module.exports = {
  devtool: if prod then '' else 'eval-cheap-module-source-map'
  entry:
    main: ["./src/#{entry}.coffee", './src/scss/main.scss']
  resolve:
    root: ['src']
    extensions: ['', '.js', '.coffee']
  output:
    path: path,
    filename: "datepicker#{min}.js",
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
  plugins
}
