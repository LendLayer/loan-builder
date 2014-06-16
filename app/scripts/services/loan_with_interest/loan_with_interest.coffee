class LoanWithInterest
  constructor: (@amount, rate, @gracePayments, @gracePaymentAmount, @payments) ->
    @annualRate = (1 + rate/100)
    @monthlyRate = Math.pow @annualRate, 1/12

    installmentAmount = (startingBalance) =>
      monthlyRate_n = Math.pow @monthlyRate, @payments
      startingBalance * monthlyRate_n * (@monthlyRate - 1) / (monthlyRate_n - 1)

    balances = =>
      # initial balance
      balances = [@amount]

      # grace balances
      for i in [0...@gracePayments]
        [...,latest] = balances
        balances.push latest * @monthlyRate - @gracePaymentAmount

      # downpayment balances
      installment = installmentAmount balances[balances.length - 1]

      for i in [0...@payments]
        [...,latest] = balances
        balances.push latest * @monthlyRate - installment

      balances

    principal = =>
      principal = [-@balances[0]] # first principal payment is the initial payment

      for i in [0...@balances.length-1]
        principal.push @balances[i] - @balances[i+1]

      principal

    @balances = balances()
    @interest = (balance * (@monthlyRate - 1) for balance in @balances)
    @principal = principal()

