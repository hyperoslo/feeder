FactoryGirl.define do

  factory :message do
    sequence(:header) { |n| "#{n}#{n.ordinal} message"    }
    sequence(:body)   { |n| "This is test message ##{n}." }
  end

end
