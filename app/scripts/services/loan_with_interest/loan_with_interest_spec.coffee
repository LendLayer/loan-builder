describe LoanWithInterest, ->
  describe 'a 12-month loan paid back in one lump sum', ->
    amount = "1000"
    rate = "11.5"
    graceMonths = "12"
    gracePayment = "0"
    payments = "1"
    loan = new LoanWithInterest amount, rate, graceMonths, gracePayment, payments

    it 'is 14 months long', ->
      expect(loan.balances.length).toEqual 14

    it 'starts at the principal amount', ->
      expect(loan.balances[0]).toEqual amount

    it 'accrues 11.5% of interest after a year', ->
      expect(loan.balances[12]).toBeCloseTo amount * (1 + rate/100), 10

    it 'is paid off after a year and 1 month', ->
      expect(loan.balances[13]).toBeCloseTo 0, 10

    it 'calculates interest', ->
      correctInterest = [9.112468436904608, 9.19550551791819, 9.279299271711603, 9.363856593441666, 9.449184441097103, 9.53528983607109, 9.622179863739026, 9.709861674041568, 9.79834248207298, 9.887629568674852, 9.977730281035207, 10.068652033293088, 10.160402307148647, 0]
      expect(loan.interest).toEqual correctInterest

    it 'calculates principal', ->
      correctPrincipal = [-1000, -9.112468436904578, -9.19550551791815, -9.27929927171158, -9.363856593441596, -9.449184441097032, -9.535289836071115, -9.62217986373912, -9.709861674041576, -9.79834248207294, -9.88762956867481, -9.977730281035292, -10.06865203329312, 1115.000000000001]
      expect(loan.principal).toEqual correctPrincipal

  describe 'a loan with grace payments and normal payments', ->
    amount = "500"
    rate = "9.0"
    graceMonths = "2"
    gracePayment = "10"
    payments = "4"
    loan = new LoanWithInterest amount, rate, graceMonths, gracePayment, payments

    it 'is 14 months long', ->
      expect(loan.balances.length).toEqual 7

    it 'starts at the principal amount', ->
      expect(loan.balances[0]).toEqual amount

    it 'is fully paid by the end', ->
      expect(loan.balances[6]).toBeCloseTo 0, 6

    it 'calculates the correct balances', ->
      balances = loan.balances
      correctBalances = [500, 493.6036617, 487.1612228, 366.6797107, 245.3298493, 123.1053803, 0]

      for i in [0...balances.length]
        expect(balances[i]).toBeCloseTo correctBalances[i], 6
