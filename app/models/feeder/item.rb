module Feeder
  class Item < ::ActiveRecord::Base
    belongs_to :feedable, polymorphic: true

    scope :filter, ->(options) {
      args = []
      wheres = options.each.map do |feedable, ids|
        ids = feedable.pluck :id if ids == :all

        args << feedable << ids

        "(feedable_type = ? AND feedable_id IN (?))"
      end.join " OR "

      # Okay, there has to be a prettier way to do this ...
      where(wheres, *(args))
    }

    def type
      feedable_type.underscore
    end
  end
end
