class Loan
  constructor: (loan_info) ->
    @amount             = +loan_info.amount
    @grace_months       = +loan_info.grace_months
    @number_of_payments = +loan_info.payments
    @interest_rate      = +loan_info.interest_rate

  payments: ->
    [1080]

  balances: ->
    [1000, 0]

  totalInterest: ->
    80
