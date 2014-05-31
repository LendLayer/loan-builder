angular.module('llRisk.states', ['ui.router'])
  .config([
    '$stateProvider', '$urlRouterProvider'
    ($stateProvider,   $urlRouterProvider) ->
      $stateProvider.state('home'
        url: '/'
        templateUrl: 'views/home.html'
        controller: 'HomeCtrl'
      ).state('model'
        url: '/model'
        templateUrl: 'views/model.html'
        controller: 'ModelCtrl'
      )

      $urlRouterProvider.otherwise '/'
  ])
