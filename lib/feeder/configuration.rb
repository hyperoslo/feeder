module Feeder
  class Configuration
    attr_accessor :sort_order
    attr_reader :observables

    def initialize
      @sort_order = { created_at: :desc }
      @observables = []
    end

    def add_observable(observable)
      @observables << observable
    end
  end
end
