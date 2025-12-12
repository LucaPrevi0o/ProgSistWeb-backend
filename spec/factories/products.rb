FactoryBot.define do
  factory :product do
    name { "MyString" }
    description { "MyText" }
    price { "9.99" }
    category { "MyString" }
    image_url { "MyString" }
    stock_quantity { 1 }
  end
end
