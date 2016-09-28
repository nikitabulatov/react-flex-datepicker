React = require('react')
Datepicker = require('react-flex-datepicker')
require('react-flex-datepicker/dist/css/datepicker.min.css')

module.exports = React.createFactory(React.createClass(
  getInitialState: ->
    example1: new Date()

  render: ->
    {strong, div, pre} = React.DOM
    div(null,
      strong(null, 'Simple use')
      div(null, "Selected: #{@state.example1}")
      Datepicker(
        selected: [new Date()]
        onSelect: (date) =>
          @setState(example1: date)
      )
      pre(null, 'Datepicker()')
    )
    # div(null,
    #   strong(null, 'With ')
    #   Datepicker()
    #   pre(null, 'Datepicker()')
    # )
))
