module Feeder::Concerns::Feedable
  extend ActiveSupport::Concern

  included do
    attr_accessor :sticky
  end
end
