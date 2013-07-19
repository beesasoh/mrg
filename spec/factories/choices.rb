# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    choice "your name is me"
    correct false
    question_id 1
  end
end
