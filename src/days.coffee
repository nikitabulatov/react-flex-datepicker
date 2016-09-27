React = require('react')
classNames = require('classnames')
{addDays, isEqualDates, isEqualMonths, getMonthDates} = require('./utils')

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
    dates = getMonthDates(@props.currentMonth)
    dates = @_getPreviousDates(dates[0]).concat(dates, @_getNextDates(dates[dates.length-1]))
    div(
      className: "#{@props.cssClass}__days"
      for date, i in dates
        isPreviousMonth = not isEqualMonths(@props.currentMonth, date) and @props.currentMonth > date
        isNextMonth = not isEqualMonths(@props.currentMonth, date) and @props.currentMonth < date
        span(
          className: @_getClassNames(date, isPreviousMonth, isNextMonth)
          onClick: @handleClick.bind(this, date, isPreviousMonth, isNextMonth)
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
    cssModifier = ''
    if isPreviousMonth or isNextMonth
      cssModifier += ' --is-empty'
    else if @_isSelected(date)
      cssModifier += ' --selected'
    classNames(
      "#{@props.cssClass}__day"
      cssModifier
      @_getRangeClass(date)
      @props.cssClassFunc(date)
    )

  _getPreviousDates: (first) ->
    date = new Date(first)
    days = if date.getDay() then date.getDay()-1 else 6
    return [] unless days
    dates = for i in [1..days]
      addDays(date, -i)
    dates.reverse()

  _getNextDates: (last) ->
    date = new Date(last)
    return [] unless last.getDay()
    days = 6 - date.getDay()
    addDays(date, i) for i in [1..days+1]

  handleClick: (date, isPreviousMonth, isNextMonth) ->
    @props.onClick(date) if not isPreviousMonth and not isNextMonth
))
