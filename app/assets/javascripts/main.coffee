window.App ||= {}

# Initialize on document ready
$( document ).ready () ->

  if $('body').hasClass('proposals') && $('body').hasClass('voting')

    # Proposals index
    if $('body').hasClass('index')
      new App.ProposalsVoteManager

    # Proposals show
    else if $('body').hasClass('show')
      new App.ProposalsVoteManager true

    # Proposals summarize  
    else if $('body').hasClass('summarize')
      new App.ProposalsTreemap 'proposals-treemap'

  else if $('body').hasClass('proposals') && $('body').hasClass('monitoring')

    # Monitoring proposals index
    if $('body').hasClass('index')
      new App.ProposalsFilter true

    # Proposals summarize
    else if $('body').hasClass('summarize')
      new App.ProposalsTreemap 'proposals-treemap'