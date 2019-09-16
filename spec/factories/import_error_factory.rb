FactoryBot.define do
  factory :import_error do
    csv_upload
    row_number { 1 }
    error_message { "Error"}
  end
end