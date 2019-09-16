FactoryBot.define do
  factory :record do
    first {'Greg'}
    last {'Cesnik'}
    phone {'7654321718'}
    email {'greg.cesnik@gmail.com'}
    csv_upload
  end
end