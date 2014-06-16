angular.module('llRisk')
  .controller('RepaymentsCtrl', ($scope) ->
    $scope.loanAmount         = 7000
    $scope.gracePayments      = 4
    $scope.gracePaymentAmount = 50
    $scope.payments           = 12

    $scope.balancesChartData = [key: "Loan Balances"]
    $scope.paymentsChartData = [
      {key: "Loan Interest", color: 'orange'}
      {key: "Loan Principal", color: 'green'}
    ]

    refreshLoan = ->
      $scope.loan = new LoanWithInterest $scope.loanAmount,
                                         $scope.studentRate,
                                         $scope.gracePayments,
                                         $scope.gracePaymentAmount,
                                         $scope.payments

      # hack: ignore initial principal payment by setting it to zero,
      # and offset interest payments by 1
      $scope.loan.interest.pop()
      $scope.loan.interest.unshift 0
      $scope.loan.principal[0] = 0

      $scope.balancesChartData[0].values = $scope.loan.balances.map  (d, i) -> [i + 1, d]
      $scope.paymentsChartData[0].values = $scope.loan.interest.map  (d, i) -> [i + 1, d]
      $scope.paymentsChartData[1].values = $scope.loan.principal.map (d, i) -> [i + 1, d]


    $scope.$watch 'loanAmount',         refreshLoan
    $scope.$watch 'studentRate',        refreshLoan
    $scope.$watch 'gracePayments',      refreshLoan
    $scope.$watch 'gracePaymentAmount', refreshLoan
    $scope.$watch 'payments',           refreshLoan
  )
