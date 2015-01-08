module Feeder
  module AuthorizationAdapters
    class Base
      attr_reader :user
      
      # Initialize with a given user.
      #
      # user - Any model representing a user.
      def initialize user
        @user = user
      end

      # Determine whether the user is authorized.
      #
      # action  - A symbol describing the action. Valid actions are :recommend and :like.
      # subject - Any model representing a model to perform the action on.
      #
      # Returns a Boolean.
      def authorized?(action, subject = nil)
        false
      end
    end
  end
end
