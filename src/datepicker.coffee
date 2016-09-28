React = require('react')
Header = require('./header')
MonthHeader = require('./month_header')
Days = require('./days')
{isEqualDates} = require('./utils')

NOOP = ->

module.exports = React.createFactory(React.createClass(
  propTypes:
    cssClass: React.PropTypes.string
    cssModifier: React.PropTypes.string
    dayChildrenFunc: React.PropTypes.func
    dayCssClassFunc: React.PropTypes.func
    onSelect: React.PropTypes.func
    onDraw: React.PropTypes.func
    i18n: React.PropTypes.object
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)
    startDate: React.PropTypes.instanceOf(Date)
    range: React.PropTypes.oneOf(['from', 'to'])
    selected: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Date))
    firstDate: React.PropTypes.oneOf([0, 1])

  getDefaultProps: ->
    cssClass: 'avs-datepicker'
    onDraw: NOOP
    onSelect: NOOP
    dayChildrenFunc: (date) ->
      date.getDate()
    dayCssClassFunc: NOOP
    startDate: new Date()
    range: 'from'
    selected: []
    firstDate: 0
    i18n:
      previousMonth: 'Previous month'
      nextMonth: 'Next month'
      months: 'January February March April May June July August September October November December'.split(' ')
      weekdays: 'Sunday Monday Tuesday Wednesday Thursday Friday Saturday'.split(' ')
      weekdaysShort: 'Sun Mon Tue Wed Thu Fri Sat'.split(' ')

  getInitialState: ->
    currentMonth: @props.startDate
    selected: @props.selected

  componentWillUpdate: (_prevProps, prevState) ->
    @props.onDraw(@state.currentMonth) unless isEqualDates(@state.currentMonth, prevState.currentMonth)

  componentDidMount: ->
    @props.onDraw(@state.currentMonth)

  render: ->
    {div} = React.DOM
    div(
      className: "#{@props.cssClass} #{@props.cssModifier}"
      Header(
        months: @props.i18n.months
        date: @state.currentMonth
        onChange: @handleMonthChange
        cssClass: @props.cssClass
        minDate: @props.minDate
        maxDate: @props.maxDate
      )
      MonthHeader(
        labels: @props.i18n.weekdaysShort
        cssClass: @props.cssClass
        firstDate: @props.firstDate
      )
      Days(
        childrenFunc: @props.dayChildrenFunc
        cssClassFunc: @props.dayCssClassFunc
        onClick: @handleDayClick
        selected: @state.selected
        cssClass: @props.cssClass
        currentMonth: @state.currentMonth
        range: @props.range
        firstDate: @props.firstDate
      )
      @props.children
    )

  handleMonthChange: (date) ->
    @setState(currentMonth: date)

  handleDayClick: (date, selected) ->
    @setState(selected: selected)
    @props.onSelect(date, selected)
))
