# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    question "What is your name?"
    course_id 1
    explanation "your name is what people call you"
    image nil
  end
end
