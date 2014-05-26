module Feeder
  module Concerns::Models::Item
    extend ActiveSupport::Concern

    included do
      include Feeder::Concerns::Helpers::Filter

      belongs_to :feedable, polymorphic: true

      def type
        feedable_type.underscore
      end

      def report
        self.update reported: true
      end

      def block
        self.update blocked: true
      end

      def unreport
        self.update reported: false
      end

      def unblock
        self.update blocked: false
      end
    end
  end
end
