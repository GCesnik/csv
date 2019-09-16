require 'rails_helper'

RSpec.describe CsvUpload, type: :model do
  it "is valid with valid attributes" do
    csv_upload = build(:csv_upload)
    expect(csv_upload.valid?).to eq(true)
  end

  it "is invalid without a csv file" do
    csv_upload = build(:csv_upload, identifier: nil)
    expect(csv_upload.valid?).to eq(false)
  end

  it "is invalid without an identifier" do
    csv_upload = build(:csv_upload, csv: nil)
    expect(csv_upload.valid?).to eq(false)
  end
end
