module Feeder::Concerns::Feedable
  extend ActiveSupport::Concern

  included do
    attr_accessor :sticky

    has_one :feeder_item, as: :feedable, class_name: 'Feeder::Item', dependent: :destroy

    with_options unless: -> { Feeder.config.test_mode } do |klass|
      klass.after_create :_create_feeder_item
      klass.after_save :_update_feeder_item
    end

    delegate :block, :unblock, :blocked?, :report, :unreport, :reported?, to: :feeder_item

    def sticky
      if feeder_item
        feeder_item.sticky
      else
        !!@sticky
      end
    end

    def sticky= value
      @sticky = value

      if feeder_item
        feeder_item.sticky = value
      end
    end
  end

  private

  def _create_feeder_item
    condition = self.class.feedable_options.try(:[], :if)

    if condition
      if condition.respond_to? :call
        return unless condition.call self
      else
        return unless send condition
      end
    end

    create_feeder_item! do |item|
      item.feedable     = self
      item.created_at   = created_at
      item.published_at = Time.zone.now

      if respond_to? :sticky
        item.sticky = sticky
      end
    end
  end

  def _update_feeder_item
    if feeder_item && respond_to?(:sticky)
      feeder_item.update!(sticky: sticky)
    end
  end
end
