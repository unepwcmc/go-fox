FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@test.com" }
    organisation_name "UNEP-WCMC"
    sequence(:username){|n| "Informatics user#{n}" }
    password "test1234"
    password_confirmation "test1234"
    admin false
    org_type "ngo"
  end

  factory :admin, class: User do
    sequence(:email){|n| "admin#{n}@test.com" }
    organisation_name "UNEP-WCMC"
    sequence(:username){|n| "Informatics admin#{n}" }
    password "test1234"
    password_confirmation "test1234"
    admin true
  end
end
