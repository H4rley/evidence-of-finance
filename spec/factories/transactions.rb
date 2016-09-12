FactoryGirl.define do
  factory :transaction do
    user nil
    category nil
    account nil
    purpose "Bike"
    sum 9.99
    movement "input"
  end

end
