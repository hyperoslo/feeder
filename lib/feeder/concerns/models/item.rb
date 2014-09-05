module Feeder
  module Concerns::Models::Item
    extend ActiveSupport::Concern

    included do
      include Feeder::Concerns::Helpers::Filter

      scope :unblocked, -> { where blocked: false }
      scope :blocked,   -> { where blocked: true }

      belongs_to :feedable, polymorphic: true

      def type
        feedable_type.underscore
      end

      def report
        update reported: true
      end

      def block
        update blocked: true
      end

      def unreport
        update reported: false
      end

      def unblock
        update blocked: false
      end

      def recommend
        self.update recommended: true
      end

      def unrecommend
        self.update recommended: false
      end
    end
  end
end
