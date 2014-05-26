class Loan
  constructor: (loan_info) ->
    @amount        = +loan_info.amount
    @grace_months  = +loan_info.grace_months
    @payments      = +loan_info.payments
    @interest_rate = +loan_info.interest_rate
