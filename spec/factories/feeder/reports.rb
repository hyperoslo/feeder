FactoryGirl.define do

  factory :feeder_report, class: 'Feeder::Report' do
    association :item, factory: :feeder_item
  end

end
