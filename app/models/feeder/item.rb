module Feeder
  class Item < ActiveRecord::Base
    belongs_to :feedable, polymorphic: true

    def type
      feedable_type.underscore
    end
  end
end
