FactoryGirl.define do

  factory :feeder_report, class: 'Feeder::Report' do
    association :item, factory: :feeder_item

    trait(:handled)           { handled_at 1.day.ago }
    trait(:unhandled)         { handled_at nil }
    trait(:handled_in_future) { handled_at 1.day.from_now }
  end

end
