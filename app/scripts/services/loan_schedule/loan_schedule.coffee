paymentSchedule = (info) ->
  # extract info
  amount      = +info.amount
  payments    = +info.payments
  graceMonths = +info.graceMonths

  schedule = [amount]
  schedule.push 0 for [0...graceMonths]
  schedule.push -amount / payments for [0...payments]
  schedule

