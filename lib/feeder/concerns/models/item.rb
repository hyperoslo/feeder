module Feeder
  module Concerns::Models::Item
    extend ActiveSupport::Concern

    included do
      include Feeder::Concerns::Helpers::Filter

      belongs_to :feedable, polymorphic: true

      def type
        feedable_type.underscore
      end
    end
  end
end
