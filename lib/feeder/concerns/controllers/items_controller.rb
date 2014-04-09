module Feeder
  module Concerns::Controllers::ItemsController
    extend ActiveSupport::Concern

    included do
      respond_to :html, :json

      def index
        @items = Item.order(sticky: :desc)

        Feeder.config.scopes.each do |scope|
          @items = @items.instance_eval &scope
        end

        @items = @items.page(params[:page] || 1)
        @items = @items.per(params[:limit] || 25)

        respond_with @items
      end
    end
  end
end
