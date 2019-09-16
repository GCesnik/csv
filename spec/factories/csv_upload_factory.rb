FactoryBot.define do
  factory :csv_upload do
    identifier { 'Identifier' }
    csv { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/files/test_csv.csv'))) }
  end
end