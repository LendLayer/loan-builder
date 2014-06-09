angular.module('llRisk')
  .controller('HomeCtrl', ($scope) ->
    $scope.loanInfo =
      amount: '2000'
      graceMonths: '4'
      payments: '8'
      interestRate: '6.5'

    $scope.$watchCollection 'loanInfo', (loanInfo) ->
      schedule = paymentSchedule loanInfo
      $scope.loan = new Loan schedule, loanInfo.interestRate

    $scope.studentDefaultRates = [
      '10': 0.2
      '20': 0.26
      '30': 0.22
      '40': 0.12
      '50': 0.08
      '60': 0.03
      '70': 0.01
      '80': 0.0
      '90': 0.0
      '100': 0.0
    ]
  
    $scope.studentChartData = [{key: "Student Default Rates"}]
    setChartData = (newRates, oldRates, scope) ->
      values = ([+rate, probability] for rate, probability of newRates[0])
      $scope.studentChartData[0].values = values

    $scope.$watch 'studentDefaultRates', setChartData, true
  )
  .controller('ModelCtrl', ($scope) ->
  )
