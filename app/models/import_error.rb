class ImportError < ApplicationRecord
  belongs_to :csv_upload
  validates_presence_of :error_message, :row_number
end
