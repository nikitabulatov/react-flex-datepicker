React = require('react')
{format, parse, isDateInRange} = require('finity-js')

module.exports = React.createFactory(React.createClass(
  displayName: 'DatePickerInput'

  propTypes:
    dateFormat: React.PropTypes.string.isRequired
    inputFunc: React.PropTypes.func
    selected: React.PropTypes.instanceOf(Date)
    minDate: React.PropTypes.instanceOf(Date)
    maxDate: React.PropTypes.instanceOf(Date)
    inputCssClass: React.PropTypes.string
    onChange: React.PropTypes.func.isRequired
    cssClass: React.PropTypes.string.isRequired
    i18n: React.PropTypes.shape(
      previousMonth: React.PropTypes.string
      nextMonth: React.PropTypes.string
      months: React.PropTypes.array
      monthsShort: React.PropTypes.array
      weekdays: React.PropTypes.array
      weekdaysShort: React.PropTypes.array
    ).isRequired

  getInitialState: ->
    value = @_getValue()
    {value, validValue: value}

  componentWillReceiveProps: (nextProps) ->
    value = @_getValue(nextProps)
    @setState({value, validValue: value})

  render: ->
    {input} = React.DOM
    props =
      value: @state.value
      onBlur: @_handleBlur
      onChange: @_handleChange
      onKeyPress: @_handleKeyPress
      className: "#{@props.cssClass}__input #{@props.inputCssClass}"
    if @props.inputFunc
      @props.inputFunc(props)
    else
      input(props)

  _submit: (value) ->
    date = parse(value, @props.dateFormat, @props.i18n)
    if date and isDateInRange(date, @props.minDate, @props.maxDate)
      @setState(validValue: value)
      @props.onChange(date)
    else
      @setState(value: @state.validValue)

  _handleChange: ({target}) ->
    value = target.value
    @setState({value})

  _handleKeyPress: ({key}) ->
    @_submit(@state.value) if key == 'Enter'

  _handleBlur: ->
    @_submit(@state.value)

  _getValue: (props = @props) ->
    return format(props.selected, props.dateFormat, true, props.i18n) if props.selected
    ''
))
