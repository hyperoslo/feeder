require_dependency "feeder/application_controller"

module Feeder
  class ItemsController < ApplicationController
    include Feeder::Concerns::Controllers::ItemsController
  end
end
