class Record < ApplicationRecord
  belongs_to :csv_upload

  validates :phone, phone: { possible: true, message: 'number must be valid' }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be valid' }
  validates :first, :last, length: { minimum: 2, allow_blank: true, message: 'name should be at least 2 characters long' }
  validates_format_of :first, :last, { with: /\A[a-zA-Z]*\z/, message: 'can only be letters' }
  validate :last_without_first

  before_create :strip_phone_punctuation

  def last_without_first
    if self.first.nil? && !self.last.nil?
      errors.add(:last, "can't be present without a first name")
    end
  end

  def strip_phone_punctuation
    self.phone = self.phone.gsub(/[^0-9]/, '')
  end
end
