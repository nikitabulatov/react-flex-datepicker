addDays = (date = new Date(), days) ->
  date = new Date(date)
  date.setDate(date.getDate() + days)
  date

addMonths = (date = new Date(), months) ->
  date = new Date(date)
  date.setMonth(date.getMonth() + months)
  date

lastMonthDate = (date) ->
  return unless date instanceof Date
  date = addMonths(date, 1)
  date.setDate(0)
  date

isEqualDates = (firstDate, lastDate) ->
  return unless firstDate instanceof Date
  return unless lastDate instanceof Date
  firstDate.getDate() is lastDate.getDate() and
    firstDate.getMonth() is lastDate.getMonth() and
    firstDate.getFullYear() is lastDate.getFullYear()

isEqualMonths = (firstDate, lastDate) ->
  return unless firstDate instanceof Date
  return unless lastDate instanceof Date
  firstDate.getMonth() is lastDate.getMonth() and
    firstDate.getFullYear() is lastDate.getFullYear()

getMonthDates = (date = new Date()) ->
  date = new Date(date)
  date.setDate(1)
  addDays(date, i) for i in [0..lastMonthDate(date).getDate()-1]

daysDiff = (date1, date2) ->
  Math.ceil((date1 - date2) / (1000 * 3600 * 24))

module.exports = {
  addDays,
  addMonths,
  isEqualDates,
  isEqualMonths,
  lastMonthDate,
  getMonthDates,
  daysDiff
}
