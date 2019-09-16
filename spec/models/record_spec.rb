require 'rails_helper'

RSpec.describe Record, type: :model do
  it "is valid with valid attributes" do
    record = build(:record)
    expect(record.valid?).to eq(true)
  end

  it "is invalid without a valid phone number" do
    record = build(:record, phone: '111')
    expect(record.valid?).to eq(false)
  end

  it "is valid with different format numbers" do
    record = build(:record, phone: '123.456-8888')
    expect(record.valid?).to eq(true)
  end

  it "is valid with different format numbers" do
    record = build(:record, phone: '87644.45523')
    expect(record.valid?).to eq(true)
  end

  it "is invalid without a valid phone number" do
    record = build(:record, phone: nil)
    expect(record.valid?).to eq(false)
  end

  it "is invalid without a valid email" do
    record = build(:record, email: nil)
    expect(record.valid?).to eq(false)
  end

  it "is invalid without a valid email" do
    record = build(:record, email: 'efefef')
    expect(record.valid?).to eq(false)
  end

  it "first name must be more than 2 characters if it is set" do
    record = build(:record, first: 'a')
    expect(record.valid?).to eq(false)
  end

  it "last name must be more than 2 characters if it is set" do
    record = build(:record, last: 'a')
    expect(record.valid?).to eq(false)
  end

  it "last name must be characters" do
    record = build(:record, last: '323')
    expect(record.valid?).to eq(false)
  end

  it "first name must be characters" do
    record = build(:record, last: '323')
    expect(record.valid?).to eq(false)
  end

  it "cant have a last name if no first is set" do
    record = build(:record, first: nil)
    expect(record.valid?).to eq(false)
  end
end