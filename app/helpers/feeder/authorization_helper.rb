module Feeder
  module AuthorizationHelper
    def can_recommend?(item)
      authorization_adapter.authorized? :recommend, item
    end

    def can_like?(item)
      authorization_adapter.authorized? :like, item
    end

    def authorization_adapter
      Feeder.config.authorization_adapter.new send(Feeder.config.current_user_method)
    end
  end
end
