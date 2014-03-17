module Feeder
  class FeedableObserver < ActiveRecord::Observer
    observe [ 'Message' ]

    def after_create(feedable)
      Feeder::Item.create!(
        feedable: feedable,
        created_at: feedable.created_at,
        published_at: Time.zone.now
      )
    end
  end
end
