# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    score 50
    subject_id 1
    user_id 1
    course_id 1
  end
end
