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

  installmentAmount: (startingBalance) ->
    monthlyRate_n = Math.pow @monthlyRate, @payments
    startingBalance * monthlyRate_n * (@monthlyRate - 1) / (monthlyRate_n - 1)

  balances: ->
    balances = @graceBalances()
    installment = @installmentAmount balances[balances.length - 1]

    for i in [0...@payments]
      [...,latest] = balances
      balances.push latest * @monthlyRate - installment

    balances

  interest: ->
    balance * (@monthlyRate - 1) for balance in @balances()

  principal: ->
    balances = @balances()
    principal = [-balances[0]] # first principal payment is the initial payment

    for i in [0...balances.length-1]
      principal.push balances[i] - balances[i+1]

    principal
