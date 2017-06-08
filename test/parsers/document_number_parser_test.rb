require 'test_helper'

class DocumentNumberParserTest < ActiveSupport::TestCase
  test "parses document numbers with dash separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888-B')
  end

  test "parses document numbers with underscore separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888_B')
  end

  test "parses document numbers with slash separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888/B')
  end

  test "parses document numbers with dot separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888.B')
  end

  test "parses document numbers with pipe separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888|B')
  end

  test "parses document numbers with space separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse('54999888 B')
  end

  test "parses document numbers with quote separators" do
    document_number = '54999888B'
    assert_equal document_number, DocumentNumberParser.parse("54999888'B")
  end

  test "parses document numbers with leading zeroes" do
    document_number = '4999888X'
    assert_equal document_number, DocumentNumberParser.parse('04999888X')
  end

  test "parses document numbers with mixed case letters" do
    document_number = 'Y4999888R'
    assert_equal document_number, DocumentNumberParser.parse('Y4999888r')
  end
end
