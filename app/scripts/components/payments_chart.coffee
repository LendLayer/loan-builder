angular.module('insightFellowsApp')
  .directive('paymentsChart', ->
    restrict: 'E'
    replace: true
    scope:
      loan: '='
    template: '<svg></svg>'
    link: (scope, iElem, iAttrs) ->
      chart = d3.select(iElem[0]).chart('PaymentsChart')

      scope.$watch 'loan', (loan) ->
        chart.draw loan.balances()
  )
