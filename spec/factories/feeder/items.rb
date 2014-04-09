FactoryGirl.define do

  factory :feeder_item, class: 'Feeder::Item' do
    feedable nil

    trait(:published) { published_at 1.day.ago }
    trait(:sticky)    { sticky true }
  end

end
