require "feeder/engine"
require "feeder/configuration"
require "feeder/concerns"
require "feeder/active_record"
require "feeder/authorization_adapters"
require "kaminari"

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
