require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
  setup do
    @campaign = Campaign.new(title: not_blank, description: not_blank, budget: zero_or_positive_number, start_date: Date.today, end_date: Date.tomorrow)
  end

  test "should be valid" do
    assert @campaign.valid?
  end

  test "title shouldn't be blank" do
    @campaign.title = blank
    assert_not @campaign.valid?
  end

  test "description shouldn't be blank" do
    @campaign.description = blank
    assert_not @campaign.valid?
  end

  test "budget amount shouldn't be negative" do
    @campaign.budget = negative_number
    assert_not @campaign.valid?
  end

  test "start date shouldn't be blank" do
    @campaign.start_date = blank
    assert_not @campaign.valid?
  end

  test "end date shouldn't be blank" do
    @campaign.end_date = blank
    assert_not @campaign.valid?
  end

  test "start date shouldn't be after end date" do
    @campaign.start_date = @campaign.end_date + 1.day
    assert_not @campaign.valid?
  end

  test "should be open for voting" do
    assert @campaign.open?
    travel 1.day
    assert @campaign.open?
  end

  test "should be pending" do
    travel_to 1.week.ago
    assert @campaign.pending?
  end

  test "should be finished, closed for voting" do
    travel 1.week
    assert @campaign.closed?
  end
end
