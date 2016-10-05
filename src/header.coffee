React = require('react')
{addMonths, isDateInRange} = require('finity-js')

module.exports = React.createFactory(React.createClass(
  displayName: 'DatePickerHeader'

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
      # TODO: Teach disable
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
    date = addMonths(@props.date, month)
    date.setDate(@props.minDate.getDate())
    @props.onChange(date) if isDateInRange(date, @props.minDate, @props.maxDate)
))
