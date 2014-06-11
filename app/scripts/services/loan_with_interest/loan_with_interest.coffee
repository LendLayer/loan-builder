class LoanWithInterest
  constructor: (@amount, rate, @gracePayments, @gracePaymentAmount, @payments) ->
    @annualRate = (1 + rate/100)
    @monthlyRate = Math.pow @annualRate, 1/12

  graceBalances: ->
    balances = [@amount]
    for i in [0...@gracePayments]
      [...,latest] = balances
      balances.push latest * @monthlyRate - @gracePaymentAmount

    balances

  balances: ->
    balances = @graceBalances()
    for i in [0...@payments]
      [...,latest] = balances
      balances.push latest * @monthlyRate - 1115 * @monthlyRate

    balances
