module Feeder
  class Item < ActiveRecord::Base
    belongs_to :feedable, polymorphic: true
  end
end
