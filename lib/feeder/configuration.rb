module Feeder
  class Configuration
    attr_accessor :scopes
    attr_reader :observables

    def initialize
      @scopes = [
        proc { order created_at: :desc }
      ]

      @observables   = []
    end

    def add_observable(observable)
      @observables << observable
    end
  end
end
