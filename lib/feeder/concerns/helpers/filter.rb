module Feeder
  module Concerns::Helpers::Filter
    extend ActiveSupport::Concern

    included do
      scope :filter, ->(*options) {
        args = []
        types = []

        options.each do |opt|
          if opt <= ::ActiveRecord::Base && opt.instance_of?(Class) # Model class name as argument
            types << opt.name
          elsif 0
          end
        end

        wheres = []
        unless types.empty?
          wheres << "(feedable_type in (?))"
          args << types
        end

        #wheres = options.each.map do |feedable, ids|
        #  ids = feedable.pluck :id if ids == :all
#
        #  args << feedable << ids
#
        #  "(feedable_type = ? AND feedable_id IN (?))"
        #end.join " OR "

        where(wheres.join(" OR "), *(args))
      }
    end
  end
end
