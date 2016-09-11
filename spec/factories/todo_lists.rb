FactoryGirl.define do
  factory :todo_list do
    name
    team_id { generate(:uuid) }
    project_id { generate(:uuid) }
    creator_id { generate(:uuid) }
  end
end
