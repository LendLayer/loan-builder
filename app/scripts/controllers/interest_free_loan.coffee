angular.module('llRisk')
  .controller('InterestFreeLoanCtrl', ($scope) ->
    $scope.loanInfo =
      amount: '2000'
      graceMonths: '4'
      payments: '8'
      interestRate: '6.5'

    $scope.$watchCollection 'loanInfo', (loanInfo) ->
      schedule = paymentSchedule loanInfo
      $scope.loan = new InterestFreeLoan schedule, loanInfo.interestRate

  )
