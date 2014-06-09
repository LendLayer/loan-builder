angular.module('llRisk')
  .directive('studentDefaultRates', ->
    restrict: 'E'
    replace: true
    scope: false
    template: '<div class="spreadsheet" ng-grid="gridOptions"></div>'
    link:
      pre: (scope, iElem, iAttrs) ->
        scope.gridOptions =
          data: 'studentDefaultRates'
          enableCellSelection: true
          enableRowSelection: false
          enableCellEdit: true
          enableCellEditOnFocus: true
          columnDefs: [
            { field: '0', displayName: '0%', width: "*", resizable: false, enableCellEdit: false, enableCellEditOnFocus: false}
            { field: '10', displayName: '10%', width: "*", resizable: false}
            { field: '20', displayName: '20%', width: "*", resizable: false}
            { field: '30', displayName: '30%', width: "*", resizable: false}
            { field: '40', displayName: '40%', width: "*", resizable: false}
            { field: '50', displayName: '50%', width: "*", resizable: false}
            { field: '60', displayName: '60%', width: "*", resizable: false}
            { field: '70', displayName: '70%', width: "*", resizable: false}
            { field: '80', displayName: '80%', width: "*", resizable: false}
            { field: '90', displayName: '90%', width: "*", resizable: false}
            { field: '100', displayName: '100%', width: "*", resizable: false}
          ]

        setZeroDefaultProbability = (newRates, oldRates, scope) ->
          # calculate the chance of no defaults from all other defaults
          zeroDefaultProbability = 1

          for rate, probability of newRates[0] when rate isnt '0'
            zeroDefaultProbability -= probability

          newRates[0]['0'] = +zeroDefaultProbability.toFixed(10)

        scope.$watch 'studentDefaultRates', setZeroDefaultProbability, true
      post: (scope, iElem, iAttrs) ->

  )

