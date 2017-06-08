class DocumentNumberParser
  def self.parse(string)
    new(string).parse
  end

  def parse
    remove_separators!
    remove_leading_zeroes!

    @string.upcase
  end

  private

  def remove_separators!
    @string.tr!('-', '')
    @string.tr!('_', '')
    @string.tr!('/', '')
    @string.tr!('.', '')
    @string.tr!('|', '')
    @string.tr!("'", '')
    @string.tr!(' ', '')
  end

  def remove_leading_zeroes!
    @string.gsub!(/^0+/, '')
  end

  def initialize(string)
    @string = string
  end
end
