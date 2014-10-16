module Feeder
  module LikeHelper
    def valid_like_scope? scope
      Feeder.config.like_scopes.include? scope.to_sym
    end

    def like_scopes
      Feeder.config.like_scopes
    end

    def liker
      send(Feeder.config.current_user_method)
    end
  end
end
