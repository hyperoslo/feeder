require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController
    def index
      @items = Item.order published_at: :desc
    end
  end
end
