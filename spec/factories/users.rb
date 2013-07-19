# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Beesas0h Fredie "
    oauth_expires_at "2013-08-19 11:56:25"
    oauth_token "niuwhr93rhfiw2fwbvigvwefbweicwgfvwbciwy"
    provider "facebook"
    uid "4346356352534643"
    email "beesasoh@mail.com"
    image "image/path"
    coins 0
    level "2"
  end
end
