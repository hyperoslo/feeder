module Feeder::ActiveRecord
  module Extensions
    def feedable(options = nil)
      class_attribute :feedable_options
      self.feedable_options = options

      include Feeder::Concerns::Feedable
    end
  end
end

::ActiveRecord::Base.send :extend, Feeder::ActiveRecord::Extensions if defined?(ActiveRecord)
