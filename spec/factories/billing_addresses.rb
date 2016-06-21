FactoryGirl.define do
  factory :billing_address do
    firstname "MyString"
    lastname "MyString"
    company "MyString"
    address "MyText"
    zip 1
    city "MyString"
    province "MyString"
    state "MyString"
    telephone "MyString"
    email "MyString"
    vat "MyString"
    order nil
    cart nil
  end
end
