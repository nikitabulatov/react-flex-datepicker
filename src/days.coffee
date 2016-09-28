React = require('react')
{addDays, isEqualDates, isEqualMonths, getMonthDates, daysDiff} = require('./utils')

module.exports = React.createFactory(React.createClass(
  propTypes:
    range: React.PropTypes.oneOf(['from', 'to'])
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
    return '--is-in-range' if from < date < to
    range = ''
    range += '--is-range-start' if isEqualDates(from, date)
    range += ' --is-range-end' if isEqualDates(to, date)
    range

  _getClassNames: (date, isPreviousMonth, isNextMonth) ->
    cssModifier = ''
    if isPreviousMonth or isNextMonth
      cssModifier += ' --is-empty'
    else if @_isSelected(date)
      cssModifier += ' --selected'
    "#{@props.cssClass}__day #{cssModifier} #{@_getRangeClass(date)} #{@props.cssClassFunc(date)}"

  _getPreviousDates: (first) ->
    days = if first.getDay() then first.getDay()-1 else 6
    return [] unless days
    dates = for i in [1..days]
      addDays(first, -i)
    dates.reverse()

  _getNextDates: (last) ->
    return [] unless last.getDay()
    days = 6 - last.getDay()
    addDays(last, i) for i in [1..days+1]

  handleClick: (date, isPreviousMonth, isNextMonth) ->
    return if isPreviousMonth or isNextMonth
    selected = [from, to] = @props.selected
    if @props.range is 'from'
      selected[0] = date
      selected[1] = date if daysDiff(date, to) > 0
    else if @props.range is 'to'
      selected[1] = date
      selected[0] = date if daysDiff(date, from) < 0
    else
      selected[0] = date

    @props.onClick(date, selected)
))
