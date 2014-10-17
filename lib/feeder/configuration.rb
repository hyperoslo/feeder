module Feeder
  class Configuration
    attr_accessor :scopes
    attr_accessor :authorization_adapter
    attr_accessor :current_user_method
    attr_accessor :observables
    attr_accessor :test_mode

    def initialize
      @test_mode             = false
      @observables           = {}
      @authorization_adapter = Feeder::AuthorizationAdapters::Base
      @current_user_method   = "current_user"
    end

    def add_observable(observable)
      warn "[DEPRECATION] Feeder::Configuration.add_observable is deprecated. Please use Feeder::Configuration.observe instead."

      observe observable
    end

    # Add an observable.
    #
    # observable - A model to observe.
    # options    - A Hash of options:
    #              :if - A lambda returning a boolean whether to create a feed item.
    def observe(observable, options = {})
      @observables[observable] = options
    end
  end
end
