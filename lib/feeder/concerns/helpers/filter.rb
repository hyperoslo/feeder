module Feeder
  module Concerns::Helpers::Filter
    extend ActiveSupport::Concern

    included do
      scope :filter, ->(options) {
        args = []
        wheres = options.each.map do |feedable, ids|
          ids = feedable.pluck :id if ids == :all

          args << feedable << ids

          "(feedable_type = ? AND feedable_id IN (?))"
        end.join " OR "

        where(wheres, *(args))
      }
    end
  end
end
