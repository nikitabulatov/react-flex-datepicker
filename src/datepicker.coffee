React = require('react')
Header = require('./header')
MonthHeader = require('./month_header')
Days = require('./days')
Input = require('./input')
{isEqual, diff} = require('finity-js')

NOOP = ->

module.exports = React.createFactory(React.createClass(
  displayName: 'DatePicker'

  propTypes:
    cssClass: React.PropTypes.string
    cssModifier: React.PropTypes.string
    inputCssClass: React.PropTypes.string
    dayChildrenFunc: React.PropTypes.func
    dayCssClassFunc: React.PropTypes.func
    onSelect: React.PropTypes.func
    onDraw: React.PropTypes.func
    i18n: React.PropTypes.shape(
      previousMonth: React.PropTypes.string
      nextMonth: React.PropTypes.string
      months: React.PropTypes.array
      monthsShort: React.PropTypes.array
      weekdays: React.PropTypes.array
      weekdaysShort: React.PropTypes.array
    )
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)
    startDate: React.PropTypes.instanceOf(Date)
    range: React.PropTypes.oneOf(['from', 'to'])
    selected: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Date))
    firstDate: React.PropTypes.oneOf([0, 1])
    dateFormat: React.PropTypes.string
    inputFunc: React.PropTypes.func

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
    inputCssClass: ''
    dateFormat: 'mm/dd/yyyy'
    minDate: new Date(null)
    maxDate: new Date(9999, 1, 1)
    i18n:
      previousMonth: 'Previous month'
      nextMonth: 'Next month'
      months: 'January February March April May June July August September October November December'.split(' ')
      monthsShort: 'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec'.split(' ')
      weekdays: 'Sunday Monday Tuesday Wednesday Thursday Friday Saturday'.split(' ')
      weekdaysShort: 'Sun Mon Tue Wed Thu Fri Sat'.split(' ')

  getInitialState: ->
    currentMonth: @props.startDate
    selected: @props.selected

  componentWillUpdate: (_prevProps, prevState) ->
    @props.onDraw(@state.currentMonth) unless isEqual(@state.currentMonth, prevState.currentMonth, 'day')

  componentDidMount: ->
    @props.onDraw(@state.currentMonth)

  render: ->
    {div} = React.DOM
    index = 0
    index = 1 if @props.range == 'to'
    div(
      className: "#{@props.cssClass} #{@props.cssModifier || ''}"
      Input(
        inputFunc: @props.inputFunc
        inputCssClass: @props.inputCssClass
        dateFormat: @props.dateFormat
        selected: @state.selected[index]
        minDate: @props.minDate
        maxDate: @props.maxDate
        cssClass: @props.cssClass
        i18n: @props.i18n
        onChange: @handleInputChange
      )
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
        minDate: @props.minDate
        maxDate: @props.maxDate
      )
      @props.children
    )

  handleMonthChange: (date) ->
    @setState(currentMonth: date)

  handleDayClick: (date) ->
    selected = @_getNewSelectedRange(date)
    @setState(selected: selected)
    @props.onSelect(date, selected)

  handleInputChange: (date) ->
    selected = @_getNewSelectedRange(date)
    @setState(currentMonth: date, selected: selected)
    @props.onSelect(date, selected)

  _getNewSelectedRange: (date) ->
    selected = [from, to] = @props.selected
    if @props.range is 'from'
      selected[0] = date
      selected[1] = date if diff(date, to) > 0
    else if @props.range is 'to'
      selected[1] = date
      selected[0] = date if diff(date, from) < 0
    else
      selected[0] = date
    selected
))
