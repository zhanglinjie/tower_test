FactoryGirl.define do
  factory :team do
    name
    creator_id { generate(:uuid) }
  end
end
