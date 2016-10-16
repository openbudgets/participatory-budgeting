module Monitoring::ProposalsHelper
  def comments_count_for(proposal)
    count = proposal.comments.count
    return "No comments" if count.zero?
    "#{pluralize(count, 'comment')}"
  end

  def author_of(comment)
    comment.voter.name || "Voter"
  end

  def time_from(comment)
    "#{time_ago_in_words comment.created_at} ago"
  end
end