require_dependency "feeder/application_controller"

module Feeder
  class FeedsController < ApplicationController
    def index
      @items = Item.order(sticky: :desc)

      Feeder.config.scopes.each do |scope|
        @items = @items.instance_eval &scope
      end

      @items = @items.page(params[:page] || 1)
      @items = @items.per(params[:limit] || 25)
    end
  end
end
