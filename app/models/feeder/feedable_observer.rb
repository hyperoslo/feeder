module Feeder
  class FeedableObserver < ::ActiveRecord::Observer
    observe Feeder.config.observables.keys

    def after_create(feedable)
      options = options_for feedable

      if condition = options[:if]
        return unless condition.call feedable
      end

      feedable.create_feeder_item! do |item|
        item.feedable     = feedable
        item.created_at   = feedable.created_at
        item.published_at = Time.zone.now

        if feedable.respond_to? :sticky
          item.sticky = feedable.sticky
        end
      end
    end

    def after_save(feedable)
      item = feedable.feeder_item

      if item
        if feedable.respond_to? :sticky
          item.sticky = feedable.sticky
        end

        item.save!
      end
    end

    private

    def options_for(feedable)
      (observables[feedable.class] || observables[feedable.class.to_s]) or raise StandardError, "#{feedable} is not observed"
    end

    def observables
      Feeder.config.observables
    end
  end
end
