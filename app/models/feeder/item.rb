require 'kaminari/config'
require 'kaminari/models/page_scope_methods'
require 'kaminari/models/configuration_methods'
require 'kaminari/models/active_record_model_extension'

module Feeder
  class Item < ::ActiveRecord::Base
    include Feeder::Concerns::Models::Item
    include Kaminari::ActiveRecordModelExtension

    singleton_class.send(:alias_method, :kaminari_page, :page)
  end
end
