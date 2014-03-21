module Feeder
  class Configuration
    attr_accessor :sort_order, :default_limit
    attr_reader :observables

    def initialize
      @sort_order    = { created_at: :desc }
      @default_limit = 25
      @observables   = []
    end

    def add_observable(observable)
      @observables << observable
    end
  end
end
