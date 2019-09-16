require 'rails_helper'

RSpec.describe ImportError, type: :model do
  it "is valid with valid attributes" do
    import_error = build(:import_error)
    expect(import_error.valid?).to eq(true)
  end

  it "is invalid without an error message" do
    import_error = build(:import_error, error_message: nil)
    expect(import_error.valid?).to eq(false)
  end

  it "is invalid without a row number" do
    import_error = build(:import_error, row_number: nil)
    expect(import_error.valid?).to eq(false)
  end

  it "is invalid without a csv upload" do
    import_error = build(:import_error, csv_upload: nil)
    expect(import_error.valid?).to eq(false)
  end
end
