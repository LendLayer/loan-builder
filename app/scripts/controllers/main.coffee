angular.module('insightFellowsApp')
  .controller('MainCtrl', ($scope) ->
    $scope.loanInfo =
      amount: 2000
      grace_months: 4
      payments: 8
      interest_rate: 6.5

    $scope.$watchCollection 'loanInfo', (loanInfo) ->
      schedule = paymentSchedule loanInfo
      $scope.loan = new Loan schedule, loanInfo.interestRate
  )
