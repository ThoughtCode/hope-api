FactoryBot.define do
  factory :invoice_detail do
    email { "MyString" }
    identification { "MyString" }
    identification_type { 1 }
    social_reason { "MyString" }
    address { "MyString" }
    telephone { "MyString" }
  end
end
