class DateParser
  CANONICAL_SEPARATOR = '-'.freeze

  def self.parse(string)
    new(string).parse
  end

  def parse
    normalize_separators!
    normalize_short_year!

    convert_date if looks_like_an_american_date?

    Date.parse(@string)
  end

  private

  def initialize(string)
    @string = string
  end

  def normalize_separators!
    @string.tr!('/', CANONICAL_SEPARATOR)
    @string.tr!('_', CANONICAL_SEPARATOR)
    @string.tr!(' ', CANONICAL_SEPARATOR)

    add_separators! if no_separators_present?
  end

  def add_separators!
    day = @string[0..1]
    month = @string[2..3]
    year = @string[4..-1]

    @string = build_date(day, month, year)
  end

  def normalize_short_year!
    day, month, year = @string.split(CANONICAL_SEPARATOR)

    day, year = year, day if looks_like_year?(day)

    return unless short_year?(year)

    year = long_year_for(year)

    @string = build_date(day, month, year)
  end

  def no_separators_present?
    @string.match(/\d{6}\d{2}*/)
  end

  def looks_like_an_american_date?
    (1..12) === @string[0..1].to_i && (13..31) === @string[3..4].to_i
  end

  def convert_date
    @string[0..1], @string[3..4] = @string[3..4], @string[0..1]
  end

  def looks_like_year?(day)
    day.to_i > 31
  end

  def short_year?(year)
    year.size == 2
  end

  def long_year_for(short_year)
    current_short_year = Time.zone.today.year % 100
    current_short_century = Time.zone.today.year / 100
    short_century = short_year.to_i <= current_short_year ? current_short_century : current_short_century - 1
    "#{short_century}#{short_year}"
  end

  def build_date(day, month, year, separator=CANONICAL_SEPARATOR)
    [day, month, year].join(separator)
  end
end
