angular.module('llRisk')
  .value('schoolName', 'Hack Reactor')
  .run([
    '$rootScope', 'schoolName',
    ($rootScope,   schoolName) ->
      $rootScope.schoolName = schoolName
   ])

