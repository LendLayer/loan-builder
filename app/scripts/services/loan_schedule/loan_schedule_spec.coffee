describe paymentSchedule, ->
  schedule = null
  setSchedule = (info) ->
    schedule = paymentSchedule info

  describe 'a loan that is paid back in full after 1 month', ->
    beforeEach ->
      setSchedule
        amount: "1000"
        graceMonths: "0"
        payments: "1"
        interestRate: "8.0"

    it 'calculates the balances', ->
      expect(schedule).toEqual [
        1000
        -1000
      ]

  describe 'a loan that is paid back over 6 months', ->
    beforeEach ->
      setSchedule
        amount: "12000"
        graceMonths: "0"
        payments: "6"
        interestRate: "8.0"

    it 'calculates the balances', ->
      expect(schedule).toEqual [
       12000
       -2000
       -2000
       -2000
       -2000
       -2000
       -2000
      ]

  describe 'a loan with a 2-month grace period and a 3-month term', ->
    beforeEach ->
      setSchedule
        amount: "9000"
        graceMonths: "2"
        payments: "3"
        interestRate: "8.0"

    it 'calculates the balances', ->
      expect(schedule).toEqual [
        9000
        0
        0
        -3000
        -3000
        -3000
      ]
