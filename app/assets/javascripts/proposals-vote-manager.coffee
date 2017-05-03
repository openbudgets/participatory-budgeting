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
      @$voteProgressBar    = $('.vote-progress .vote-progress-bar .progress-bar')
      @$voteProgressAmount = $('.vote-progress .vote-progress-amount')
      @$filterMenu         = $('.proposals-filter-menu')
      @headerOffsetTop     = $('.vote-header').offset().top

      # Setup proposals filter
      new App.ProposalsFilter false, @$proposalsCont

      # Setup Scrollspy for vote-header
      $(window).scroll @onScroll

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
    @$voteProgressBar.attr 'aria-valuenow', budgetPercentage
    @$voteProgressBar.attr 'style', 'width: '+budgetPercentage+'%;'
