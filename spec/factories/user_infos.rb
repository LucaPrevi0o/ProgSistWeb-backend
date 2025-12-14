FactoryBot.define do
  factory :user_info do
    user { nil }
    full_name { "MyString" }
    phone { "MyString" }
    country { "MyString" }
    address { nil }
  end
end
