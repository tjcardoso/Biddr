FactoryGirl.define do
  factory :bid do
    # amount 1
    # user nil
    # auction nil
    association :user, factory: :user
    association :campaign, factory: :campaign

    amount { 105 + rand(10) }
  end
end
