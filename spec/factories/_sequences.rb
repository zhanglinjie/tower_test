FactoryGirl.define do
  sequence(:name, aliases: [:nickname]) { |n| "name_#{n}"}
  sequence(:content) { |n| "content_#{n}"}
  sequence(:email){ |n| "email_#{n}@test.com"}
  sequence(:uuid){ |n| SecureRandom.uuid }
  sequence(:phone, aliases: [:telephone]) { |n| "12345678%.04d" % n}
end
