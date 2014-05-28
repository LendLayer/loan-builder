angular.module('insightFellowsApp')
  .controller('MainCtrl', ($scope) ->
    $scope.loanInfo =
      amount: '2000'
      graceMonths: '4'
      payments: '8'
      interestRate: '6.5'

    $scope.$watchCollection 'loanInfo', (loanInfo) ->
      schedule = paymentSchedule loanInfo
      $scope.loan = new Loan schedule, loanInfo.interestRate
  )
