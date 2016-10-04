window.App ||= {}

class App.ProposalsTreemap
  
  $el:           null
  $popover:      null
  width:         null
  height:        null
  treemap:       null
  root:          null
  fontSizeScale: null
  budgetFormat:  null

  constructor: (id) ->
    @initialize id

  initialize: (id) ->

    # setup main element
    @$el      = $('#'+id)
    @$popover = @$el.find('.popover')

    # get sizes
    @getSizes()

    # get proposals data
    data = @getProposals()

    @budgetFormat = d3.format(',d')

    color = d3.scaleOrdinal()
      .range d3.schemeCategory10

    @fontSizeScale = d3.scaleLinear()
      .domain [0, 1]
      .range [0.625, 3]

    stratify = d3.stratify()
      .parentId (d) -> return d.id.substring(0, d.id.lastIndexOf('.'))

    # Setup treemap & root
    @treemap = d3.treemap()
      .size     [@width, @height]
      .padding  1
      .round    true

    @root = stratify(data)
      .sum (d) -> return d.budget
      .sort (a, b) -> return b.value - a.value

    @treemap @root

    # Setup tree
    d3.select('#'+id)
    .selectAll('.node')
    .data @root.leaves()
    .enter().append('div')
      .attr  'class', 'node'
      #.attr  'title', (d) -> return d.id + '\n' + format(d.value)
      .style 'left', (d) -> return d.x0 + 'px'
      .style 'top', (d) -> return d.y0 + 'px'
      .style 'width', (d) -> return d.x1 - d.x0 + 'px'
      .style 'height', (d) -> return d.y1 - d.y0 + 'px'
      .style 'background', (d) -> 
        while (d.depth > 1)
          d = d.parent
        return color(d.id)
      .on 'mouseover', @onMouseOver
      .on 'mousemove', @onMouseMove
      .on 'mouseout',  @onMouseOut
    .append('div')
      .attr 'class', 'node-label'
      .append('p')
        .text (d) -> return d.data.title
        .style 'font-size', @getFontSize
    # .append('div')
    #   .attr 'class', 'node-value'
    #   .text (d) -> return @budgetFormat(d.value)

    # Listen resize event
    $(window).resize @resize


  # Get width & height
  getSizes: () ->

    @width   = @$el.width()

    # height based on width
    if @width > 1000
      @height = @width * 0.5
    else if @width > 700
      @height = @width * 0.5625
    else if @width > 500
      @height = @width * 0.75
    else
      @height = @width

    # update element height
    @$el.height @height


  # Get proposals data
  getProposals: () ->

    # initialize proposals array
    data = [
      { id: 'ob' }
    ]

    areas = []

    # populate array with proposals info
    $('.proposals-cont .proposal').each (i, proposal) =>
      
      area  = if $(proposal).data('area') then $(proposal).data('area') else 'Others'
      title = $(proposal).find('.proposal-title h3').html().trim()
      
      # add areas to data array
      if areas.indexOf(area) == -1
        areas.push area
        data.push { id: 'ob.'+@slugify(area) }
      
      # add proposal objets to data array
      data.push
        id:     'ob.'+@slugify(area)+'.'+$(proposal).data('id')
        title:  title
        area:   area
        budget: +$(proposal).data('budget')

    return data


  # Resize event handler
  resize: () =>

    if @width != @$el.width()

      # update sizes
      @getSizes()

      # update treemap with new sizes
      @treemap.size [@width, @height]
      @treemap @root

      # update nodes dimensions
      d3.selectAll('.node')
        .style 'left', (d) -> return d.x0 + 'px'
        .style 'top', (d) -> return d.y0 + 'px'
        .style 'width', (d) -> return d.x1 - d.x0 + 'px'
        .style 'height', (d) -> return d.y1 - d.y0 + 'px'


  onMouseOver: (e) =>
    # Setup content
    @$popover.find('.popover-area .tag-title').html e.data.area
    @$popover.find('.popover-title').html           e.data.title
    @$popover.find('.popover-budget strong').html   @budgetFormat(e.data.budget)
    # Show popover
    @$popover.show()


  onMouseMove: (e) =>
    # get element offset
    offset = @$el.offset()
    # Setup popover position
    @$el.find('.popover').css
      left: d3.event.pageX - offset.left - @$popover.width()*0.5
      top:  d3.event.pageY - offset.top - @$popover.height() - 12


  onMouseOut: (e) =>
    # Hide popover
    @$popover.hide()


  getFontSize: (d) =>
    size = Math.sqrt( (d.x1-d.x0) * (d.y1-d.y0) / (@width * @height) )
    return @fontSizeScale(size)+'rem'

  slugify: (s) ->
    return s
      .trim()
      .toLowerCase()
      .replace(/\s+/g, '-')
      .replace(/[^\w\-]+/g, '')
      .replace(/\-\-+/g, '-')
      .replace(/^-+/, '')
      .replace(/-+$/, '')
