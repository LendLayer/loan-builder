angular.module('llRisk.filters', [])
  .filter('titlecase', ->
    (str) ->
      return '' if str is undefined or str is null

      str.replace(/_|-/, ' ').replace /\w\S*/g, (txt) ->
        txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
  )

