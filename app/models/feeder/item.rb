module Feeder
  class Item < ::ActiveRecord::Base
    include Feeder::Concerns::Models::Item
  end
end
