describe InterestFreeLoan, ->
  describe 'a loan that is paid back in full after 1 month', ->
    schedule = [1000, -1000]
    rate = 8.0
    loan = new InterestFreeLoan schedule, rate

    it 'calculates the balances', ->
      expect(loan.balances()).toEqual [
        1000
        0
      ]

    it 'calculates the total cost', ->
      expect(loan.cost()).toBeCloseTo 1000 * (1 - Math.pow 1/1.08, 1.0/12), 6

    it 'calcuates the max monthly payment', ->
      expect(loan.maxMonthlyPayment()).toEqual 1000

  describe 'a loan spread over 4 months', ->
    schedule = [6000, -1500, -1500, -1500, -1500]
    rate = 8.0
    loan = new InterestFreeLoan schedule, rate

    it 'calculates the balances', ->
      expect(loan.balances()).toEqual [
        6000
        4500
        3000
        1500
        0
      ]

    it 'calculates the total cost', ->
      expect(loan.cost()).toBeCloseTo 95.28, 2

    it 'calcuates the max monthly payment', ->
      expect(loan.maxMonthlyPayment()).toEqual 1500

  describe 'a loan with a grace period', ->
    schedule = [1000, 0, 0, -500, -500]
    rate = 10.0
    loan = new InterestFreeLoan schedule, rate

    it 'calculates the balances', ->
      expect(loan.balances()).toEqual [
        1000
        1000
        1000
        500
        0
      ]

    it 'calcuates the max monthly payment', ->
      expect(loan.maxMonthlyPayment()).toEqual 500

    it 'calculates the total cost', ->
      expect(loan.cost()).toBeCloseTo 27.408, 3
