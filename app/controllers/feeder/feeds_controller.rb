require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController
    def index
      @items = Item.order(sticky: :desc).order(Feeder.config.sort_order)

      if params[:limit]
        @items = @items.limit params[:limit]
      else
        @items = @items.limit Feeder.config.default_limit
      end
    end
  end
end
