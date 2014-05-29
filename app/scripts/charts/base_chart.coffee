angular.module('charts.BaseChart', [])
  .run ->
    d3.chart 'BaseChart',
      initialize: ->
        # default height and width
        @w = parseInt(@base.attr 'width')  || parseInt(@base.style('width'))  || 600
        @h = parseInt(@base.attr 'height') || parseInt(@base.style('height')) || 400

