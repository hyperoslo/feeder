module Feeder
  module Concerns::Controllers::ItemsController
    extend ActiveSupport::Concern

    included do
      include AuthorizationHelper
      include LikeHelper

      respond_to :html, :json

      before_action :set_item, only: [:recommend, :unrecommend, :like, :unlike, :report]

      helper_method :can_recommend?

      def index
        @items = Item.order(sticky: :desc)

        custom_scopes

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
        respond_with @item if vote(@item, :vote_by)
      end

      def unlike
        respond_with @item if vote(@item, :unvote)
      end

      def report
        @item.report get_current_user

        flash[:notice] = I18n.t("feeder.views.liked")

        redirect_to :back
      end

      protected

      def get_current_user
        @current_user ||= send Feeder.config.current_user_method
      end

      def vote(item, method)
        if can_like? item
          if params[:like_scope]
            if valid_like_scope? params[:like_scope]
              item.send(method, voter: liker, vote_scope: params[:like_scope])
            else
              head :bad_request
              return false
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
      end

      def set_item
        @item = Item.find params[:id]
      end

      def custom_scopes
        @items = @items.unblocked.order created_at: :desc
      end
    end
  end
end
