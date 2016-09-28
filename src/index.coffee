ReactDOM = require('react-dom')
Examples = require('./examples')

element = document.querySelector('.js-examples')

ReactDOM.unmountComponentAtNode(element)
ReactDOM.render(
  Examples()
, element)
