# Flexible React DatePicker

## Example
```javascript
var React = require('react');
var DatePicker = require('react-flex-datepicker');
require('react-flex-datepicker/dist/datepicker.css');

element = document.createElement('div')
document.body.appendChild(element)

ReactDOM.unmountComponentAtNode(element)
ReactDOM.render(
  DatePicker({
    onSelect: function(date) {
      // ..
    }
  })
, element)
```

## Props
#### cssClass
type: **`String`**

#### cssModifier
type: **`String`**

#### dayChildrenFunc
type: **`Function`** arguments: `Date` rendering date

#### dayCssClassFunc
type: **`Function`** arguments: `Date` rendering date

### onDraw
type: **`Function`** arguments: `Date` rendering month date

### i18n
type: **`Object`** keys: {previousMonth, nextMonth, months, weekdays, weekdaysShort}

### minDate
type: **`Date`**

### maxDate
type: **`Date`**

### startDate
type: **`Date`**

### range
type: **`String`** one of: ['from', 'to']

### selected
type: **`Array`** of `Date`
