FactoryGirl.define do
  factory :comment do
    content
    team_id { generate(:uuid) }
    author_id { generate(:uuid) }
    commentable_id { generate(:uuid) }
    commentable_type "Todo"
  end
end
