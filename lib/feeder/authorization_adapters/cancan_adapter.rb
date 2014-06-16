module Feeder
  module AuthorizationAdapters
    class CanCanAdapter < Base
      def authorized?(action, subject = nil)
        cancan_ability.can?(action, subject)
      end

      def cancan_ability
        @cancan_ability ||= initialize_cancan_ability
      end

      private

      def initialize_cancan_ability
        klass = Feeder.config.cancan_ability_class

        if klass.is_a? String
          klass = klass.constantize
        end

        klass.new @user
      end
    end
  end
end
