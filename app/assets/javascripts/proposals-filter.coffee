window.App ||= {}

class App.ProposalsFilter

  budget_max:       0
  budget_from:      0
  budget_to:        0

  isMonitoring:     false

  $proposalsCont:   null

  $filterMenu:      null


  constructor: ( _isMonitoring, _proposalsCont ) ->

    @isMonitoring   = _isMonitoring
    @$proposalsCont = if _proposalsCont then _proposalsCont else $('.proposals-cont')

    # Get budget variables
    @budget_max  = $('.vote-progress .vote-progress-amount').data('max-amount')   # TODO: check if it's the right way
    @budget_from = $('#budget-range-slider').data('from')
    @budget_to   = $('#budget-range-slider').data('to')

    @$filterMenu         = $('.proposals-filter-menu')
  
    # Listen changes on filter inputs
    @$filterMenu.find('input.form-check-input, select').change @onFilterChange
    @$filterMenu.find('.card-header').click @onFilterMenuCollapse
    
    # Setup range slider with Ion RangeSlider & listen when update
    $('#budget-range-slider').ionRangeSlider
      onFinish: (data) =>
        @budget_from = data.from
        @budget_to = data.to
        @onFilterChange()


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
      url: if @isMonitoring then '/monitoring/proposals' else '/voting/proposals'
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
