require "responders"

class AppResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder
end

module Feeder
  class ApplicationController < ::ApplicationController
    self.responder = AppResponder
  end
end
