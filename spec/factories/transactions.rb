FactoryBot.define do
  factory :transaction do
    user_id 1
    credit_card_id 1
    amount "MyString"
    description "MyString"
    vat "MyString"
    status 1
    payment_date ""
    authorization_code "MyString"
    installments "MyString"
    message "MyString"
    carrier_code "MyString"
    status_detail 1
  end
end
