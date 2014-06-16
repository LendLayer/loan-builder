angular.module('llRisk')
  .controller('RepaymentsCtrl', ($scope) ->
    $scope.loanAmount         = 7000
    $scope.gracePayments      = 4
    $scope.gracePaymentAmount = 50
    $scope.payments           = 12

    $scope.balancesChartData = [key: "Loan Balances"]
    $scope.interestChartData = [key: "Loan Interest"]

    refreshLoan = ->
      $scope.loan = new LoanWithInterest $scope.loanAmount,
                                         $scope.studentRate,
                                         $scope.gracePayments,
                                         $scope.gracePaymentAmount,
                                         $scope.payments

      $scope.balancesChartData[0].values = $scope.loan.balances.map  (d, i) -> [i + 1, d]
      $scope.interestChartData[0].values = $scope.loan.interest.map  (d, i) -> [i + 1, d]

    $scope.$watch 'loanAmount',         refreshLoan
    $scope.$watch 'studentRate',        refreshLoan
    $scope.$watch 'gracePayments',      refreshLoan
    $scope.$watch 'gracePaymentAmount', refreshLoan
    $scope.$watch 'payments',           refreshLoan
  )
