angular.module('llRisk')
  .controller('NavBarCtrl', [
    '$scope', '$state',
    ($scope,   $state) ->
      # all non-blank state names i.e. not the root state
      $scope.states = $state.get().map((state) ->
        state.name
      ).filter (name) -> name

      $scope.$state = $state
  ])
