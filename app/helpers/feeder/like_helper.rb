module Feeder
  module LikeHelper
    def valid_like_scope? scope
      Feeder.config.like_scopes.include? scope.to_sym
    end
  end
end
