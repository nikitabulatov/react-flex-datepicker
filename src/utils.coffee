module.exports = {
  dateInMonth: (date, dateMonth) ->
    return unless date instanceof Date
    date.getMonth() is dateMonth.getMonth() and date.getYear() is dateMonth.getYear()

  getFirstMonthDate: (date) ->
    return unless date instanceof Date
    date = new Date(date)
    date.setDate(1)
    date

  addDays: (date = new Date(), days) ->
    date = new Date(date)
    date.setDate(date.getDate() + days)
    date

  isEqualDates: (firstDate = new Date(), lastDate = new Date()) ->
    firstDate.getDate() is lastDate.getDate() and
      firstDate.getMonth() is lastDate.getMonth() and
      firstDate.getFullYear() is lastDate.getFullYear()
}
