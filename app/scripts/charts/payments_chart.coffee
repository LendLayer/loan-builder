d3.chart 'PaymentsChart',
  initialize: ->
    chart = @

    @base.classed 'payments-chart', true

    # default height and width
    @w = @base.attr('width') || parseInt(@base.style('width')) || 600
    @h = @base.attr('height') || parseInt(@base.style('height')) || 400

    # chart margins to account for labels.
    # we may want to have setters for this
    # if we were letting the users customize this too
    @margins =
      top: 20
      bottom: 40
      left: 80
      right: 0
      bar_padding: 10

    # default chart ranges
    @x =  d3.scale.linear()
      .range([0, @w - @margins.left])

    @y = d3.scale.linear()
      .range([@h - @margins.bottom, 0])

    # non data driven areas (as in not to be independently drawn)
    @areas = {}

    # make sections for labels and main area
    #  _________________
    # |Y|    plot      |
    # | |              |
    # | |              |
    # | |              |
    # | |______________|
    #   |      X       |

    # -- areas
    @areas.xlabels = @base.append('g')
      .classed('xlabels', true)
      .attr('width', @w - @margins.left)
      .attr('height', @margins.bottom)
      .attr('transform', 'translate(' + @margins.left + ',' +
        (@h - @margins.bottom) + ')')

    @areas.ylabels = @base.append('g')
      .classed('ylabels', true)
      .attr('width', @margins.left)
      .attr('height', @h - @margins.bottom - @margins.top)
      .attr('transform', "translate(#{@margins.left-1},#{@margins.top})")

    @areas.plot = @base.append('g')
      .classed('plot', true)
      .attr('width', @w - @margins.left)
      .attr('height', @h - @margins.bottom - @margins.top)
      .attr('transform', "translate(#{@margins.left},#{20 + @margins.top})")

    # make actual layers
    @layer('bars', @areas.plot, {
      # data format:
      # [ { name : x-axis-bar-label, value : N }, ...]
      dataBind: (data) ->
        @selectAll('rect')
          .data(data)

      insert: ->
        @append('rect')
          .classed('bar', true)
    })

    # a layer for the x text labels.
    @layer('xlabels', @areas.xlabels, {
      dataBind: (data) ->
        # first append a line to the top.
        @append('line')
          .attr('x1', 0)
          .attr('x2', chart.w - chart.margins.left)
          .attr('y1', 0)
          .attr('y2', 0)
          .style('stroke-width', '1')
          .style('shape-rendering', 'crispEdges')

        @selectAll('text')
          .data(data)

      insert: ->
        @append('text')
          .classed('label', true)
          .attr('text-anchor', 'middle')
          .attr('x', (d, i) -> chart.x(i) - 0.5 + chart.bar_width/2)
          .attr('dy', '1em')
          .text((d) -> d.name)
    })

    # on new/update data
    # render the bars.
    onEnter = ->
      @attr('x', (d, i) -> chart.x(i) - 0.5)
        .attr('y', (d) -> chart.h - chart.margins.bottom - chart.margins.top - chart.y(chart.datamax - d) - 0.5)
        .attr('val', (d) -> d)
        .attr('width', chart.bar_width)
        .attr('height', (d) -> 1 + chart.y(chart.datamax - d))

    @layer('bars').on('enter', onEnter)
    @layer('bars').on('update', onEnter)

  transform: (data) ->
    # save the data in case we need to reset it
    @data = data

    # how many bars?
    @bars = data.length

    # compute box size
    @bar_width = (@w - @margins.left - ((@bars - 1) *
      @margins.bar_padding)) / @bars

    # adjust the x domain - the number of bars.
    @x.domain [0, @bars]

    # adjust the y domain - find the max in the data.
    @datamax = @usermax or d3.max(data, (d) -> d)

    @y.domain [0, @datamax]

    # draw yaxis
    yAxis = d3.svg.axis()
      .scale(@y)
      .orient('left')
      .ticks(4)
      .tickFormat((d) -> "$#{d}")
      # .tickFormat(@y.tickFormat('$,'))

    if(@displayYAxis)
      @areas.ylabels.call(yAxis)

    data

  # return or set the max of the data. otherwise
  # it will use the data max.
  max: (datamax) ->
    unless arguments.length then return @usermax

    @usermax = datamax

    if @data then @draw @data

    @

  width: (newWidth) ->
    unless arguments.length then return @w

    # save new width
    @w = newWidth

    # adjust the x scale range
    @x =  d3.scale.linear()
      .range([@margins.left, @w - @margins.right])

    # adjust the base width
    @base.attr('width', @w)

    @draw @data

    @

  height: (newHeight) ->
    unless arguments.length then return @h

    # save new height
    @h = newHeight

    # adjust the y scale
    @y = d3.scale.linear()
      .range([@h - @margins.top, @margins.bottom])

    # adjust the base width
    @base.attr('height', @h)

    @draw(@data)

    @

  displayYAxis: (display) ->
    unless arguments.length then return @displayYAxis

    @displayYAxis = display

    @

