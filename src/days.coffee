React = require('react')
classNames = require('classnames')
{getFirstMonthDate, addDays, isEqualDates} = require('./utils')

module.exports = React.createFactory(React.createClass(
  propTypes:
    cssClass: React.PropTypes.string
    cssClassFunc: React.PropTypes.func
    childrenFunc: React.PropTypes.func
    currentMonth: React.PropTypes.instanceOf(Date)
    selected: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Date))
    onClick: React.PropTypes.func

  render: ->
    {div, span} = React.DOM
    firstDate = getFirstMonthDate(@props.currentMonth)
    firstDay = firstDate.getDay()
    rows = if firstDay > 5 then 6 else 5
    div(
      className: "#{@props.cssClass}__days"
      for i in [0..7*rows-1]
        isPreviousMonth = i+1 < firstDay
        add = if isPreviousMonth then -(firstDay-i) else i - firstDay
        date = addDays(firstDate, add)
        isNextMonth = firstDate.getMonth() < date.getMonth()
        span(
          className: @_getClassNames(date, isPreviousMonth, isNextMonth)
          onClick: @props.onClick.bind(null, date)
          key: i
          @props.childrenFunc(date)
        )
    )

  _isSelected: (date) ->
    for selected in @props.selected when isEqualDates(selected, date)
      return true
    false

  _getRangeClass: (date) ->
    [from, to] = @props.selected
    return '' if not to or not from
    if isEqualDates(from, date)
      return '--is-range-start'
    else if isEqualDates(to, date)
      return '--is-range-end'
    else if from < date < to
      return '--is-in-range'
    else
      return ''

  _getClassNames: (date, isPreviousMonth, isNextMonth) ->
    cssModifier = if isPreviousMonth or isNextMonth
      '--disabled'
    else if @_isSelected(date)
      '--selected'
    else
      ''
    classNames(
      "#{@props.cssClass}__day"
      cssModifier
      @_getRangeClass(date)
      @props.cssClassFunc(date)
    )
))
