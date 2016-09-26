React = require('react')
classNames = require('classnames')
Header = require('./header')
MonthHeader = require('./month_header')
Days = require('./days')
{dateInMonth} = require('./utils')

NOOP = ->

module.exports = React.createFactory(React.createClass(
  propTypes:
    cssClass: React.PropTypes.string
    cssModifier: React.PropTypes.string
    dayChildrenFunc: React.PropTypes.func
    dayCssClassFunc: React.PropTypes.func
    onChange: React.PropTypes.func
    onSelect: React.PropTypes.func
    onDraw: React.PropTypes.func
    i18n: React.PropTypes.object
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)
    startDate: React.PropTypes.instanceOf(Date)
    range: React.PropTypes.oneOf(['from', 'to'])
    selected: React.PropTypes.arrayOf(React.PropTypes.instanceOf(Date))

  getDefaultProps: ->
    maxDate = new Date()
    maxDate.setFullYear(maxDate.getFullYear() + 1)
    cssClass: 'avs-datepicker'
    onDraw: NOOP
    onSelect: NOOP
    dayChildrenFunc: (date) ->
      date.getDate()
    dayCssClassFunc: NOOP
    minDate: new Date()
    maxDate: maxDate
    startDate: new Date()
    range: 'from'
    selected: []
    i18n:
      previousMonth: 'Предыдущий месяц'
      nextMonth: 'Следующий месяц'
      months: 'Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь'.split(' ')
      weekdays: 'Воскресенье Понедельник Вторник Среда Четверг Пятница Суббота'.split(' ')
      weekdaysShort: 'пн вт ср чт пт сб вс'.split(' ')

  getInitialState: ->
    currentMonth: @props.startDate
    selected: @props.selected

  componentDidUpdate: ->
    console.log "redraw #{@state.currentMonth}"
    @props.onDraw(@state.currentMonth)

  componentDidMount: ->
    console.log "redraw #{@state.currentMonth}"
    @props.onDraw(@state.currentMonth)

  render: ->
    {div} = React.DOM
    div(
      className: classNames(@props.cssClass, @props.cssModifier)
      Header(
        months: @props.i18n.months
        date: @state.currentMonth
        onChange: @handleMonthChange
        cssClass: @props.cssClass
        minDate: @props.minDate
        maxDate: @props.maxDate
      )
      MonthHeader(labels: @props.i18n.weekdaysShort, cssClass: @props.cssClass)
      Days(
        childrenFunc: @props.dayChildrenFunc
        cssClassFunc: @props.dayCssClassFunc
        onClick: @handleDayClick
        selected: @state.selected
        cssClass: @props.cssClass
        currentMonth: @state.currentMonth
      )
      @props.children
    )

  handleMonthChange: (date = new Date()) ->
    @setState(currentMonth: date)

  handleDayClick: (date = new Date()) ->
    selected = for i in [0..1]
      index = if @props.range == 'from' then 0 else 1
      if i == index
        date
      else
        @state.selected[i]
    @setState(selected: selected)
    @props.onSelect(date)

))
