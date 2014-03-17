require "feeder/engine"
require "feeder/configuration"

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
