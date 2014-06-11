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

    $scope.meanDefault = ->
      rates = $scope.studentDefaultRates[0]
      sum = 0
      sum += (+rate)*p for rate, p of rates
      sum 
  
    $scope.studentChartData = [key: "Student Default Rates"]
    setChartData = (newRates, oldRates, scope) ->
      values = ([+rate, probability] for rate, probability of newRates[0])
      $scope.studentChartData[0].values = values

    $scope.$watch 'studentDefaultRates', setChartData, true

    $scope.schoolDefaultProbability = 0.15

    $scope.schoolChartData = [
      key: "School Default Probability"
      values: [["p", $scope.schoolDefaultProbability]]
    ]

    $scope.$watch 'schoolDefaultProbability', (newProbability) ->
      $scope.schoolChartData[0].values[0][1] = +newProbability
  )
  .controller('ModelCtrl', ($scope) ->
  )
