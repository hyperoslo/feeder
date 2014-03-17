class Message < ActiveRecord::Base
  has_one :feeder_item, as: :feedable, class_name: 'Feeder::Item'
end
