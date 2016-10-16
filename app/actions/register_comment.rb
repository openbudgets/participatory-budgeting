class RegisterComment
  def self.call(text, voter, proposal, parent)
    new(text, voter, proposal, parent).call
  end

  def call
    @comment.persisted?
  end

  private

  def initialize(text, voter, proposal, parent)
    @comment = Comment.create(text: text, voter: voter, proposal: proposal, parent: parent)
  end
end