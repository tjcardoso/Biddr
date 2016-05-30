FactoryGirl.define do
  factory :auction do
    # title "MyString"
    # description "MyText"
    # end_date "2016-05-30 09:48:23"
    # reserve_price 1
    sequence(:title) {|n| "#{Faker::StarWars.vehicle}-#{n}" }
    description      { Faker::Lorem.paragraph               }
    reserve_price    { 5 + rand(100)                        }
    end_date         { Time.now + rand(8).days              }
  end
end
