React = require('react')
ReactDOM = require('react-dom')
Datepicker = require('./datepicker')

element = document.createElement('div')
document.body.appendChild(element)

{div, input} = React.DOM
ReactDOM.unmountComponentAtNode(element)
ReactDOM.render(
  div(
    null
    input(type: 'text')
    Datepicker()
  )
, element)
