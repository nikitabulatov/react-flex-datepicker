React = require('react')
ReactDOM = require('react-dom')
Datepicker = require('./datepicker')

element = document.createElement('div')
document.body.appendChild(element)
element.style.width = '300px'

{div, input} = React.DOM
ReactDOM.unmountComponentAtNode(element)
ReactDOM.render(
  div(
    null
    Datepicker(
      range: 'from'
      selected: [new Date(), new Date()]
    )
    Datepicker(
      range: 'to'
      selected: [new Date(), new Date()]
    )
  )
, element)
