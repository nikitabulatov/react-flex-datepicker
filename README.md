# Flexible React DatePicker

## Installation
```bash
  npm install react-flex-datepicker --save
```

## Example
```javascript
var React = require('react');
var ReactDOM = require('react-dom');
var Datepicker = require('react-flex-datepicker');
require('react-flex-datepicker/dist/css/datepicker.min.css');

var element = document.createElement('div');
document.body.appendChild(element);

element.style.width = '300px';
ReactDOM.unmountComponentAtNode(element);

ReactDOM.render(Datepicker(/* .. */), element);
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

### onSelect
type: **`Function`** arguments:
`Date` rendering month date
`Array` new selected array

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

### firstDay
type: **`Number`** first day of the week. only one of (0: Sunday, 1: Monday)
