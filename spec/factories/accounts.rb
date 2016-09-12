FactoryGirl.define do
  factory :account do
    name "MyString"
    send_notifications false
    critical_amount 1
    sum 100
  end

end
