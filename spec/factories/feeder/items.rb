FactoryGirl.define do

  factory :feeder_item, class: 'Feeder::Item' do
    feedable nil

    trait(:published)         { published_at 1.day.ago }
    trait(:not_published)     { published_at nil }
    trait(:not_yet_published) { published_at 1.day.from_now }
    trait(:sticky)            { sticky true }
    trait(:recommended)       { recommended true }

    trait :reported do
      after :build do |item|
        item.reports << build(:feeder_report, item: item)
      end
    end
  end

end
