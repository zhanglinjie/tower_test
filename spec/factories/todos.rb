FactoryGirl.define do
  factory :todo do
    name
    team_id { generate(:uuid) }
    project_id { generate(:uuid) }
    todo_list_id { generate(:uuid) }
    creator_id { generate(:uuid) }
  end
end
