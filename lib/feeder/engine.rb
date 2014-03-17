require 'rails-observers'

module Feeder
  class Engine < ::Rails::Engine
    isolate_namespace Feeder

    config.active_record.observers ||= []
    config.active_record.observers << 'Feeder::FeedableObserver'
  end
end
