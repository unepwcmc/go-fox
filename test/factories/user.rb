FactoryBot.define do
  factory :user do
    organisation_name "UNEP-WCMC"
    username "Informatics"
    email "test@test.com"
    password "test1234"
    password_confirmation "test1234"
    admin false
  end

  factory :admin, class: User do
    organisation_name "UNEP-WCMC"
    username "Informatics"
    email "test@test.com"
    password "test1234"
    password_confirmation "test1234"
    admin true
  end
end
