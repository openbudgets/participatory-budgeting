window.App ||= {}

class App.ProposalsMonitoringManager

  chosen:           0
  budget_from:      0
  budget_to:        0

  $container:          null
  $proposalsCont:      null
  $voteFinish:         null
  $voteProgressBar:    null
  $voteProgressAmount: null
  $filterMenu:         null
  headerOffsetTop:     null

  isSingleProposal:    false
   

  constructor: ( _isSingleProposal ) ->

    @isSingleProposal = _isSingleProposal

    # Only for proposals#index
    unless @isSingleProposal

      # Get budget variables
      @chosen      = $('.vote-progress .vote-progress-amount').data('chosen')   # TODO: check if it's the right way
      @budget_from = $('#budget-range-slider').data('from')
      @budget_to   = $('#budget-range-slider').data('to')

      @$container          = $('.main-container')
      @$proposalsCont      = $('.proposals-cont')
      @$voteFinish         = $('#vote-finish')
      @$voteProgressBar    = $('.vote-progress .vote-progress-bar')
      @$voteProgressAmount = $('.vote-progress .vote-progress-amount')
      @$filterMenu         = $('.proposals-filter-menu')
      @headerOffsetTop     = $('.vote-header').offset().top

    
      # Listen changes on filter inputs
      @$filterMenu.find('input.form-check-input, select').change @onFilterChange
      @$filterMenu.find('.card-header').click @onFilterMenuCollapse

      # Setup Scrollspy for vote-header
      $(window).scroll @onScroll
      
      # Setup range slider with Ion RangeSlider & listen when update
      $('#budget-range-slider').ionRangeSlider
        onFinish: (data) =>
          @budget_from = data.from
          @budget_to = data.to
          @onFilterChange()

      # Initialize Vote Progress
      @updateExecutionProgress()


  onScroll: =>

    if $(window).scrollTop() >= @headerOffsetTop and !@$container.hasClass('sticky')
      @$container.addClass('sticky')
    else if $(window).scrollTop() < @headerOffsetTop and @$container.hasClass('sticky')
      @$container.removeClass('sticky')


  # Update Proposals filtering
  onFilterChange: =>
    
    # Add visual feedback when filter starts
    @$proposalsCont.css('opacity', 0.5)

    # check if all classifiers are checked
    all_classifiers = true

    # Get selected classifiers ids
    classifiers = $('#classifier-district').val()
    if classifiers.indexOf(',') == -1
      all_classifiers = false
    @$filterMenu.find('input.form-check-input').each () ->
      if $(this).is(':checked')
        classifiers = classifiers+','+ $(this).val()
      else
        all_classifiers = false

    # Send ajax petition to proposals filter
    $.ajax(
      url:  '/monitoring/proposals'
      data: 
        class: if all_classifiers then '' else classifiers  # if all classifiers are checked we don't send class params
        budget_min: @budget_from
        budget_max: @budget_to
      type: 'GET'
    ).done (data) =>
      if data.proposals_ids
        # Show only returned proposals ids
        @$proposalsCont.find('.proposal').hide()

        if data.proposals_ids.length > 0
          $('#proposals-filter-empty').hide()
          data.proposals_ids.forEach (id) ->
            $('#proposal-'+id).show()
          @$proposalsCont.css('opacity', 1)
        else
          $('#proposals-filter-empty').show()
          @$proposalsCont.css('opacity', 1)
        
  # Make filter menú collapsable
  onFilterMenuCollapse: =>
    if @$filterMenu.find('.arrow').css('display') == 'block'
      @$filterMenu.find('.card-block').toggle()
      @$filterMenu.find('.arrow').toggleClass('collapsed')


  # Update execution progress
  updateExecutionProgress: ->
    
    # Get completed proposals
    completedProposals = 0
    @$proposalsCont.find('.proposal').each () ->
      if $(this).find('.more-info-btn').hasClass('completed')   # TODO: check if it's the right way
        completedProposals += 1
    executionPercentage = 100*completedProposals/@chosen

    # Update total completed
    @$voteProgressAmount.html completedProposals + ' / ' + @chosen + '<small>('+(executionPercentage|0)+' %)</small>'

    # Setup state for progress bar and summarize button
    @$voteProgressBar.addClass('progress-success').removeClass('progress-danger')
    @$voteFinish.attr('disabled', false).removeClass('disabled')

    # Animate progress bar
    @$voteProgressBar.animate { value: executionPercentage }, 800
    @$voteProgressBar.find('.progress-bar').animate { width: executionPercentage }, 800
