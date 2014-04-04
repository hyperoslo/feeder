require "feeder/engine"
require "feeder/configuration"

module Feeder

  class << self
    def config
      @configuration ||= Feeder::Configuration.new
    end

    def configure
      yield config if block_given?
    end
  end

end
