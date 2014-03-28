require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController
    def index
      @items = Item.order(sticky: :desc)

      Feeder.config.scopes.each do |scope|
        @items = @items.instance_eval &scope
      end

      if params[:limit]
        @items = @items.limit params[:limit]
      end
    end
  end
end
