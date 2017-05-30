ENV['RAILS_ENV'] = 'test'
ENV['DEFAULT_LOCALE'] = 'en'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def blank; :""; end
  def not_blank; :something; end
  def zero_or_positive_number; BigDecimal(0); end
  def negative_number; BigDecimal(-1); end
  def some_classifier_id; 1; end
  def several; 3; end
end

class ActionDispatch::IntegrationTest
  def sign_in(voter)
    token = voter.generate_verification_token!
    get verify_voters_path(token: token)
    patch voter_path(voter) unless @response.redirect?
  end
end
