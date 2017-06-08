require 'test_helper'

class DateParserTest < ActiveSupport::TestCase
  test "parses iso format" do
    iso_format = '2017-12-31'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(iso_format)
  end

  test "parses european format" do
    european_format = '31/12/2017'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(european_format)
  end

  test "parses american format when there is no ambiguity" do
    american_format_without_ambiguity = '12/31/2017'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(american_format_without_ambiguity)
  end

  test "parses american format as european when there is ambiguity" do
    american_format_with_ambiguity = '12/01/2017'
    assert_equal Date.new(2017, 1, 12), DateParser.parse(american_format_with_ambiguity)
    assert_not_equal Date.new(2017, 12, 1), DateParser.parse(american_format_with_ambiguity)
  end

  test "parses short year format" do
    short_year_format = '31/12/17'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(short_year_format)
  end

  test "parses previous century short year format" do
    past_century_short_year_format = '31/12/73'
    assert_equal Date.new(1973, 12, 31), DateParser.parse(past_century_short_year_format)
  end

  test "parses formats with single digits" do
    single_digit_format = '1/1/17'
    assert_equal Date.new(2017, 1, 1), DateParser.parse(single_digit_format)
  end

  test "parses formats using dashes as separators" do
    format_with_dashes = '31-12-2017'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(format_with_dashes)
  end

  test "parses formats using underscores as separators" do
    format_with_underscores = '31_12_2017'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(format_with_underscores)
  end

  test "parses formats using spaces as separators" do
    format_with_spaces = '31 12 2017'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(format_with_spaces)
  end

  test "parses formats with no separators" do
    format_with_no_separators = '311217'
    assert_equal Date.new(2017, 12, 31), DateParser.parse(format_with_no_separators)
  end
end
