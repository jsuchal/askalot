FactoryGirl.define do
  factory :comment do
    association :author

    text 'Lorem ipsum'

    trait :deleted do
      deleted true
      deletor { self.author }
      deleted_at DateTime.now.in_time_zone
    end
  end
end
