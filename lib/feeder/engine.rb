require 'rails-observers'

module Feeder
  class Engine < ::Rails::Engine
    isolate_namespace Feeder

    initializer 'tasks.factories', after: 'factory_girl.set_factory_paths' do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end
  end
end
