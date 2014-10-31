module Feeder
  class Report < ::ActiveRecord::Base
    include Feeder::Concerns::Models::Report
  end
end
