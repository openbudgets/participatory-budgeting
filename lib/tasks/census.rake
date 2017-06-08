require 'csv'

namespace :census do
  desc "Import census data from CSV file"
  task import: :environment do
    abort "ERROR: File not present" unless census_exists?
    census_data = File.read(census_file_path)
    csv = CSV.parse(census_data, headers: true)
    csv.each do |row|
      data = build_data_from(row)
      secret_for(data).first_or_create!(data: data) unless no_document_on?(row)
    end
  end

  desc "Clean up current census data"
  task cleanup: :environment do
    STDOUT.print "Are you sure you want to erase the existing census data? (y/N): "
    response = STDIN.gets.chomp
    abort "Aborting." unless response.upcase == 'Y'
    VoterSecret.delete_all
  end

  desc "Update census data"
  task update: [:cleanup, :import]
end

def census_exists?
  File.exists?(census_file_path)
end

def census_file_path
  Rails.root.join('theme', 'data', 'census.csv')
end

def build_data_from(row)
  document_number = row[1]
  document_letter = row[2]

  {
    'document' => DocumentNumberParser.parse("#{document_number}#{document_letter}"),
    'birth_date' => Date.parse(row[3]).to_s
  }
end

def secret_for(data)
  VoterSecret.where("data = :data", data: hstore(data))
end

def no_document_on?(row)
  row[1].blank?
end

def hstore(hash)
  hash.to_s[1...-1]
end
