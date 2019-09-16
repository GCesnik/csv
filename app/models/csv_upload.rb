class CsvUpload < ApplicationRecord

  mount_uploader :csv, CsvUploader

  validates_presence_of :csv, :identifier

  after_create :start_import_worker

  has_many :records, dependent: :destroy
  has_many :import_errors, dependent: :destroy

  def start_import_worker
    RecordsWorker.perform_async(self.id)
  end
end
