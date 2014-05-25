'use strict';

angular.module('insightFellowsApp')
  .controller('MainCtrl', function ($scope) {
    $scope.loan = {
      amount: 2000,
      grace_months: 4,
      payments: 8,
      interest_rate: 6.5
    }
  })
