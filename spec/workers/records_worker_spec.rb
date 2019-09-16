require 'rails_helper' # include in your RSpec file
require 'sidekiq/testing' #include in your Rspec file
Sidekiq::Testing.fake! #include in your RSpec file
RSpec.describe RecordsWorker, type: :worker do
  let(:scheduled_job) { described_class.perform_at(time, 'Awesome', true) }
  describe 'testing worker' do
    it 'RecordsWorker jobs are enqueued in the default queue' do
      described_class.perform_async
      assert_equal 'default', described_class.queue
    end
    it 'goes into the jobs array for testing environment' do
      expect do
        described_class.perform_async(1)
      end.to change(described_class.jobs, :size).by(1)
      
    end

    it 'adds records into the database' do
      csv_upload = create(:csv_upload)
      expect do
        described_class.new.perform(csv_upload.id)
      end.to change(Record, :count).by(3)
    end

    it 'adds errors into the database' do
      csv_upload = create(:csv_upload)
      expect do
        described_class.new.perform(csv_upload.id)
      end.to change(ImportError, :count).by(3)
    end
  end
end