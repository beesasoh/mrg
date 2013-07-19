# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	sequence :subj_name do |n|
		"subject0#{n}"
	end
  factory :subject do
    name "Chemistry"
    image_thumb File.new("#{Rails.root}/app/assets/images/avatar.png")
  end

  factory :subject_random, class: Subject do
    name { generate(:subj_name) }
    image_thumb File.new("#{Rails.root}/app/assets/images/avatar.png")
  end
end




