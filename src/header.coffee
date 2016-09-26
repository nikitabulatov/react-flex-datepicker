React = require('react')

module.exports = React.createFactory(React.createClass(
  propTypes:
    cssClass: React.PropTypes.string
    onChange: React.PropTypes.func
    i18n: React.PropTypes.object
    date: React.PropTypes.instanceOf(Date)
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)

  render: ->
    {div, span, button} = React.DOM

    div(
      className: "#{@props.cssClass}__header"
      button(
        onClick: @handleButtonClick.bind(this, -1)
        className: "#{@props.cssClass}__arrow --left"
        '←'
      )
      span(
        className: "#{@props.cssClass}__month-year"
        @_getMonthYear()
      )
      button(
        onClick: @handleButtonClick.bind(this, 1)
        className: "#{@props.cssClass}__arrow --right"
        '→'
      )
    )

  _getMonthYear: ->
    [year, month] = [@props.date.getFullYear(), @props.date.getMonth()]
    "#{@props.months[month]} #{year}"

  handleButtonClick: (month) ->
    date = new Date(@props.date)
    date.setMonth(date.getMonth() + month)
    @props.onChange(date) if @props.minDate <= date <= @props.maxDate
))
