require "feeder/engine"
require "feeder/configuration"
require "feeder/concerns"
require "feeder/active_record"

module Feeder

  class << self
    def config
      @configuration ||= Feeder::Configuration.new
    end

    def configure
      raise ArgumentError, "No block provided" unless block_given?

      yield config
    end
  end

end
