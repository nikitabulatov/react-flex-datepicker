React = require('react')

module.exports = ({labels, cssClass}) ->
  {div, span} = React.DOM

  div(
    className: "#{cssClass}__month-header"
    for item, i in labels
      span(
        key: i
        className: "#{cssClass}__weekday"
        item
      )
  )
