module Feeder
  class Configuration
    attr_accessor :scopes
    attr_accessor :test_mode

    def initialize
      @test_mode = false
      @scopes = [
        proc { unblocked },
        proc { order created_at: :desc }
      ]
    end
  end
end
