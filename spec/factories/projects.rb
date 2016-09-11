FactoryGirl.define do
  factory :project do
    name
    team_id { generate(:uuid) }
    creator_id { generate(:uuid) }
  end
end
