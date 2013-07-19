# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    cost 100
    level "1"
    title "sample course"
    author_id 3
    subject_id 8
    published false
  end
end
