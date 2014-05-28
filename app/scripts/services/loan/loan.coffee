class Loan
  constructor: (@schedule, @rate) ->

  netPresentValue: (amount, months) =>
    annualDepreciation = 1 / (1 + @rate / 100.0)
    amount * Math.pow(annualDepreciation, months/12.0)

  balances: ->
    accumulator = 0
    accumulator += payment for payment in @schedule

  cost: ->
    values = (@netPresentValue amount, month for amount, month in @schedule)
    values.reduce (sum, amount) -> sum + amount

  maxMonthlyPayment: ->
    -Math.min @schedule...

