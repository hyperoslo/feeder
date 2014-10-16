module Feeder
  module Concerns::Controllers::ItemsController
    extend ActiveSupport::Concern

    included do
      include AuthorizationHelper
      include LikeHelper

      respond_to :html, :json

      before_action :set_item, only: [:recommend, :unrecommend, :like, :unlike]

      helper_method :can_recommend?

      def index
        @items = Item.order(sticky: :desc)

        Feeder.config.scopes.each do |scope|
          @items = @items.instance_eval &scope
        end

        @items = @items.kaminari_page(params[:page] || 1)
        @items = @items.per(params[:limit] || 25)

        respond_with @items
      end

      def recommend
        if can_recommend? @item
          @item.recommend
          flash[:notice] = I18n.t("feeder.views.recommended")
        else
          flash[:error] = I18n.t("feeder.views.unauthorized")
        end

        redirect_to :back
      end

      def unrecommend
        if can_recommend? @item
          @item.unrecommend
          flash[:notice] = I18n.t("feeder.views.unrecommended")
        else
          flash[:error] = I18n.t("feeder.views.unauthorized")
        end

        redirect_to :back
      end

      def like
        vote(@item, :vote_by)
      end

      def unlike
        vote(@item, :unvote)
      end

      protected

      def vote(item, method)
        if can_like? item
          if params[:like_scope]
            if valid_like_scope? params[:like_scope]
              item.send(method, voter: liker, vote_scope: params[:like_scope])
            end
          else
            item.send(method, voter: liker)
          end

          case method
          when :vote_by
            flash[:notice] = I18n.t("feeder.views.liked")
          when :unvote
            flash[:notice] = I18n.t("feeder.views.unliked")
          end
        else
          flash[:error] = I18n.t("feeder.views.unauthorized")
        end

        redirect_to :back
      end

      def liker
        send(Feeder.config.current_user_method)
      end

      def set_item
        @item = Item.find params[:id]
      end
    end
  end
end
