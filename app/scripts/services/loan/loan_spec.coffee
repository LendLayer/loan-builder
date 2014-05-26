describe Loan, ->
  loan = loan_info = null

  beforeEach ->
    loan = new Loan loan_info


  describe 'a loan that is paid back in full after 1 month', ->
    loan_info =
      amount: "1000"
      grace_months: "0"
      payments: "1"
      interest_rate: "8.0"

    it 'stores the info', ->
      expect(loan.amount       ).toBe(1000)
      expect(loan.grace_months ).toBe(0)
      expect(loan.payments     ).toBe(1)
      expect(loan.interest_rate).toBe(8.0)

