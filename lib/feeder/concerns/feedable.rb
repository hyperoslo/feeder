module Feeder::Concerns::Feedable
  extend ActiveSupport::Concern

  included do
    attr_accessor :sticky

    has_one :feeder_item, as: :feedable, class_name: 'Feeder::Item', dependent: :destroy

    def sticky
      if feeder_item
        feeder_item.sticky
      else
        @sticky
      end
    end

    def sticky= value
      @sticky = value

      if feeder_item
        feeder_item.sticky = value
      end
    end
  end
end
