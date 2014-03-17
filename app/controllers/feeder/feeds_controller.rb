require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController
    def index
      @items = Item.order Feeder.config.sort_order
    end
  end
end
