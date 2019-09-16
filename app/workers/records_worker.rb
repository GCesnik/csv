require 'csv'

class RecordsWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false


  def perform(csv_upload_id)
    csv_upload = CsvUpload.find(csv_upload_id)
    raise StandardError, "Could not find csv upload for id: #{csv_upload_id}" unless csv_upload


    CSV.foreach(csv_upload.csv.file.path, headers: true).with_index(1) do |row, line_number|
      logger.info row.to_s
      new_record = Record.new(row.to_h.merge(csv_upload_id: csv_upload_id))
      unless new_record.save
        new_record.errors.full_messages.each do |error_message|
          ImportError.create(csv_upload_id:csv_upload_id, row_number: line_number, error_message: error_message)
        end
      end
    end

    # CSV.foreach(csv_upload.csv.file.path, headers: true) do |row|
    #   local_record = Record.where(row.to_h).first
    #   Record.create(row.to_h.merge(csv_upload_id: csv_upload_id)) unless local_record
    # end
  end
end