require 'test_helper'

class Admin::RoleTest < ActiveSupport::TestCase
  def some_valid_email; "someone@some.tld"; end
  def some_invalid_email; "someone.some.tld"; end
  def some_valid_domain; "@someone.some.tld"; end

  setup do
    @role = Admin::Role.new(email: some_valid_email)
  end

  test "should be valid" do
    assert @role.valid?
  end

  test "email should be valid" do
    @role.email = some_invalid_email
    assert_not @role.valid?
  end

  test "email shouldn't be blank" do
    @role.email = blank
    assert_not @role.valid?
  end

  test "email can be just a domain" do
    @role.email = some_valid_domain
    assert @role.valid?
  end
end