module Feeder
  class Configuration
    attr_reader :observables

    def initialize
      @observables = []
    end

    def add_observable(observable)
      @observables << observable
    end
  end
end
