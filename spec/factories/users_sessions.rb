FactoryGirl.define do
  factory :users_session do
    user nil
    action "MyString"
    authentication "direct"
  end

end
