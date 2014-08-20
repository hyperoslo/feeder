module Feeder
  module AuthorizationAdapters
    class CanCanAdapter < Base
      attr_accessor :cancan_ability_class

      def initialize *args
        self.cancan_ability_class = "Ability"

        super
      end

      def authorized?(action, subject = nil)
        cancan_ability.can?(action, subject)
      end

      def cancan_ability
        @cancan_ability ||= initialize_cancan_ability
      end

      private

      def initialize_cancan_ability
        if cancan_ability_class.is_a? String
          klass = cancan_ability_class.constantize
        end

        klass.new @user
      end
    end
  end
end
