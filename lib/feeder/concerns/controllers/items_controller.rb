module Feeder
  module Concerns::Controllers::ItemsController
    extend ActiveSupport::Concern

    included do
      include AuthorizationHelper

      respond_to :html, :json

      before_action :set_item, only: [:recommend, :unrecommend]

      def index
        @items = Item.order(sticky: :desc)

        Feeder.config.scopes.each do |scope|
          @items = @items.instance_eval &scope
        end

        @items = @items.page(params[:page] || 1)
        @items = @items.per(params[:limit] || 25)

        respond_with @items
      end

      def recommend
        if can_recommend? @item
          @item.recommend
        else
          flash[:error] = I18n.t("feeder.views.unauthorized")
        end

        redirect_to :back
      end

      def unrecommend
        if can_recommend? @item
          @item.unrecommend
        else
          flash[:error] = I18n.t("feeder.views.unauthorized")
        end

        redirect_to :back
      end

      protected

      def set_item
        @item = Item.find params[:id]
      end
    end
  end
end
