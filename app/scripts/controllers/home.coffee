angular.module('llRisk')
  .controller('HomeCtrl', ($scope) ->
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

    $scope.schoolDefaultProbability = 0.15
    $scope.schoolCoversFirst = 0.15
    $scope.schoolSubsidy = 0.15

    $scope.studentChartData        = [key: "Student Default Rates"]
    $scope.schoolChartData         = [key: "School Default Probability"]
    $scope.schoolDefaultsChartData = [key: "Default Rates when School Defaults"]
    $scope.schoolPaysChartData     = [key: "Default Rates when School Pays"]

    subsidise = (studentRate) ->
      Math.max 0, (+studentRate - $scope.schoolCoversFirst * 100) * (1 - $scope.schoolSubsidy)

    setChartData = ->
      rates = $scope.studentDefaultRates[0]
      $scope.studentChartData[0].values        = ([+rate, probability] for rate, probability of rates)
      $scope.schoolChartData[0].values         = [["p", $scope.schoolDefaultProbability]]
      $scope.schoolDefaultsChartData[0].values = ([+rate, probability*$scope.schoolDefaultProbability] for rate, probability of rates)
      $scope.schoolPaysChartData[0].values     = ([subsidise(rate), probability*(1-$scope.schoolDefaultProbability)] for rate, probability of rates)

    $scope.$watch 'studentDefaultRates', setChartData, true
    $scope.$watch 'schoolDefaultProbability', setChartData
    $scope.$watch 'schoolCoversFirst', setChartData
    $scope.$watch 'schoolSubsidy', setChartData

    expectedDefault = (rates) ->
      rates[0]?.values?.reduce ((acc, pair) ->  acc + pair[0] * pair[1]), 0

    $scope.expectedDefault = ->
      lossWhenSchoolDefaults = expectedDefault $scope.schoolDefaultsChartData
      lossWhenSchoolPays     = expectedDefault $scope.schoolPaysChartData
      lossWhenSchoolDefaults * $scope.schoolDefaultProbability +
        lossWhenSchoolPays   * (1 - $scope.schoolDefaultProbability)
  )
  .controller('ModelCtrl', ($scope) ->
  )
