React = require('react')

module.exports = ({labels, cssClass, firstDate}) ->
  {div, span} = React.DOM

  div(
    className: "#{cssClass}__month-header"
    for _item, i in labels
      key = i + firstDate
      key = 0 if key >= 7
      span(
        key: i
        className: "#{cssClass}__weekday"
        labels[key]
      )
  )
