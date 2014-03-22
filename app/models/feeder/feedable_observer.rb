module Feeder
  class FeedableObserver < ::ActiveRecord::Observer
    observe Feeder.config.observables

    def after_create(feedable)
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

      item.sticky = feedable.sticky
      item.save!
    end
  end
end
