module Feeder
  class Item < ::ActiveRecord::Base
    include Feeder::Concerns::Helpers::Filter

    belongs_to :feedable, polymorphic: true

    def type
      feedable_type.underscore
    end
  end
end
