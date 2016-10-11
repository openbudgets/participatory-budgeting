window.App ||= {}

class App.ProposalsVoteManager

  budget_max:       0
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

    # Listen click on vote proposal btn
    $('.proposal .vote-btn').click @onVoteChange

    # Only for proposals#index
    unless @isSingleProposal

      # Get budget variables
      @budget_max  = $('.vote-progress .vote-progress-amount').data('max-amount')   # TODO: check if it's the right way
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
      @updateVoteProgress()


  onScroll: =>

    if $(window).scrollTop() >= @headerOffsetTop and !@$container.hasClass('sticky')
      @$container.addClass('sticky')
    else if $(window).scrollTop() < @headerOffsetTop and @$container.hasClass('sticky')
      @$container.removeClass('sticky')


  # Update Vote on click
  onVoteChange: (e) =>
    
    $btn = $(e.target)

    # Send ajax petition to proposals/:id
    $.ajax({
      url:  '/voting/proposals/'+$btn.data('id')
      type: 'PATCH'
    }).done (e) =>
      # Toogle btn state
      $btn.toggleClass 'active'
      # Update Vote progress
      unless @isSingleProposal
        @updateVoteProgress()


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
      url:  '/voting/proposals'
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


  # Update Vote progress
  updateVoteProgress: ->
    
    # Get voted budget
    votedBudget = 0
    @$proposalsCont.find('.proposal').each () ->
      if $(this).find('.vote-btn').hasClass('active')
        votedBudget += parseFloat( $(this).data('budget') )
    budgetPercentage = 100*votedBudget/@budget_max

    # Update total amount
    @$voteProgressAmount.html votedBudget.toLocaleString('en-EN')+' € <small>('+(budgetPercentage|0)+' %)</small>'

    # Setup state for vote progress bar & vote finish btn
    if votedBudget > @budget_max
      if !@$voteFinish.hasClass('disabled')
        @$voteFinish.attr('disabled', true).addClass('disabled')
      @$voteProgressBar.removeClass('progress-success').addClass('progress-danger')
    else
      if votedBudget > 0 and @$voteFinish.hasClass('disabled')
        @$voteFinish.attr('disabled', false).removeClass('disabled')
      else if votedBudget == 0 and !@$voteFinish.hasClass('disabled')
        @$voteFinish.attr('disabled', true).addClass('disabled')
      @$voteProgressBar.addClass('progress-success').removeClass('progress-danger')

    # Animate progress bar
    @$voteProgressBar.animate { value: budgetPercentage }, 800
    @$voteProgressBar.find('.progress-bar').animate { width: budgetPercentage }, 800
