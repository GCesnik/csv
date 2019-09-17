require 'csv'
require 'fog'
require 'open-uri'

class RecordsWorker
  S3_BASE ='https://csv-springbig-uploads.s3.amazonaws.com'.freeze
  include Sidekiq::Worker
  # sidekiq_options retry: false


  def perform(csv_upload_id)
    csv_upload = CsvUpload.find(csv_upload_id)
    raise StandardError, "Could not find csv upload for id: #{csv_upload_id}" unless csv_upload

    if Rails.env.test?
      csv_file = File.open(csv_upload.csv.file.path)
    else
      #Download file from S3
      csv_file = open(csv_upload.csv.file.url)
    end
    line_number = 1 #have to manually keep track of line number now that we can't use foreach

    CSV.parse(csv_file.read, headers: true) do |row|
      new_record = Record.new(row.to_h.merge(csv_upload_id: csv_upload_id))
      unless new_record.save
        new_record.errors.full_messages.each do |error_message|
          ImportError.create(csv_upload_id:csv_upload_id, row_number: line_number, error_message: error_message)
        end
      end
      line_number += 1
    end

    # CSV.foreach(csv_upload.csv.file.path, headers: true) do |row|
    #   local_record = Record.where(row.to_h).first
    #   Record.create(row.to_h.merge(csv_upload_id: csv_upload_id)) unless local_record
    # end
  end
end