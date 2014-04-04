require "feeder/engine"
require "feeder/configuration"
require "feeder/concerns"
require "feeder/active_record"
require "kaminari"

module Feeder

  class << self
    def config
      @configuration ||= Feeder::Configuration.new
    end

    def configure
      raise ArgumentError, "No block provided" unless block_given?

      yield config
    end

    # Set temporary configuration options for the duration of the given block.
    #
    # options - A Hash describing temporary configuration options.
    def temporarily options = {}
      original = @configuration.dup

      options.each do |key, value|
        @configuration.send "#{key}=", value
      end

      yield
    ensure
      @configuration = original
    end
  end

end
