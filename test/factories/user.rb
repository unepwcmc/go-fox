FactoryBot.define do
  factory :user do
    sequence(:email){|n| "user#{n}@test.com" }
    organisation_name "UNEP-WCMC"
    username "Informatics"
    password "test1234"
    password_confirmation "test1234"
    admin false
  end

  factory :admin, class: User do
    sequence(:email){|n| "admin#{n}@test.com" }
    organisation_name "UNEP-WCMC"
    username "Informatics"
    password "test1234"
    password_confirmation "test1234"
    admin true
  end
end
