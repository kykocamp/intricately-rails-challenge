FactoryBot.define do
  factory :hostname do
    dns_record { create(:dns_record) }
    hostname { Faker::Internet.domain_name }
  end
end
