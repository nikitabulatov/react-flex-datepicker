React = require('react')
{isDateInRange, addDays, isEqualDates, isEqualMonths, getMonthDates, diff} = require('finity-js')

module.exports = React.createFactory(React.createClass(
  displayName: 'DatePickerDays'

  propTypes:
    range: React.PropTypes.oneOf(['from', 'to'])
    cssClass: React.PropTypes.string
    cssClassFunc: React.PropTypes.func
    childrenFunc: React.PropTypes.func
    currentMonth: React.PropTypes.instanceOf(Date)
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)
    selected: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Date))
    onClick: React.PropTypes.func
    firstDate: React.PropTypes.number

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
    return '--in-range' if from < date < to
    range = ''
    range += '--range-start' if isEqualDates(from, date)
    # FIXME: --range-end date to always equal last date in range :(
    range += ' --range-end' if isEqualDates(to, date)
    range

  _getClassModifier: (date, isPreviousMonth, isNextMonth) ->
    {minDate, maxDate} = @props
    cssModifier = ''
    cssModifier += ' --disabled' if isPreviousMonth or isNextMonth or not isDateInRange(date, minDate, maxDate)
    cssModifier += ' --selected' if @_isSelected(date)
    cssModifier

  _getClassNames: (date, isPreviousMonth, isNextMonth) ->
    cssModifier = @_getClassModifier(date, isPreviousMonth, isNextMonth)
    rangeClass = @_getRangeClass(date)
    cssClass = "#{@props.cssClass}__day"
    cssClass += " #{cssModifier}" if cssModifier
    cssClass += " #{rangeClass}" if rangeClass
    cssClass += " #{@props.cssClassFunc(date) || ''}"
    cssClass

  _getPreviousDates: (first) ->
    if @props.firstDate
      days = if first.getDay() then first.getDay()-1 else 6
      return [] unless days
    else
      return [] unless first.getDay()
      days = if first.getDay() then first.getDay() else 6
    dates = for i in [1..days]
      addDays(first, -i)
    dates.reverse()

  _getNextDates: (last) ->
    days = 6 - last.getDay()
    if @props.firstDate
      return [] unless last.getDay()
      addDays(last, i) for i in [1..days+1]
    else
      return [] if last.getDay() == 6
      addDays(last, i) for i in [1..days]

  handleClick: (date, isPreviousMonth, isNextMonth) ->
    return if isPreviousMonth or isNextMonth or not isDateInRange(date, @props.minDate, @props.maxDate)
    @props.onClick(date)
))
