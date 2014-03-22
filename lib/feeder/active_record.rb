module Feeder::ActiveRecord
  module Extensions
    def feedable
      include Feeder::Concerns::Feedable
    end
  end
end

::ActiveRecord::Base.send :extend, Feeder::ActiveRecord::Extensions if defined?(ActiveRecord)
