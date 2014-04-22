FactoryGirl.define do

  factory :user do
          sequence(:email) { |n| "user#{n}@ticketee.com" }
          sequence(:name) { |n| "User #{n}"}
          password "password"
          password_confirmation "password"
  end

  factory :task do
    name "Hello World"
    summary "This is a task"
  end

end