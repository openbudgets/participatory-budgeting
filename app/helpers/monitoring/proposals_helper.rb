module Monitoring::ProposalsHelper
  def comments_count_for(proposal)
    count = proposal.comments.count
    return _('No comments') if count.zero?
    pluralize(count, _('comment'))
  end

  def author_of(comment)
    comment.voter.name || _('Voter')
  end

  def time_from(comment)
    _('%{time} ago') % { time: time_ago_in_words(comment.created_at) }
  end
end