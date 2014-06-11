describe LoanWithInterest, ->
  describe 'a 12-month loan paid back in one lump sum', ->
    amount = 1000
    rate = 11.5
    graceMonths = 12
    gracePayment = 0
    payments = 1
    loan = new LoanWithInterest amount, rate, graceMonths, gracePayment, payments

    it 'is 14 months long', ->
      console.log loan.balances()
      expect(loan.balances().length).toEqual 14

    it 'starts at the principal amount', ->
      expect(loan.balances()[0]).toEqual amount

    it 'accrues 11.5% of interest after a year', ->
      expect(loan.balances()[12]).toBeCloseTo amount * (1 + rate/100), 10

    it 'is paid off after a year and 1 month', ->
      expect(loan.balances()[13]).toBeCloseTo 0

