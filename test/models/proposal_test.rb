require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  def some_classifiers; [districts(:downtown), areas(:environment), tags(:parks)]; end

  setup do
    @proposal = Proposal.new(title: not_blank, description: not_blank, budget: zero_or_positive_number)
    @classifier_ids = []
  end

  test "should be valid" do
    assert @proposal.valid?
  end

  test "shouldn't have been chosen" do
    assert @proposal.voters.blank?
  end

  test "may have some classifiers" do
    @proposal.classifiers = some_classifiers
    @proposal.save!
    assert_equal some_classifiers.to_set, @proposal.classifiers.to_set
  end

  test "title shouldn't be blank" do
    @proposal.title = blank
    assert_not @proposal.valid?
  end

  test "description shouldn't be blank" do
    @proposal.description = blank
    assert_not @proposal.valid?
  end

  test "budget amount shouldn't be negative" do
    @proposal.budget = negative_number
    assert_not @proposal.valid?
  end

  test "should filter for given district ids" do
    @classifier_ids << districts(:downtown).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 3, proposals.count

    @classifier_ids << districts(:suburbs).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 6, proposals.count

    @classifier_ids << districts(:riverland).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 9, proposals.count
  end

  test "should filter for given area ids" do
    @classifier_ids << areas(:environment).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 6, proposals.count

    @classifier_ids << areas(:culture).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 6, proposals.count
  end

  test "should filter for given tag ids" do
    @classifier_ids << tags(:bicycles).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 3, proposals.count

    @classifier_ids << tags(:parks).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 6, proposals.count
  end

  test "should filter for combinations of different types of classifier ids" do
    @classifier_ids << districts(:downtown).id << areas(:environment).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 2, proposals.count

    @classifier_ids << tags(:parks).id
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 1, proposals.count

    @classifier_ids << districts(:riverland) << tags(:bicycles)
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 4, proposals.count
  end

  test "shouldn't filter if no classifier_ids are given" do
    proposals = Proposal.with_class(*@classifier_ids)
    assert_equal 9, proposals.count
  end
end
